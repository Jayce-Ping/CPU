`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 12:00:30
// Design Name: 
// Module Name: mips
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


module mips(
    input clk, reset,
    output [31:0]  pc,
    input [31:0] instr,
    output memwrite,
    output [31:0] aluout, writedata,
    input [31:0] readdata,
    output [2:0] readcontrol,
    output [1:0] writecontrol
    );

    wire memtoreg, pcsrc, alusrc, regdst, regwrite, jump, jal, jr, shamtsrc;
    wire [4:0] alucontrol;
    controller c(instr[31:26], instr[5:0], zero, memtoreg, memwrite, pcsrc, alusrc, regdst, shamtsrc , regwrite, jump, jal, jr, alucontrol, readcontrol, writecontrol);
    datapath dp(clk, reset, memtoreg, pcsrc, alusrc, regdst, shamtsrc, regwrite, jump, jal, jr, alucontrol, zero, pc, instr, aluout, writedata, readdata);
endmodule
