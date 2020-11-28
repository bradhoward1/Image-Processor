module left_shift_sixteen(shift_16, A);
	
	input [31:0] A;
	
	output [31:0] shift_16;

	assign shift_16[31] = A[15];
	assign shift_16[30] = A[14];
	assign shift_16[29] = A[13];
	assign shift_16[28] = A[12];
	assign shift_16[27] = A[11];
	assign shift_16[26] = A[10];
	assign shift_16[25] = A[9];
	assign shift_16[24] = A[8];
	assign shift_16[23] = A[7];
	assign shift_16[22] = A[6];
	assign shift_16[21] = A[5];
	assign shift_16[20] = A[4];
	assign shift_16[19] = A[3];
	assign shift_16[18] = A[2];
	assign shift_16[17] = A[1];
	assign shift_16[16] = A[0];
	assign shift_16[15:0] = 1'b0;

endmodule