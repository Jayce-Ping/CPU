`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 13:02:25
// Design Name: 
// Module Name: top
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


module top(
    input clk, reset,
    output [31:0] writedata, dataadr,
    output memwrite
    );
    wire [31:0] pc, instr, readdata;
    wire [2:0] readcontrol;
    wire [1:0] writecontrol;
    //instantiate processor and memories
    mips mips(clk, reset, pc, instr, memwrite, dataadr, writedata, readdata, readcontrol, writecontrol);
    imem imem(pc[7:2], instr);
    dmem dmem(clk, memwrite, readcontrol, writecontrol, dataadr, writedata, readdata);
endmodule
