module logical_left_shift(S, A, shamt);
	input [31:0] A;
	input [4:0] shamt;

	output [31:0] S;

	wire [31:0] shift_16;
	wire [31:0] shift_8;
	wire [31:0] shift_4;
	wire [31:0] shift_2;
	wire [31:0] shift_1;

	wire [31:0] mux_out_16;
	wire [31:0] mux_out_8;
	wire [31:0] mux_out_4;
	wire [31:0] mux_out_2;

	left_shift_sixteen shift_by_16(shift_16, A);
	mux_2 do_we_shift_by_16(mux_out_16, shamt[4], A, shift_16);

	left_shift_eight shift_by_8(shift_8, mux_out_16);
	mux_2 do_we_shift_by_8(mux_out_8, shamt[3], mux_out_16, shift_8);

	left_shift_four shift_by_4(shift_4, mux_out_8);
	mux_2 do_we_shift_by_4(mux_out_4, shamt[2], mux_out_8, shift_4);

	left_shift_two shift_by_2(shift_2, mux_out_4);
	mux_2 do_we_shift_by_2(mux_out_2, shamt[1], mux_out_4, shift_2);

	left_shift_one shift_by_1(shift_1, mux_out_2);
	mux_2 do_we_shift_by_1(S, shamt[0], mux_out_2, shift_1);

endmodule