module eight_bit_comparator(EQi, GTi, A, B, EQi_1, GTi_1);
	input [31:0] A, B;
	input EQi_1, GTi_1;
	wire [2:0] select;

	assign select[2:1] = A;
	assign select[0] = B[1];

	wire EQ1, EQ2, EQ3;
	wire GT1, GT2, GT3;

	output EQi;
	output GTi;

	two_bit_comparator MSB(EQ1, GT1, A[7:6], B[7:6], EQi_1, GTi_1);
	two_bit_comparator MSB_2(EQ2, GT2, A[5:4], B[5:4], EQ1, GT1);
	two_bit_comparator MSB_4(EQ3, GT3, A[3:2], B[3:2], EQ2, GT2);
	two_bit_comparator MSB_6(EQi, GTi, A[1:0], B[1:0], EQ3, GT3);

endmodule