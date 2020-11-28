/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module new_processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
     
    );

    // Control signals
    input clock, reset;
    
    // Imem
    output [31:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [31:0] address_dmem, data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    // Wires for PC
    wire [31:0] nop; 
    assign nop = 32'b0;
    wire [31:0] PC_d, PC_q, PC_q_temp;
    wire one_1_bit;
    assign one_1_bit = 1'b1;
    wire zero_1_bit;
    assign zero_1_bit = 1'b0;
    wire [31:0] one_32_bit;
    assign one_32_bit = 32'b00000000000000000000000000000001;
    wire [31:0] to_PC_mux_2;
    wire [31:0] send_to_PC, send_to_PC_temp, send_to_PC_temp1, send_to_PC_temp2;
    wire bne, blt;
    wire select_PC;
    wire [31:0] send_to_PC_final;
    wire multdiv_stall;

    // Wires for ALU
    wire isNotEqual, isLessThan, overflow, isNotEqual1, isLessThan1, overflow1, isNotEqual2, isLessThan2, overflow2, isNotEqual5, isLessThan5, overflow5;
    wire [31:0] PC_data_result;
    wire st_or_br;

    // wires for FD latch
    wire [31:0] q_imem_IR, q_imem_IR_to_DX;
    assign q_imem_IR = q_imem;
    wire [31:0] PC_data_result_to_DX;
    wire [31:0] to_FD_IR;
    wire [3:0] branch_check;
    wire branch_assert;

    // wires for DX latch
    wire [31:0] q_imem_IR_to_XM;
    wire [31:0] PC_data_result_out;
    wire [31:0] sx_immed, shifted_sx_immed;
    wire [31:0] data_readRegA_out, data_readRegB_out;
    wire [31:0] first_val_to_ALU;
    wire [31:0] second_val_to_ALU_temp, second_val_to_ALU;
    wire [31:0] ALU_output_d;
    wire [31:0] multdiv_output, multdiv_output_q;
    wire ctrl_MULT, ctrl_DIV, not_6, not_5, not_2;
    wire data_resultRDY, data_exception;
    wire [31:0] q_imem_IR_to_PW;
    wire [4:0] to_ALUop;
    wire [31:0] to_DX_IR;
    wire enable_multdiv_ctrl, enable_multdiv_ctrl_out;
    wire [31:0] data_writeReg_temp1;

    // wires for XM latch
    wire [31:0] ALU_output_q;
    wire [31:0] q_imem_IR_to_MW;
    wire [31:0] data_readRegB_out_XM;
    wire [31:0] data_to_d_mem;
    wire j_jal, jal;
    wire ctrl1, ctrl, isNotEqual4, isLessThan4, overflow4, GTi9, GTi5;
    wire [31:0] counter_alu, counter_result;
    wire done1;

    // wires for MW latch
    wire [31:0] ALU_output_q_out;
    wire [31:0] q_dmem_out;
    wire [31:0] q_imem_IR_to_data;
    wire [31:0] data_writeReg_temp;

    // wires for data hazards
    wire [7:0] compare_in_A1, compare_in_B1, compare_in_A2, compare_in_B2, DXload_check, FDstore_check;
    wire EQi1, GTi1, EQi2, GTi2, EQi3, GTi3, EQi4, GTi4; 
    wire data_hazard, stall, not_stall, check_not_store;

    // wires for bypassing
    wire [7:0] bypass_inA1, bypass_inA2, bypass_inB1, bypass_inB2;
    wire select_bypass1, select_bypass2, select_bypass3, select_bypass4;
    wire [1:0] bypass_ALUinA, bypass_ALUinB, ctrl_ALU_inA, ctrl_ALU_inB;
    wire [7:0] bypass_inA3;
    wire bypass_branch_ctrl;
    wire [7:0] out_bypassB;
    wire no_branching;
    wire jumps_occur, branch_or_jump;
    wire [31:0] ALU_output;
    wire multdiv_ctrl;
    wire [31:0] mux_8_result;
    wire [31:0] ALU_result;
    wire check_overflow;
    wire setx_ctrl, write_setx;
    wire [31:0] ALU_output_temp;
    wire [4:0] ctrl_writeReg_temp;
    wire [31:0] send_to_PC_temp3;
    wire [2:0] val_determine;
    wire val_assignment;
    wire next_overflow1, overall_overflow, overall_overflow1, control_overflow;
    wire [31:0] first_val_to_ALU_temp, second_val_to_ALU_temp1;
    wire mult_in_A, mult_in_B;

    /* YOUR CODE STARTS HERE */
    


    // Wires for Imem (Instructions)
    wire [4:0] opcode, rd, rs, rt, shamt, ctrl_ALU_op;
    wire [31:0] target;
    wire [16:0] immediate;
    wire [1:0] zeroes_for_R;
    wire [21:0] zeroes_for_JII;

    // Universal bits for all instruction types
//    assign opcode = q_imem[31:27];
    

    // for R, I, JII
//    assign rd = q_imem[26:22];


    // bits for R and I only
//    assign rs = q_imem[21:17];


    // for R only
//    assign rt = q_imem[16:12];
//    assign shamt = q_imem[11:7];
    assign ctrl_ALU_op = q_imem_IR_to_XM[6:2];
//    assign zeroes_for_R = q_imem[1:0];

    // for I only
    assign immediate = q_imem[16:0];

    // for JI only
//    assign target = q_imem[26:0];

    // for JII only
//    assign zeroes_for_JII = q_imem[21:0];


// PC Stage

    register multdiv_assert(clock, reset || enable_multdiv_ctrl, ctrl1 || enable_multdiv_ctrl, ctrl1, multdiv_ctrl);


    register PC(clock, reset, not_stall && ~multdiv_ctrl, send_to_PC, PC_q);
    alu PC_add_1(PC_q, one_32_bit, 5'b00000,
            5'b00000, PC_data_result, isNotEqual, isLessThan, overflow);
    assign address_imem = PC_q[11:0];


// FD Stage

    // IR = instruction register, tells you what instruction the current latch is on

    wire branch_check1;
    assign branch_check1 = ((q_imem_IR_to_XM[31:27] == 5'b00010) || (q_imem_IR_to_XM[31:27] == 5'b00110)) ? 1'b1 : 1'b0;

    assign no_branching = (branch_check1 && bne) || (branch_check1 && blt);
    or stall_or_branch(st_or_br, stall, no_branching, jumps_occur);

    mux_2 input_to_FD_IR(to_FD_IR, st_or_br, q_imem_IR, nop); //stall
    register FD_IR_latch(clock, reset, not_stall && ~multdiv_ctrl, to_FD_IR, q_imem_IR_to_DX); //notstall
    
    register FD_PC_latch(clock, reset, not_stall && ~multdiv_ctrl, PC_data_result, PC_data_result_to_DX);

// DX Stage

    assign ctrl_readRegA = q_imem_IR_to_DX[21:17];

    or merp(branch_or_jump, no_branching, jumps_occur);
    mux_2 input_to_DX_IR(to_DX_IR, branch_or_jump, q_imem_IR_to_DX, nop);

    wire readingB_mux_ctrl;
    assign readingB_mux_ctrl = ((q_imem_IR_to_DX[31:27] == 5'b00111) || (q_imem_IR_to_DX[31:27] == 5'b00100) || (q_imem_IR_to_DX[31:27] == 5'b00010) || (q_imem_IR_to_DX[31:27] == 5'b00110)) ? 1'b1 : 1'b0;

    mux_2_5_bit readRegB(ctrl_readRegB, readingB_mux_ctrl, q_imem_IR_to_DX[16:12], q_imem_IR_to_DX[26:22]); // define select here *****


    register DX_IR_latch(clock, reset, ~multdiv_ctrl, to_DX_IR, q_imem_IR_to_XM);
    register DX_RegA_latch(clock, reset, ~multdiv_ctrl, data_readRegA, data_readRegA_out);
    register DX_RegB_latch(clock, reset, ~multdiv_ctrl, data_readRegB, data_readRegB_out);
    register DX_PC_latch(clock, reset, ~multdiv_ctrl, PC_data_result_to_DX, PC_data_result_out);

    assign sx_immed[16:0] = q_imem_IR_to_XM[16:0];
    assign sx_immed[31:17] = q_imem_IR_to_XM[16];

    mux_4 ALUinB(second_val_to_ALU_temp1, ctrl_ALU_inB, ALU_output_q, data_writeReg, data_readRegB_out, nop);


    assign mult_in_B = ((q_imem_IR_to_MW[31:27] == 5'b00000) && ((q_imem_IR_to_MW[6:2] == 5'b00110) || (q_imem_IR_to_MW[6:2] == 5'b00111))) && (q_imem_IR_to_MW[26:22] == q_imem_IR_to_XM[16:12]) && enable_multdiv_ctrl ? 1'b1 : 1'b0;

    mux_2 toB(second_val_to_ALU_temp, mult_in_B, second_val_to_ALU_temp1, multdiv_output_q);

    wire [4:0] op_in_from_DX;
    assign op_in_from_DX = q_imem_IR_to_XM[31:27];

    wire B_or_sx_mux_ctrl;
    assign B_or_sx_mux_ctrl = ((op_in_from_DX == 5'b00101) || (op_in_from_DX == 5'b00111) || (op_in_from_DX == 5'b01000)) ? 1'b1 : 1'b0;


    mux_2 B_or_sx_immed(second_val_to_ALU, B_or_sx_mux_ctrl, second_val_to_ALU_temp, sx_immed); // need to define select *****

    mux_4 ALUinA(first_val_to_ALU_temp, ctrl_ALU_inA, ALU_output_q, data_writeReg, data_readRegA_out, nop);

    assign mult_in_A = ((q_imem_IR_to_MW[31:27] == 5'b00000) && ((q_imem_IR_to_MW[6:2] == 5'b00110) || (q_imem_IR_to_MW[6:2] == 5'b00111))) && (q_imem_IR_to_MW[26:22] == q_imem_IR_to_XM[21:17]) && enable_multdiv_ctrl ? 1'b1 : 1'b0;

    mux_2 toA(first_val_to_ALU, mult_in_A, first_val_to_ALU_temp, multdiv_output_q);

    mux_2_5_bit ALU_opcode(to_ALUop, B_or_sx_mux_ctrl, ctrl_ALU_op, 5'b00000);


    alu alu_unit(first_val_to_ALU, second_val_to_ALU, to_ALUop,
            q_imem_IR_to_XM[11:7], ALU_output_d, isNotEqual1, isLessThan1, overflow1);


    assign check_overflow = (((q_imem_IR_to_XM[31:27] == 5'b00000) || (q_imem_IR_to_XM[31:27] == 5'b00101)) && (overflow1 != 1'b0)) ? 1'b1 : 1'b0;


    assign val_assignment = (q_imem_IR_to_XM[31:27] == 5'b00101) ? 1'b1 : 1'b0;

    mux_2 determine_val(val_determine, val_assignment, q_imem_IR_to_XM[4:2], q_imem_IR_to_XM[29:27]);

    mux_8 val_to_rstatus(mux_8_result, val_determine, 32'd1, 32'd3, 32'd0, 32'd0, 32'd0, 32'd2, 32'd4, 32'd5);


    assign setx_ctrl = (q_imem_IR_to_XM[31:27] == 5'b10101) ? 1'b1 : 1'b0;

    mux_2 setx_mux(ALU_output_temp, setx_ctrl, ALU_output_d, target);

    mux_2 overflow_occurs(ALU_result, check_overflow, ALU_output_temp, mux_8_result);


    assign ctrl_MULT = (ctrl_ALU_op == 5'b00110) ? 1'b1 : 1'b0;

    assign ctrl_DIV = (ctrl_ALU_op == 5'b00111) ? 1'b1 : 1'b0;


    xor ctrl_gate(ctrl1, ctrl_MULT, ctrl_DIV);

    register counter_register(clock, reset, ctrl1, counter_alu, counter_result);

    alu counting_alu(counter_result, 32'b00000000000000000000000000000001, 5'b00000, 5'b00000, counter_alu, isNotEqual4, isLessThan4, overflow4);
    
    eight_bit_comparator compare(done1, GTi9, 8'b00100000, counter_result[7:0], one_1_bit, zero_1_bit);

    register multdiv_assert1(clock, reset, ctrl1 || ctrl, ctrl1, ctrl);


    multdiv multdiv_unit(first_val_to_ALU, second_val_to_ALU_temp, ctrl_MULT, ctrl_DIV, clock, multdiv_output, data_exception, data_resultRDY);

    register exception_checker(clock, reset, data_exception || data_exception1, data_exception, data_exception1);
    register exception_checker1(clock, reset, data_exception1 || data_exception2, data_exception1, data_exception2);

    register multdiv_output_latch(clock, reset, data_resultRDY, multdiv_output, multdiv_output_q);
    register multdiv_IR_latch(clock, reset, one_1_bit, q_imem_IR_to_XM, q_imem_IR_to_PW);

    register store_rdy_1_cycle(clock, reset, data_resultRDY || enable_multdiv_ctrl, data_resultRDY, enable_multdiv_ctrl);

    register store_rdy_2_cycle(clock, reset, enable_multdiv_ctrl || enable_multdiv_ctrl_out, enable_multdiv_ctrl, enable_multdiv_ctrl_out);

    alu alu_for_PC_from_DX(PC_data_result_out, sx_immed, 5'b00000,
            5'b00000, to_PC_mux_2, isNotEqual2, isLessThan2, overflow2);

    wire [4:0] check;
    assign check = q_imem_IR_to_XM[31:27];

    assign bne = ((check == 5'b00010) && (isNotEqual1 == 1'b1)) ? 1'b1 : 1'b0;

    assign blt = ((check == 5'b00110) && ((isNotEqual1 == 1'b1) && (isLessThan1 == 1'b0))) ? 1'b1 : 1'b0;

    or select_for_PC(select_PC, blt, bne);

    mux_2 blt_mux(send_to_PC_temp1, select_PC, PC_data_result, to_PC_mux_2);

    wire [4:0] j_ctrl, jr_ctrl;
    assign j_ctrl = q_imem_IR_to_XM[31:27];
    wire j, jr, bex;
    assign target[26:0] = q_imem_IR_to_XM[26:0];
    assign target[31:27] = 5'b00000;


    assign j = (j_ctrl == 5'b00001) ? 1'b1 : 1'b0;
    assign jal = (q_imem_IR_to_XM[31:27] == 5'b00011) ? 1'b1 : 1'b0;

    or j_or_jal(j_jal, j, jal);
    mux_2 j_mux(send_to_PC_temp2, j_jal, send_to_PC_temp1, target);


    assign jr_ctrl = q_imem_IR_to_XM[31:27];
    assign jr = (jr_ctrl == 5'b00100) ? 1'b1 : 1'b0;

    assign bex = (q_imem_IR_to_XM[31:27] == 5'b10110) ? 1'b1 : 1'b0;

    mux_2 bex_mux(send_to_PC_temp3, bex, send_to_PC_temp2, target);


    mux_2 jr_mux(send_to_PC, jr, send_to_PC_temp3, data_readRegB_out);

    or (jumps_occur, j, jr, jal, bex);
    //and 

//    mux_2 output_mult_mux(ALU_output, enable_multdiv_ctrl, ALU_output_d, multdiv_output);

// XM Stage
    
    register XM_overflow_reg(clock, reset, ~multdiv_ctrl, overflow1, next_overflow1);
    register XM_output_latch(clock, reset, ~multdiv_ctrl, ALU_result, ALU_output_q);
    register XM_IR_latch(clock, reset, ~multdiv_ctrl, q_imem_IR_to_XM, q_imem_IR_to_MW);
    register XM_B_latch(clock, reset, ~multdiv_ctrl, data_readRegB_out, data_readRegB_out_XM);

    wire [4:0] op_in_from_XM;
    assign op_in_from_XM = q_imem_IR_to_MW[31:27];

    wire data_mem_mux_ctrl;
    assign data_mem_mux_ctrl = ((op_in_from_XM == 5'b00111) && (q_imem_IR_to_MW[26:22] != q_imem_IR_to_data[26:22])) ? 1'b1 : 1'b0;

    assign wren = (op_in_from_XM == 5'b00111) ? 1'b1 : 1'b0;

    mux_2 to_data_mem(data, data_mem_mux_ctrl, data_writeReg, data_readRegB_out_XM); // define select *****

    assign address_dmem = ALU_output_q;
//    assign data = data_readRegB_out_XM;

    mux_2 output_mult_mux(ALU_output, enable_multdiv_ctrl, ALU_output_q, multdiv_output_q);


// MW Stage
    
    register MW_overflow_reg(clock, reset, ~multdiv_ctrl, next_overflow1, overall_overflow);
    register MW_output_latch(clock, reset, ~multdiv_ctrl, ALU_output, ALU_output_q_out);
    register MW_data_latch(clock, reset, ~multdiv_ctrl, q_dmem, q_dmem_out);
    register MW_IR_latch(clock, reset, ~multdiv_ctrl, q_imem_IR_to_MW, q_imem_IR_to_data);

    wire [1:0] writedata_mux_ctrl;

    wire [4:0] out_op;
    assign out_op = q_imem_IR_to_data[31:27];

    mux_2_5_bit writeReg_ctrl(ctrl_writeReg_temp, jal, q_imem_IR_to_data[26:22], 5'b11111);


    assign control_overflow = (PC_q == 32'd1) || (PC_q == 32'd2) || (PC_q == 32'd3) || (PC_q == 32'd4) ? 1'b1 : 1'b0;

    mux_2_1_bit over(overall_overflow1, control_overflow, overall_overflow, 1'b0);

    assign write_setx = (q_imem_IR_to_data[31:27] == 5'b10101) || (overall_overflow1 == 1'b1) ? 1'b1 : 1'b0;
    mux_2_5_bit final_writeReg_mux(ctrl_writeReg, write_setx, ctrl_writeReg_temp, 5'b11110);

//    assign ctrl_writeReg = q_imem_IR_to_data[26:22];
    assign ctrl_writeEnable = ((out_op == 5'b00000) || (out_op == 5'b00101) || (out_op == 5'b01000) || out_op == 5'b10101) ? 1'b1 : 1'b0;

    wire data_out_ctrl;
    assign data_out_ctrl = (out_op == 5'b01000) ? 1'b1 : 1'b0;


    mux_2 to_regfile(data_writeReg_temp, data_out_ctrl, ALU_output_q_out, q_dmem_out);

//    mux_2 muldiv_ctrl_mux(data_writeReg_temp1, enable_multdiv_ctrl, data_writeReg_temp, multdiv_output_q);

    mux_2 jal_mux(data_writeReg, jal, data_writeReg_temp, PC_data_result_out);

//    wire multdiv_exceptions_found, val_to_write_multdiv;
//    assign multdiv_exceptions_found = (q_imem_IR_to_MW[4:2] == 3'b110 || q_imem_IR_to_MW[4:2] == 3'b111) && data_exception2 == 1'b1) ? 1'b1 : 1'b0;


    


//    mux_4 to_regfile(data_writeReg, 2'b00, ALU_output_q_out, q_dmem_out, multdiv_output_q, 32'd0);  // need to define select


// Data Hazards

    assign compare_in_A1[7:5] = 3'b000;
    assign compare_in_A2[7:5] = 3'b000;
    assign compare_in_A1[4:0] = q_imem_IR_to_DX[21:17];
    assign compare_in_A2[4:0] = q_imem_IR_to_DX[16:12];
    assign compare_in_B1[7:5] = 3'b000;
    assign compare_in_B2[7:5] = 3'b000;
    assign compare_in_B1[4:0] = q_imem_IR_to_XM[26:22];
    assign compare_in_B2[4:0] = q_imem_IR_to_MW[26:22];
    assign DXload_check[7:5] = 3'b000;
    assign DXload_check[4:0] = q_imem_IR_to_XM[31:27];
    assign FDstore_check[7:5] = 3'b000;
    assign FDstore_check[4:0] = q_imem_IR_to_DX[31:27];


    eight_bit_comparator FDRS1_DXRD(EQi1, GTi1, compare_in_A1, compare_in_B1, one_1_bit, zero_1_bit);
    eight_bit_comparator FDRS2_DXRD(EQi3, GTi3, compare_in_A2, compare_in_B1, one_1_bit, zero_1_bit);
    eight_bit_comparator DXOp_LOAD(EQi2, GTi2, DXload_check, 8'b00001000, one_1_bit, zero_1_bit);
    eight_bit_comparator FDOp_STORE(EQi4, GTi4, FDstore_check, 8'b00000111, one_1_bit, zero_1_bit);

    not flip_FDOp_STORE(not_EQi4, EQi4);

//    assign stall = ((q_imem_IR_to_XM[31:27] == 5'b01000) && ((q_imem_IR_to_DX[21:17] == q_imem_IR_to_XM[26:22]) || ((q_imem_IR_to_DX[16:12] == q_imem_IR_to_XM[26:22]) && q_imem_IR_to_DX[31:27] != 5'b00111)));

    or data_hazard_detection(data_hazard, EQi1, EQi3);
    and and1_for_stall(check_not_store, data_hazard, not_EQi4);
      and and2_for_stall(stall, check_not_store, EQi2);
    not stall_PC_and_FD_enable(not_stall, stall);


// Bypassing

    // Bypassing for DX
    assign bypass_inA1[7:5] = 3'b000;
    assign bypass_inA2[7:5] = 3'b000;
    assign bypass_inA3[7:5] = 3'b000;
    assign bypass_inB1[7:5] = 3'b000;
    assign bypass_inB2[7:5] = 3'b000;
    assign bypass_inA1[4:0] = q_imem_IR_to_XM[21:17]; 
    assign bypass_inA2[4:0] = q_imem_IR_to_XM[16:12];
    assign bypass_inA3[4:0] = q_imem_IR_to_XM[26:22];
    assign bypass_inB1[4:0] = q_imem_IR_to_MW[26:22];
    assign bypass_inB2[4:0] = q_imem_IR_to_data[26:22];

    eight_bit_comparator bypass_check1(select_bypass1, GTi5, bypass_inA1, bypass_inB1, one_1_bit, zero_1_bit);
    eight_bit_comparator bypass_check2(select_bypass2, GTi6, bypass_inA1, bypass_inB2, one_1_bit, zero_1_bit);

    assign bypass_ALUinA[1] = select_bypass2;
    assign bypass_ALUinA[0] = select_bypass1;

    mux_4_2_bit ALU_inA(ctrl_ALU_inA, bypass_ALUinA, 2'b10, 2'b00, 2'b01, 2'b00);

    assign bypass_branch_ctrl = ((q_imem_IR_to_XM[31:27] == 5'b00010) || (q_imem_IR_to_XM[31:27] == 5'b00110)) ? 1'b1 : 1'b0;

    mux_2_8_bit choosing_what_to_bypass(out_bypassB, bypass_branch_ctrl, bypass_inA2, bypass_inA3);

    eight_bit_comparator bypass_check3(select_bypass3, GTi7, out_bypassB, bypass_inB1, one_1_bit, zero_1_bit);
    eight_bit_comparator bypass_check4(select_bypass4, GTi8, out_bypassB, bypass_inB2, one_1_bit, zero_1_bit);

    assign bypass_ALUinB[1] = select_bypass4;
    assign bypass_ALUinB[0] = select_bypass3;

    mux_4_2_bit ALU_inB(ctrl_ALU_inB, bypass_ALUinB, 2'b10, 2'b00, 2'b01, 2'b00);


endmodule
