module left_shift_two(shift_2, A);
	
	input [31:0] A;
	
	output [31:0] shift_2;

	assign shift_2[31] = A[29];
	assign shift_2[30] = A[28];
	assign shift_2[29] = A[27];
	assign shift_2[28] = A[26];
	assign shift_2[27] = A[25];
	assign shift_2[26] = A[24];
	assign shift_2[25] = A[23];
	assign shift_2[24] = A[22];
	assign shift_2[23] = A[21];
	assign shift_2[22] = A[20];
	assign shift_2[21] = A[19];
	assign shift_2[20] = A[18];
	assign shift_2[19] = A[17];
	assign shift_2[18] = A[16];
	assign shift_2[17] = A[15];
	assign shift_2[16] = A[14];
	assign shift_2[15] = A[13];
	assign shift_2[14] = A[12];
	assign shift_2[13] = A[11];
	assign shift_2[12] = A[10];
	assign shift_2[11] = A[9];
	assign shift_2[10] = A[8];
	assign shift_2[9] = A[7];
	assign shift_2[8] = A[6];
	assign shift_2[7] = A[5];
	assign shift_2[6] = A[4];
	assign shift_2[5] = A[3];
	assign shift_2[4] = A[2];
	assign shift_2[3] = A[1];
	assign shift_2[2] = A[0];
	assign shift_2[1:0] = 1'b0;

endmodule