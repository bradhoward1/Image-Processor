`timescale 1 ns/ 100 ps
module VGAController_tb;
    // module inputs
    reg clock = 0;
    reg reset = 0;


	wire hSync; 		// H Sync Signal
	wire vSync; 		// Veritcal Sync Signal
	wire[3:0] VGA_R;  // Red Signal Bits
	wire[3:0] VGA_G;  // Green Signal Bits
	wire[3:0] VGA_B;  // Blue Signal Bits
	wire ps2_clk;
	wire ps2_data;

	VGAController VGA(.clk(clock), .reset(reset), .hSync(hSync), .vSync(vSync), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));

	// Imem
    wire [31:0] address_imem;
//	reg [31:0] q_imem = 32'h28440011;


	integer count;

	initial begin
		count = 0;
	end
		always @(posedge clock)
			begin
				count = count +1;
				if (count >= 1000000) begin
					$finish;
				end
			end

	// Dmem
	wire [31:0] address_dmem, data;
	wire wren;
	reg [31:0] q_dmem = 32'b0;

	// Regfile
	wire ctrl_writeEnable;
	wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	wire [31:0] data_writeReg;
//	reg [31:0] data_readRegA = 32'h00000001;
//	reg [31:0] data_readRegB = 32'h00000002;


    // Instantiate multdiv
 
//regfile test_reg(
//	.clock(clock), .ctrl_writeEnable(ctrl_writeEnable), .ctrl_reset(ctrl_reset), .ctrl_writeReg(ctrl_writeReg),
//	.ctrl_readRegA(ctrl_readRegA), .ctrl_readRegB(ctrl_readRegB), .data_writeReg(data_writeReg), .data_readRegA(data_readRegA),
//	.data_readRegB(data_readRegB));

    always 
    	#20 clock = !clock;

    initial begin

    	$dumpfile("VGAController.vcd");
    	$dumpvars(0, VGAController_tb);
    end




endmodule