`timescale 1ns/100ps
module Wrapper_tb;

    // module inputs
    reg clock = 0;
    reg reset = 0;

	// Imem
    wire [31:0] address_imem;
//	reg [31:0] q_imem = 32'h28440011;

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

	integer count;

	initial begin
		count = 0;
	end
		always @(posedge clock)
			begin
				count = count +1;
				if (count >= 1000) begin
					$finish;
				end
			end

    // Instantiate multdiv
    processor tester(
    .clock(clock),                          // I: The master clock
    .reset(reset),                          // I: A reset signal

    // Imem
    .address_imem(address_imem),                   // O: The address of the data to get from imem
    .q_imem(q_imem),                         // I: The data from imem

    // Dmem
    .address_dmem(address_dmem),                   // O: The address of the data to get or put from/to dmem
    .data(data),                           // O: The data to write to dmem
    .wren(wren),                           // O: Write enable for dmem
    .q_dmem(q_dmem),                         // I: The data from dmem

    // Regfile
    .ctrl_writeEnable(ctrl_writeEnable),               // O: Write enable for RegFile
    .ctrl_writeReg(ctrl_writeReg),                  // O: Register to write to in RegFile
    .ctrl_readRegA(ctrl_readRegA),                  // O: Register to read from port A of RegFile
    .ctrl_readRegB(ctrl_readRegB),                  // O: Register to read from port B of RegFile
    .data_writeReg(data_writeReg),                  // O: Data to write to for RegFile
    .data_readRegA(data_readRegA),                  // I: Data from port A of RegFile
    .data_readRegB(data_readRegB)                   // I: Data from port B of RegFile
    );

 Wrapper test(.clock(~clock), .reset(reset));

//regfile test_reg(
//	.clock(clock), .ctrl_writeEnable(ctrl_writeEnable), .ctrl_reset(ctrl_reset), .ctrl_writeReg(ctrl_writeReg),
//	.ctrl_readRegA(ctrl_readRegA), .ctrl_readRegB(ctrl_readRegB), .data_writeReg(data_writeReg), .data_readRegA(data_readRegA),
//	.data_readRegB(data_readRegB));

    always 
    	#20 clock = !clock;

    initial begin

    	$dumpfile("Wrapper_tb.vcd");
    	$dumpvars(0, Wrapper_tb);
    end




endmodule