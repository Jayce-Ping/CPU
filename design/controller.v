`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 12:00:57
// Design Name: 
// Module Name: controller
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


module controller(
    input [5:0] op, funct,
    input zero, 
    output memtoreg, memwrite,
    output pcsrc, alusrc,
    output regdst, shamtsrc ,regwrite,
    output jump, jal, jr,
    output [4:0] alucontrol,
    output [2:0] readcontrol,
    output [1:0] writecontrol
    );
    wire [3:0] aluop;
    wire branch;

    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, jal, aluop, readcontrol, writecontrol);
    
    aludec ad(funct, aluop, alucontrol, jr, shamtsrc);

    assign pcsrc = branch & ( (zero & ~op[0]) | (~zero & op[0]) );//beq or bne
endmodule
