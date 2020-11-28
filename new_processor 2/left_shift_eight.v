module left_shift_eight(shift_8, A);
	
	input [31:0] A;
	
	output [31:0] shift_8;

	assign shift_8[31] = A[23];
	assign shift_8[30] = A[22];
	assign shift_8[29] = A[21];
	assign shift_8[28] = A[20];
	assign shift_8[27] = A[19];
	assign shift_8[26] = A[18];
	assign shift_8[25] = A[17];
	assign shift_8[24] = A[16];
	assign shift_8[23] = A[15];
	assign shift_8[22] = A[14];
	assign shift_8[21] = A[13];
	assign shift_8[20] = A[12];
	assign shift_8[19] = A[11];
	assign shift_8[18] = A[10];
	assign shift_8[17] = A[9];
	assign shift_8[16] = A[8];
	assign shift_8[15] = A[7];
	assign shift_8[14] = A[6];
	assign shift_8[13] = A[5];
	assign shift_8[12] = A[4];
	assign shift_8[11] = A[3];
	assign shift_8[10] = A[2];
	assign shift_8[9] = A[1];
	assign shift_8[8] = A[0];
	assign shift_8[7:0] = 1'b0;

endmodule