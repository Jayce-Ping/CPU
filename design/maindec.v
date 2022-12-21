`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 12:01:24
// Design Name: 
// Module Name: maindec
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


module maindec(
    input [5:0] op,
    output memtoreg, memwrite,
    output branch, alusrc,
    output regdst, regwrite,
    output jump, jal,
    output [3:0] aluop,
    output [2:0] readcontrol,
    output [1:0] writecontrol
    );
    reg [16:0] controls;

    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, jal, aluop, readcontrol, writecontrol} = controls;
    //aluop
    //0000 add
    //0001 sub
    //0010 and
    //0011 or
    //0100 xor
    //0101 slt
    //0110 sltu
    //0111 lui
    //default R-type
    always @(*) begin
        case(op)
        6'b000000: controls <= 17'b11000000_1000_100_00; //R-Type
        6'b000010: controls <= 17'b00000010_0000_100_00; //j
        6'b000011: controls <= 17'b10000011_0000_100_00; //jal
        6'b000100: controls <= 17'b00010000_0001_100_00; //BEQ
        6'b000101: controls <= 17'b00010000_0001_100_00; //BNE
        6'b001000: controls <= 17'b10100000_0000_100_00; //ADDI
        6'b001001: controls <= 17'b10100000_0000_100_00; //ADDIU
        6'b001010: controls <= 17'b10100000_0101_100_00; //slti
        6'b001011: controls <= 17'b10100000_0110_100_00; //sltiu
        6'b001100: controls <= 17'b10100000_0010_100_00; //andi
        6'b001101: controls <= 17'b10100000_0011_100_00; //ori
        6'b001110: controls <= 17'b10100000_0100_100_00; //xori
        6'b001111: controls <= 17'b10100000_0111_100_00; //lui
        6'b100000: controls <= 17'b10100100_0000_000_00; //lb
        6'b100001: controls <= 17'b10100100_0000_010_00; //lh
        6'b100011: controls <= 17'b10100100_0000_100_00; //lw
        6'b100100: controls <= 17'b10100100_0000_001_00; //lbu
        6'b100101: controls <= 17'b10100100_0000_011_00; //lhu
        6'b101000: controls <= 17'b00101000_0000_100_10; //sb
        6'b101001: controls <= 17'b00101000_0000_100_01; //sh
        6'b101011: controls <= 17'b00101000_0000_100_00; //sw
        default: controls <= {17{1'bx}}; //???
        endcase
    end
endmodule
