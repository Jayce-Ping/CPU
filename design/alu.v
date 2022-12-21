`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/12 13:18:51
// Design Name:
// Module Name: alu
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


module alu #(parameter N = 32)
            (input[N-1:0] A,     //left operand
             input[N-1:0] B,     //right operand
             input[4:0] OP,
             output reg[N:1] F, FF,    //result
             output ZF,
             output reg whl);// write hi & lo register
    reg C,CF,OF,SF,PF;
    reg signed [N-1:0] AA, BB;
    reg[4:0] a;
    always @(*) begin
        C   <= 0;
        AA <= A;
        BB <= B;
        whl = 0;
        a <= A[4:0];
        case (OP)
            5'b00000 : F      = A & B;//and
            5'b00001 : F      = A | B;//or
            5'b00010 : F      = A ^ B;//xor
            5'b00011 : F      = ~(A | B);//nor
            5'b00100 : {C, F} = A + B;//add
            5'b00101 : {C, F} = AA + BB;//addu
            5'b00110 : {C, F} = A - B;//sub
            5'b00111 : {C, F} = AA - BB;//subu
            5'b01000 : F = AA < BB;//slt
            5'b01001 : F = A < B;//sltu
            5'b01010 : F = B << a;//sll
            5'b01011 : F = B >> a;//srl
            5'b01100 : F = BB >>> a;//sra
            5'b01101 : F = B << a;//sllv
            5'b01110 : F = B >> a;//srlv
            5'b01111 : F = BB >>> a;//srav
            5'b10000 : F = A;//jr   F = A
            5'b10001 : begin {FF, F} = AA * BB; whl = 1;end//mult
            5'b10010 : begin {FF, F} = {1'b0,A} * {1'b0,B}; whl = 1;end//multu
            5'b10011 : begin F = AA / BB; FF = AA % BB;whl = 1;end//div
            5'b10100 : begin F = {1'b0,A} / {1'b0,B}; FF = {1'b0,A} % {1'b0,B};whl = 1;end//divu
            5'b10101 : F = {B, 16'b0};//lui
        endcase
        CF <= C;
        OF <= A[N-1] ^ B[N-1] ^ C;
        SF <= F[N-1];
        PF <= ^F;
    end
    assign ZF = (F == 0);
endmodule
