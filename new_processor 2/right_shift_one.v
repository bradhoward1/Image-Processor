module right_shift_one(shift_1, A);
	
	input [31:0] A;
	
	output [31:0] shift_1;

	assign shift_1[31] = A[31];
	assign shift_1[30] = A[31];
	assign shift_1[29] = A[30];
	assign shift_1[28] = A[29];
	assign shift_1[27] = A[28];
	assign shift_1[26] = A[27];
	assign shift_1[25] = A[26];
	assign shift_1[24] = A[25];
	assign shift_1[23] = A[24];
	assign shift_1[22] = A[23];
	assign shift_1[21] = A[22];
	assign shift_1[20] = A[21];
	assign shift_1[19] = A[20];
	assign shift_1[18] = A[19];
	assign shift_1[17] = A[18];
	assign shift_1[16] = A[17];
	assign shift_1[15] = A[16];
	assign shift_1[14] = A[15];
	assign shift_1[13] = A[14];
	assign shift_1[12] = A[13];
	assign shift_1[11] = A[12];
	assign shift_1[10] = A[11];
	assign shift_1[9] = A[10];
	assign shift_1[8] = A[9];
	assign shift_1[7] = A[8];
	assign shift_1[6] = A[7];
	assign shift_1[5] = A[6];
	assign shift_1[4] = A[5];
	assign shift_1[3] = A[4];
	assign shift_1[2] = A[3];
	assign shift_1[1] = A[2];
	assign shift_1[0] = A[1];

endmodule