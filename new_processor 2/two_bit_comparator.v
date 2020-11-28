module two_bit_comparator(EQi, GTi, A, B, EQi_1, GTi_1);
	input [1:0] A, B;
	input EQi_1, GTi_1;
	wire [2:0] select;

	output EQi;
	output GTi;

	wire zero = 1'b0;
	wire one = 1'b1;

	wire A0_not, A1_not, B0_not, B1_not, GT_not, EQ_not;
	wire mux_1_out, mux_2_out;
	wire EQ_GT_not, EQ_not_GT;
	wire GT_inter;

	assign select[2:1] = A;
	assign select[0] = B[1];

	not A0not(A0_not, A[0]);
	not A1not(A1_not, A[1]);
	not B0not(B0_not, B[0]);
	not B1not(B1_not, B[1]);
	not EQi_1not(EQ_not, EQi_1);
	not GTi_1not(GT_not, GTi_1);

	mux_8_1_bit EQ(mux_1_out, select[2:0], B0_not, zero, B[0], zero, zero, B0_not, zero, B[0]);
	mux_8_1_bit GT(mux_2_out, select[2:0], zero, zero, B0_not, zero, one, zero, one, B0_not);

	and EQGT_not(EQ_GT_not, EQi_1, GT_not);
	and EQnot_GT(EQ_not_GT, EQ_not, GTi_1);
	and EQ_tot(EQi, mux_1_out, EQ_GT_not);
	and GTinter(GT_inter, mux_2_out, EQ_GT_not);
	or GT_tot(GTi, GT_inter, EQ_not_GT);

endmodule