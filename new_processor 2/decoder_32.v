module decoder_32(out, select, enable);
	
	input [4:0] select;
	input enable;

	output [31:0] out;
	wire [31:0] enable_pin;

	assign enable_pin[31:1] = 1'b0;
	assign enable_pin[0] = enable;

	logical_left_shift shift_left(out, enable_pin, select);

endmodule
