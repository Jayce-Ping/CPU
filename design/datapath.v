`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 12:01:52
// Design Name: 
// Module Name: datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath (input clk, reset,
                 input memtoreg, pcsrc,
                 input alusrc, regdst, shamtsrc,
                 input regwrite, jump, jal, jr,
                 input [4:0] alucontrol,
                 output zero,
                 output [31:0] pc,
                 input [31:0] instr,
                 output [31:0] aluout, writedata,
                 input [31:0] readdata);
    wire [4:0] writereg, wr;
    wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch, pr;
    wire [31:0] signimm, signimmsh;
    wire [31:0] srca, srcb, mid;
    wire [31:0] result, rs;
    wire whl;
    wire [31:0] aluout_hi;//mult and div hi regitser content
    flopr #(32) pcreg(clk, reset, pcnext, pc);
    adder pcadd1 (pc, 32'b100, pcplus4);
    //pcplus4 = pc + 4
    sl2 immsh(signimm, signimmsh);
    //signimmsh = signimm << 2
    adder pcadd2(pcplus4, signimmsh, pcbranch);
    //pcbranch = pcplus4 + signimmsh
    mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    //pcnextbr = pcsrc ? pcbranch : pcnextbr
    mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pr);
    //pcnext = jump ? {} : pcnextbr
    mux2 #(32) pcjrmux(pr, aluout, jr, pcnext);
    //pcnext = jr ? aluout : pcnext  

    // register file logic
    regfile rf(clk, regwrite, whl, instr[25:21], instr[20:16], writereg, result, aluout_hi, mid, writedata);
    //reg[instr[25:21]] -> mid   reg[instr[20:16]]  -> writedata
    //if(regwrite) reg[writereg] = result
    mux2 #(32) srcamux(mid, {27'b0, instr[10:6]}, shamtsrc, srca);
    // mux2 #(32) srcamux(mid, mid, shamtsrc, srca);
    //srca = shamtsrc ? instr[10:6] : mid;

    mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, wr);
    //writereg = regdst ? instr[15:11] : instr[20:16]  (wr represent writereg)
    mux2 #(5) wjalmux(wr, 5'b11111, jal, writereg);
    //writereg = jal ? 31 : wr
    
    mux2 #(32) resmux(aluout, readdata, memtoreg, rs);
    //result = memtoreg ? readdata : aluout (rs represent result)
    mux2 #(32) jalmux(rs, pcplus4, jal, result);
    //result = jal ? pcplus4 : result
    
    signext se(instr[15:0], signimm);
    // ALU logic
    mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
    //srcb = alusrc ? signimm : writedata

    //this step is for sll,srl and sra
    alu alu(srca, srcb, alucontrol, aluout, aluout_hi, zero, whl);
endmodule
