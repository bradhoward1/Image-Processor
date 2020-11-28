module regfile(clock1, ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	   ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA,
	   data_readRegB);

	input clock1, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;
	wire clock;
	assign clock = ~clock1;
	wire [31:0] out;
	wire [31:0] output_reg, output_reg1, output_reg2, output_reg3, output_reg4, output_reg5,
				output_reg6, output_reg7, output_reg8, output_reg9, output_reg10,
				output_reg11, output_reg12, output_reg13, output_reg14, output_reg15,
				output_reg16, output_reg17, output_reg18, output_reg19, output_reg20,
				output_reg21, output_reg22, output_reg23, output_reg24, output_reg25,
				output_reg26, output_reg27, output_reg28, output_reg29, output_reg30,
				output_reg31, output_reg32;
	wire [31:0] output_1, output_2, output_3, output_4, output_5,
				output_6, output_7, output_8, output_9, output_10,
				output_11, output_12, output_13, output_14, output_15,
				output_16, output_17, output_18, output_19, output_20,
				output_21, output_22, output_23, output_24, output_25,
				output_26, output_27, output_28, output_29, output_30,
				output_31, output_32;
	wire [31:0] output_1b, output_2b, output_3b, output_4b, output_5b,
				output_6b, output_7b, output_8b, output_9b, output_10b,
				output_11b, output_12b, output_13b, output_14b, output_15b,
				output_16b, output_17b, output_18b, output_19b, output_20b,
				output_21b, output_22b, output_23b, output_24b, output_25b,
				output_26b, output_27b, output_28b, output_29b, output_30b,
				output_31b, output_32b;
	wire to_reg1, to_reg2, to_reg3, to_reg4, to_reg5, to_reg6, to_reg7, to_reg8,
		 to_reg9, to_reg10, to_reg11, to_reg12, to_reg13, to_reg14, to_reg15, to_reg16,
		 to_reg17, to_reg18, to_reg19, to_reg20, to_reg21, to_reg22, to_reg23, to_reg24,
		 to_reg25, to_reg26, to_reg27, to_reg28, to_reg29, to_reg30, to_reg31, to_reg32;

	wire [31:0] read_reg_first, read_reg_second;

	wire one;
	assign one = 1'b1;
	wire zero;
	assign zero = 1'b0;

	decoder_32 decode_writeReg(out, ctrl_writeReg, ctrl_writeEnable);

	and reg1(to_reg1, ctrl_writeEnable, out[0]);
	register register_1(clock, ctrl_reset, to_reg1, data_writeReg, output_reg);
	and and1(output_reg1[0], zero, output_reg[0]);
	and and2(output_reg1[1], zero, output_reg[1]);
	and and3(output_reg1[2], zero, output_reg[2]);
	and and4(output_reg1[3], zero, output_reg[3]);
	and and5(output_reg1[4], zero, output_reg[4]);
	and and6(output_reg1[5], zero, output_reg[5]);
	and and7(output_reg1[6], zero, output_reg[6]);
	and and8(output_reg1[7], zero, output_reg[7]);
	and and9(output_reg1[8], zero, output_reg[8]);
	and and10(output_reg1[9], zero, output_reg[9]);
	and and11(output_reg1[10], zero, output_reg[10]);
	and and12(output_reg1[11], zero, output_reg[11]);
	and and13(output_reg1[12], zero, output_reg[12]);
	and and14(output_reg1[13], zero, output_reg[13]);
	and and15(output_reg1[14], zero, output_reg[14]);
	and and16(output_reg1[15], zero, output_reg[15]);
	and and17(output_reg1[16], zero, output_reg[16]);
	and and18(output_reg1[17], zero, output_reg[17]);
	and and19(output_reg1[18], zero, output_reg[18]);
	and and20(output_reg1[19], zero, output_reg[19]);
	and and21(output_reg1[20], zero, output_reg[20]);
	and and22(output_reg1[21], zero, output_reg[21]);
	and and23(output_reg1[22], zero, output_reg[22]);
	and and24(output_reg1[23], zero, output_reg[23]);
	and and25(output_reg1[24], zero, output_reg[24]);
	and and26(output_reg1[25], zero, output_reg[25]);
	and and27(output_reg1[26], zero, output_reg[26]);
	and and28(output_reg1[27], zero, output_reg[27]);
	and and29(output_reg1[28], zero, output_reg[28]);
	and and30(output_reg1[29], zero, output_reg[29]);
	and and31(output_reg1[30], zero, output_reg[30]);
	and and32(output_reg1[31], zero, output_reg[31]);

	and reg2(to_reg2, ctrl_writeEnable, out[1]);
	register register_2(clock, ctrl_reset, to_reg2, data_writeReg, output_reg2);

	and reg3(to_reg3, ctrl_writeEnable, out[2]);
	register register_3(clock, ctrl_reset, to_reg3, data_writeReg, output_reg3);

	and reg4(to_reg4, ctrl_writeEnable, out[3]);
	register register_4(clock, ctrl_reset, to_reg4, data_writeReg, output_reg4);

	and reg5(to_reg5, ctrl_writeEnable, out[4]);
	register register_5(clock, ctrl_reset, to_reg5, data_writeReg, output_reg5);

	and reg6(to_reg6, ctrl_writeEnable, out[5]);
	register register_6(clock, ctrl_reset, to_reg6, data_writeReg, output_reg6);

	and reg7(to_reg7, ctrl_writeEnable, out[6]);
	register register_7(clock, ctrl_reset, to_reg7, data_writeReg, output_reg7);

	and reg8(to_reg8, ctrl_writeEnable, out[7]);
	register register_8(clock, ctrl_reset, to_reg8, data_writeReg, output_reg8);

	and reg9(to_reg9, ctrl_writeEnable, out[8]);
	register register_9(clock, ctrl_reset, to_reg9, data_writeReg, output_reg9);

	and reg10(to_reg10, ctrl_writeEnable, out[9]);
	register register_10(clock, ctrl_reset, to_reg10, data_writeReg, output_reg10);

	and reg11(to_reg11, ctrl_writeEnable, out[10]);
	register register_11(clock, ctrl_reset, to_reg11, data_writeReg, output_reg11);

	and reg12(to_reg12, ctrl_writeEnable, out[11]);
	register register_12(clock, ctrl_reset, to_reg12, data_writeReg, output_reg12);

	and reg13(to_reg13, ctrl_writeEnable, out[12]);
	register register_13(clock, ctrl_reset, to_reg13, data_writeReg, output_reg13);

	and reg14(to_reg14, ctrl_writeEnable, out[13]);
	register register_14(clock, ctrl_reset, to_reg14, data_writeReg, output_reg14);

	and reg15(to_reg15, ctrl_writeEnable, out[14]);
	register register_15(clock, ctrl_reset, to_reg15, data_writeReg, output_reg15);

	and reg16(to_reg16, ctrl_writeEnable, out[15]);
	register register_16(clock, ctrl_reset, to_reg16, data_writeReg, output_reg16);

	and reg17(to_reg17, ctrl_writeEnable, out[16]);
	register register_17(clock, ctrl_reset, to_reg17, data_writeReg, output_reg17);

	and reg18(to_reg18, ctrl_writeEnable, out[17]);
	register register_18(clock, ctrl_reset, to_reg18, data_writeReg, output_reg18);

	and reg19(to_reg19, ctrl_writeEnable, out[18]);
	register register_19(clock, ctrl_reset, to_reg19, data_writeReg, output_reg19);

	and reg20(to_reg20, ctrl_writeEnable, out[19]);
	register register_20(clock, ctrl_reset, to_reg20, data_writeReg, output_reg20);

	and reg21(to_reg21, ctrl_writeEnable, out[20]);
	register register_21(clock, ctrl_reset, to_reg21, data_writeReg, output_reg21);

	and reg22(to_reg22, ctrl_writeEnable, out[21]);
	register register_22(clock, ctrl_reset, to_reg22, data_writeReg, output_reg22);

	and reg23(to_reg23, ctrl_writeEnable, out[22]);
	register register_23(clock, ctrl_reset, to_reg23, data_writeReg, output_reg23);

	and reg24(to_reg24, ctrl_writeEnable, out[23]);
	register register_24(clock, ctrl_reset, to_reg24, data_writeReg, output_reg24);

	and reg25(to_reg25, ctrl_writeEnable, out[24]);
	register register_25(clock, ctrl_reset, to_reg25, data_writeReg, output_reg25);

	and reg26(to_reg26, ctrl_writeEnable, out[25]);
	register register_26(clock, ctrl_reset, to_reg26, data_writeReg, output_reg26);

	and reg27(to_reg27, ctrl_writeEnable, out[26]);
	register register_27(clock, ctrl_reset, to_reg27, data_writeReg, output_reg27);

	and reg28(to_reg28, ctrl_writeEnable, out[27]);
	register register_28(clock, ctrl_reset, to_reg28, data_writeReg, output_reg28);

	and reg29(to_reg29, ctrl_writeEnable, out[28]);
	register register_29(clock, ctrl_reset, to_reg29, data_writeReg, output_reg29);

	and reg30(to_reg30, ctrl_writeEnable, out[29]);
	register register_30(clock, ctrl_reset, to_reg30, data_writeReg, output_reg30);

	and reg31(to_reg31, ctrl_writeEnable, out[30]);
	register register_31(clock, ctrl_reset, to_reg31, data_writeReg, output_reg31);

	and reg32(to_reg32, ctrl_writeEnable, out[31]);
	register register_32(clock, ctrl_reset, to_reg32, data_writeReg, output_reg32);


	decoder_32 decode_read_1(read_reg_first, ctrl_readRegA, one);
	decoder_32 decode_read_2(read_reg_second, ctrl_readRegB, one);

	my_tri tri_1(output_reg1, read_reg_first[0], output_1);
	my_tri tri_1b(output_reg1, read_reg_second[0], output_1b);

	my_tri tri_2(output_reg2, read_reg_first[1], output_2);
	my_tri tri_2b(output_reg2, read_reg_second[1], output_2b);

	my_tri tri_3(output_reg3, read_reg_first[2], output_3);
	my_tri tri_3b(output_reg3, read_reg_second[2], output_3b);

	my_tri tri_4(output_reg4, read_reg_first[3], output_4);
	my_tri tri_4b(output_reg4, read_reg_second[3], output_4b);

	my_tri tri_5(output_reg5, read_reg_first[4], output_5);
	my_tri tri_5b(output_reg5, read_reg_second[4], output_5b);

	my_tri tri_6(output_reg6, read_reg_first[5], output_6);
	my_tri tri_6b(output_reg6, read_reg_second[5], output_6b);

	my_tri tri_7(output_reg7, read_reg_first[6], output_7);
	my_tri tri_7b(output_reg7, read_reg_second[6], output_7b);

	my_tri tri_8(output_reg8, read_reg_first[7], output_8);
	my_tri tri_8b(output_reg8, read_reg_second[7], output_8b);

	my_tri tri_9(output_reg9, read_reg_first[8], output_9);
	my_tri tri_9b(output_reg9, read_reg_second[8], output_9b);

	my_tri tri_10(output_reg10, read_reg_first[9], output_10);
	my_tri tri_10b(output_reg10, read_reg_second[9], output_10b);

	my_tri tri_11(output_reg11, read_reg_first[10], output_11);
	my_tri tri_11b(output_reg11, read_reg_second[10], output_11b);

	my_tri tri_12(output_reg12, read_reg_first[11], output_12);
	my_tri tri_12b(output_reg12, read_reg_second[11], output_12b);

	my_tri tri_13(output_reg13, read_reg_first[12], output_13);
	my_tri tri_13b(output_reg13, read_reg_second[12], output_13b);

	my_tri tri_14(output_reg14, read_reg_first[13], output_14);
	my_tri tri_14b(output_reg14, read_reg_second[13], output_14b);

	my_tri tri_15(output_reg15, read_reg_first[14], output_15);
	my_tri tri_15b(output_reg15, read_reg_second[14], output_15b);

	my_tri tri_16(output_reg16, read_reg_first[15], output_16);
	my_tri tri_16b(output_reg16, read_reg_second[15], output_16b);

	my_tri tri_17(output_reg17, read_reg_first[16], output_17);
	my_tri tri_17b(output_reg17, read_reg_second[16], output_17b);

	my_tri tri_18(output_reg18, read_reg_first[17], output_18);
	my_tri tri_18b(output_reg18, read_reg_second[17], output_18b);

	my_tri tri_19(output_reg19, read_reg_first[18], output_19);
	my_tri tri_19b(output_reg19, read_reg_second[18], output_19b);

	my_tri tri_20(output_reg20, read_reg_first[19], output_20);
	my_tri tri_20b(output_reg20, read_reg_second[19], output_20b);

	my_tri tri_21(output_reg21, read_reg_first[20], output_21);
	my_tri tri_21b(output_reg21, read_reg_second[20], output_21b);

	my_tri tri_22(output_reg22, read_reg_first[21], output_22);
	my_tri tri_22b(output_reg22, read_reg_second[21], output_22b);

	my_tri tri_23(output_reg23, read_reg_first[22], output_23);
	my_tri tri_23b(output_reg23, read_reg_second[22], output_23b);

	my_tri tri_24(output_reg24, read_reg_first[23], output_24);
	my_tri tri_24b(output_reg24, read_reg_second[23], output_24b);

	my_tri tri_25(output_reg25, read_reg_first[24], output_25);
	my_tri tri_25b(output_reg25, read_reg_second[24], output_25b);

	my_tri tri_26(output_reg26, read_reg_first[25], output_26);
	my_tri tri_26b(output_reg26, read_reg_second[25], output_26b);

	my_tri tri_27(output_reg27, read_reg_first[26], output_27);
	my_tri tri_27b(output_reg27, read_reg_second[26], output_27b);

	my_tri tri_28(output_reg28, read_reg_first[27], output_28);
	my_tri tri_28b(output_reg28, read_reg_second[27], output_28b);

	my_tri tri_29(output_reg29, read_reg_first[28], output_29);
	my_tri tri_29b(output_reg29, read_reg_second[28], output_29b);

	my_tri tri_30(output_reg30, read_reg_first[29], output_30);
	my_tri tri_30b(output_reg30, read_reg_second[29], output_30b);

	my_tri tri_31(output_reg31, read_reg_first[30], output_31);
	my_tri tri_31b(output_reg31, read_reg_second[30], output_31b);

	my_tri tri_32(output_reg32, read_reg_first[31], output_32);
	my_tri tri_32b(output_reg32, read_reg_second[31], output_32b);


	assign data_readRegA = output_1;
	assign data_readRegA = output_2;
	assign data_readRegA = output_3;
	assign data_readRegA = output_4;
	assign data_readRegA = output_5;
	assign data_readRegA = output_6;
	assign data_readRegA = output_7;
	assign data_readRegA = output_8;
	assign data_readRegA = output_9;
	assign data_readRegA = output_10;
	assign data_readRegA = output_11;
	assign data_readRegA = output_12;
	assign data_readRegA = output_13;
	assign data_readRegA = output_14;
	assign data_readRegA = output_15;
	assign data_readRegA = output_16;
	assign data_readRegA = output_17;
	assign data_readRegA = output_18;
	assign data_readRegA = output_19;
	assign data_readRegA = output_20;
	assign data_readRegA = output_21;
	assign data_readRegA = output_22;
	assign data_readRegA = output_23;
	assign data_readRegA = output_24;
	assign data_readRegA = output_25;
	assign data_readRegA = output_26;
	assign data_readRegA = output_27;
	assign data_readRegA = output_28;
	assign data_readRegA = output_29;
	assign data_readRegA = output_30;
	assign data_readRegA = output_31;
	assign data_readRegA = output_32;

	assign data_readRegB = output_1b;
	assign data_readRegB = output_2b;
	assign data_readRegB = output_3b;
	assign data_readRegB = output_4b;
	assign data_readRegB = output_5b;
	assign data_readRegB = output_6b;
	assign data_readRegB = output_7b;
	assign data_readRegB = output_8b;
	assign data_readRegB = output_9b;
	assign data_readRegB = output_10b;
	assign data_readRegB = output_11b;
	assign data_readRegB = output_12b;
	assign data_readRegB = output_13b;
	assign data_readRegB = output_14b;
	assign data_readRegB = output_15b;
	assign data_readRegB = output_16b;
	assign data_readRegB = output_17b;
	assign data_readRegB = output_18b;
	assign data_readRegB = output_19b;
	assign data_readRegB = output_20b;
	assign data_readRegB = output_21b;
	assign data_readRegB = output_22b;
	assign data_readRegB = output_23b;
	assign data_readRegB = output_24b;
	assign data_readRegB = output_25b;
	assign data_readRegB = output_26b;
	assign data_readRegB = output_27b;
	assign data_readRegB = output_28b;
	assign data_readRegB = output_29b;
	assign data_readRegB = output_30b;
	assign data_readRegB = output_31b;
	assign data_readRegB = output_32b;


endmodule