`timescale 1ns / 1ps
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, RegFile and Memory elements together.
 * 
 * We will be using our own separate Wrapper.v to test your code. You are allowed to make changes to the Wrapper file for your
 * own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 47 to add the memory file of the test you created using the assembler
 * For example, you would add sample.mem inside of the quotes after assembling sample.s
 *
 **/

module Wrapper(clock, reset, mwe1, memAddr1, memDataIn1, memDataOut1);
    input clock, reset;
    input[31:0] memDataOut1;
    output[31:0] memDataIn1, memAddr1;
    output mwe1;

    wire rwe, mwe;
    wire[4:0] rd, rs1, rs2;
    wire[31:0] instAddr, instData, 
               rData, regA, regB,
               memAddr, memDataIn, memDataOut;
    
    //assign memDataOut1 = memDataOut;
    //assign memDataIn1 = memDataIn;
    //assign memAddr1 = memAddr;
    //assign mwe1 = mwe;
    
    ///// Main Processing Unit
    processor CPU(.clock(clock), .reset(reset), 
                  
		  ///// ROM
                  .address_imem(instAddr), .q_imem(instData),
                  
		  ///// Regfile
                  .ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
                  .ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
                  .data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),
                  
		  ///// RAM
                  .wren(mwe1), .address_dmem(memAddr1), 
                  .data(memDataIn1), .q_dmem(memDataOut1)); 
                  
    ///// Instruction Memory (ROM)
    ROM #(.MEMFILE("C:/Users/nyehn/Brad_ECE350_Work/new_processor/ECE350F2020ToolChain/grayscale.mem")) // Add your memory file here
    InstMem(.clk(~clock), 
            .wEn(1'b0), 
            .addr(instAddr[11:0]), 
            .dataIn(32'b0), 
            .dataOut(instData));
    
    ///// Register File
    regfile RegisterFile(.clock1(clock), 
             .ctrl_writeEnable(rwe), .ctrl_reset(reset), 
             .ctrl_writeReg(rd),
             .ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
             .data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
             
    ///// Processor Memory (RAM)



//    RAM #(
//        .DEPTH(12),             // Set RAM depth to contain every pixel
//        .DATA_WIDTH(32),      // Set data width according to the color palette
//        .ADDRESS_WIDTH(12),     // Set address with according to the pixel count
//        .MEMFILE("C:/Users/nyehn/Brad_ECE350_Work/FinalProjectFiles/image_with_colors.mem"))
//    ProcMem(.clk(clock), 
//            .wEn(mwe), 
//            .addr(memAddr[11:0]), 
//            .dataIn(memDataIn), 
//            .dataOut(memDataOut));

endmodule
