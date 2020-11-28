`timescale 1 ns/ 100 ps
module VGAController(     
	input clk, 			// 100 MHz System Clock
	input reset, 		// Reset Signal
	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B,  // Blue Signal Bits
	inout ps2_clk,
	inout ps2_data,
	input enable_switch,
	output led,
	output led2,
	output led3,
	output led4,
	output led5,
	output led6,
	output led7,
	output led8,
	output led9,
	output led10);
	
	// Lab Memory Files Location
	localparam FILES_PATH = "C:/Users/nyehn/Brad_ECE350_Work/FinalProjectFiles/";

	// Clock divider 100 MHz -> 25 MHz
	wire clk25; // 25MHz clock
	wire clk10;
    parameter IDLE = 3'b001, Algorithm = 3'b010, Print = 3'b100;
    reg[2:0] State, Next;
    reg Algorithm_Ready = 1'b0;
    reg Algorithm_Done = 1'b0;
    reg Start_Over = 1'b0;
    


	reg[1:0] pixCounter = 0;      // Pixel counter to divide the clock
    assign clk25 = pixCounter[1]; // Set the clock high whenever the second bit (2) is high
	always @(posedge clk) begin
		pixCounter <= pixCounter + 1; // Since the reg is only 3 bits, it will reset every 8 cycles
	end
    
    
    reg[2:0] ProcessorCounter = 0;      // Pixel counter to divide the clock
    assign clk10 = ProcessorCounter[2]; // Set the clock high whenever the second bit (2) is high
	always @(posedge clk) begin
		ProcessorCounter <= ProcessorCounter + 1; // Since the reg is only 3 bits, it will reset every 8 cycles
	end
    
    
    always @ (posedge clk or negedge reset) begin
        if (reset)
            State <= IDLE;
        else
            State <= Next;
        end
    wire assert_next_state;
    assign assert_next_state = 1'b1;
    reg next_algorithm;
    //register enable_state_1(clk, reset, enable_switch && !assert_next_state, enable_switch, assert_next_state);

    // assign led3 = next_algorithm;
    always @(State or assert_next_state or Algorithm_Done or Start_Over) begin
        case(State)
            IDLE:        if(assert_next_state)  
                                                Next = Algorithm;
                         else                   Next = IDLE;
            Algorithm:   if(Algorithm_Done)     Next = Print;
                         else                   Next = Algorithm;
            Print:       if(Start_Over)         Next = IDLE;
                         else                   Next = Print;
            default                             Next = IDLE;
        endcase
    end

	// VGA Timing Generation for a Standard VGA Screen
	localparam 
		VIDEO_WIDTH = 640,  // Standard VGA Width
		VIDEO_HEIGHT = 480; // Standard VGA Height

	wire active, screenEnd;
	wire[9:0] x;
	wire[8:0] y;
	wire wren;
    wire [31:0] data, address_dmem;
    wire [31:0] q_dmem;

    wire clk_Display;
	assign clk_Display = State[2] || State[0] ? clk25 : 1'b0;

	
	wire reset_display_;
    register reset_display(clk, reset || reset_display_, enable_switch, Algorithm_Done, reset_display_);
	VGATimingGenerator #(
		.HEIGHT(VIDEO_HEIGHT), // Use the standard VGA Values
		.WIDTH(VIDEO_WIDTH))
	Display( 
		.clk25(clk_Display),  	   // 25MHz Pixel Clock
		.reset(reset_display_),		   // Reset Signal
		.screenEnd(screenEnd), // High for one cycle when between two frames
		.active(active),	   // High when drawing pixels
		.hSync(hSync),  	   // Set Generated H Signal
		.vSync(vSync),		   // Set Generated V Signal
		.x(x), 				   // X Coordinate (from left)
		.y(y)); 			   // Y Coordinate (from top)	   

	// Image Data to Map Pixel Location to Color Address
	localparam 
		PIXEL_COUNT = VIDEO_WIDTH*VIDEO_HEIGHT, 	             // Number of pixels on the screen
		PIXEL_ADDRESS_WIDTH = $clog2(PIXEL_COUNT) + 1,           // Use built in log2 command
		BITS_PER_COLOR = 12, 	  								 // Nexys A7 uses 12 bits/color
		PALETTE_COLOR_COUNT = 256, 								 // Number of Colors available
		PALETTE_ADDRESS_WIDTH = $clog2(PALETTE_COLOR_COUNT) + 1; // Use built in log2 Command
    reg write_enable = 1'b0;
    reg start = 1'b0;
	reg[PIXEL_ADDRESS_WIDTH-1:0] imgAddress;  	 // Image address for the image data
	wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr; 	 // Color address for the color palette
//	assign imgAddress = x + 640*y;				 // Address calculated coordinate

	wire clk_CPU;
	assign clk_CPU = State[1] ? clk25 : 1'b0;
	wire[31:0] zero_to_CPU;
	assign zero_to_CPU = 32'd0;
	wire [31:0] to_CPU;
//	assign to_CPU = State[2] ? zero_to_CPU : q_dmem;
    Wrapper CPU1(.clock(clk_CPU), .reset(reset), .mwe1(wren), .memAddr1(address_dmem), .memDataIn1(data), .memDataOut1(q_dmem));

    //reg[31:0] data_out;

	// Color Palette to Map Color Address to 12-Bit Color
	wire[BITS_PER_COLOR-1:0] colorData; // 12-bit color data at current pixel
	wire[31:0] picAddress;
	assign picAddress = x + 640*y;


    //reg[31:0] Pixcount;
    //assign Pixcount = 32'd307200;
    always @(posedge clk && State == 3'b010 && write_enable) begin
        if(address_dmem < PIXEL_COUNT-1)
            Algorithm_Done <= 1'b0;
        else
            Algorithm_Done <= 1'b1;
    end
    // assign led3 = Algorithm_Done;
    always @(State)
    begin
        case(State)
            IDLE:       begin
                            write_enable <= 1'b0;
                            imgAddress <= picAddress;
                            // assign data_out = colorData;
                        end
                        
            Algorithm:  begin
                            write_enable <= wren;
                            imgAddress <= address_dmem;
                            // assign data_out = q_dmem;
                        end
            Print:      begin
                            write_enable <= 1'b0;
                            imgAddress <= picAddress;
                            // assign data_out = colorData;
                        end
        endcase
    end    
        assign led3 = start;
 
	RAM #(		
		.DEPTH(PIXEL_COUNT), 				     // Set RAM depth to contain every pixel
		.DATA_WIDTH(BITS_PER_COLOR),      // Set data width according to the color palette
		.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
		.MEMFILE({FILES_PATH, "finalimage.mem"})) // Memory initialization
	ImageData(
		.clk(clk), 						 // Falling edge of the 100 MHz clk
		.addr(imgAddress),					 // Image data address
		.dataIn(data),
		.dataOut(q_dmem),				 // Color palette address
		.wEn(wren)); 						 // We're always reading

//    RAM #(.MEMFILE("/Users/cyndiyag-howard/Downloads/Lab5_2/colors.mem"))
//     ProcMem(.clk(clock), 
//            .wEn(mwe), 
//            .addr(memAddr[11:0]), 
//            .dataIn(memDataIn), 
//            .dataOut(memDataOut));

    
	// Assign to output color from register if active
	wire[BITS_PER_COLOR-1:0] colorOut; 			  // Output color 
	assign colorOut = active ? q_dmem : 12'd0; // When not active, output black

	// Quickly assign the output colors to their channels using concatenation
	assign {VGA_R, VGA_G, VGA_B} = colorOut;
	
    assign led = enable_switch;
    assign led2 = Algorithm_Done;
    assign led4 = assert_next_state;
    assign led5 = Next[1];
    assign led6 = address_dmem[0];
	assign led7 = State[0];
    assign led8 = State[1];
    assign led9 = State[2];
    assign led10 = clk_Display;
endmodule