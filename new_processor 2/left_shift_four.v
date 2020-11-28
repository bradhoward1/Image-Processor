module left_shift_four(shift_4, A);
	
	input [31:0] A;
	
	output [31:0] shift_4;

	assign shift_4[31] = A[27];
	assign shift_4[30] = A[26];
	assign shift_4[29] = A[25];
	assign shift_4[28] = A[24];
	assign shift_4[27] = A[23];
	assign shift_4[26] = A[22];
	assign shift_4[25] = A[21];
	assign shift_4[24] = A[20];
	assign shift_4[23] = A[19];
	assign shift_4[22] = A[18];
	assign shift_4[21] = A[17];
	assign shift_4[20] = A[16];
	assign shift_4[19] = A[15];
	assign shift_4[18] = A[14];
	assign shift_4[17] = A[13];
	assign shift_4[16] = A[12];
	assign shift_4[15] = A[11];
	assign shift_4[14] = A[10];
	assign shift_4[13] = A[9];
	assign shift_4[12] = A[8];
	assign shift_4[11] = A[7];
	assign shift_4[10] = A[6];
	assign shift_4[9] = A[5];
	assign shift_4[8] = A[4];
	assign shift_4[7] = A[3];
	assign shift_4[6] = A[2];
	assign shift_4[5] = A[1];
	assign shift_4[4] = A[0];
	assign shift_4[3:0] = 1'b0;

endmodule