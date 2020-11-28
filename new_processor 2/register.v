module register(clk, reset, en, in, out);
	
	input clk, reset, en;
	input [31:0] in;

	output [31:0] out;

	dffe_ref dffe1(out[0], in[0], clk, en, reset);
	dffe_ref dffe2(out[1], in[1], clk, en, reset);
	dffe_ref dffe3(out[2], in[2], clk, en, reset);
	dffe_ref dffe4(out[3], in[3], clk, en, reset);
	dffe_ref dffe5(out[4], in[4], clk, en, reset);
	dffe_ref dffe6(out[5], in[5], clk, en, reset);
	dffe_ref dffe7(out[6], in[6], clk, en, reset);
	dffe_ref dffe8(out[7], in[7], clk, en, reset);
	dffe_ref dffe9(out[8], in[8], clk, en, reset);
	dffe_ref dffe10(out[9], in[9], clk, en, reset);
	dffe_ref dffe11(out[10], in[10], clk, en, reset);
	dffe_ref dffe12(out[11], in[11], clk, en, reset);
	dffe_ref dffe13(out[12], in[12], clk, en, reset);
	dffe_ref dffe14(out[13], in[13], clk, en, reset);
	dffe_ref dffe15(out[14], in[14], clk, en, reset);
	dffe_ref dffe16(out[15], in[15], clk, en, reset);
	dffe_ref dffe17(out[16], in[16], clk, en, reset);
	dffe_ref dffe18(out[17], in[17], clk, en, reset);
	dffe_ref dffe19(out[18], in[18], clk, en, reset);
	dffe_ref dffe20(out[19], in[19], clk, en, reset);
	dffe_ref dffe21(out[20], in[20], clk, en, reset);
	dffe_ref dffe22(out[21], in[21], clk, en, reset);
	dffe_ref dffe23(out[22], in[22], clk, en, reset);
	dffe_ref dffe24(out[23], in[23], clk, en, reset);
	dffe_ref dffe25(out[24], in[24], clk, en, reset);
	dffe_ref dffe26(out[25], in[25], clk, en, reset);
	dffe_ref dffe27(out[26], in[26], clk, en, reset);
	dffe_ref dffe28(out[27], in[27], clk, en, reset);
	dffe_ref dffe29(out[28], in[28], clk, en, reset);
	dffe_ref dffe30(out[29], in[29], clk, en, reset);
	dffe_ref dffe31(out[30], in[30], clk, en, reset);
	dffe_ref dffe32(out[31], in[31], clk, en, reset);


endmodule