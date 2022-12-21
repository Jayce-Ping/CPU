`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 12:01:41
// Design Name: 
// Module Name: aludec
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


module aludec(
    input [5:0] funct,
    input [3:0] aluop,
    output reg[4:0] alucontrol,
    output reg jr, shamtsrc
    );
    always @(*) begin
        shamtsrc <= 0;
        jr <= 0;
        case (aluop)
            4'b0000 : alucontrol <= 5'b00100;//add
            4'b0001 : alucontrol <= 5'b00110;//sub 
            4'b0010 : alucontrol <= 5'b00000;//and
            4'b0011 : alucontrol <= 5'b00001;//or
            4'b0100 : alucontrol <= 5'b00010;//xor
            4'b0101 : alucontrol <= 5'b01000;//slt
            4'b0110 : alucontrol <= 5'b01001;//sltu
            4'b0111 : alucontrol <= 5'b10101;//lui
            default: case(funct) // R-TYPE
                6'b000000: begin alucontrol <= 5'b01010; shamtsrc <= 1;end //sll shift left logical
                6'b000010: begin alucontrol <= 5'b01011; shamtsrc <= 1;end//srl shift right logical
                6'b000011: begin alucontrol <= 5'b01100; shamtsrc <= 1;end//sra shift right arithemetic
                6'b000100: alucontrol <= 5'b01101; //sllv shift left logical variable
                6'b000110: alucontrol <= 5'b01110; //srlv shift right logical variable
                6'b000111: alucontrol <= 5'b01111; //srav shift right artithmetic variable
                6'b001000: begin alucontrol <= 5'b10000; jr <= 1;end //jr jump register
                6'b011000: alucontrol <= 5'b10001; //mult
                6'b011001: alucontrol <= 5'b10010; //multu
                6'b011010: alucontrol <= 5'b10011; //div
                6'b011011: alucontrol <= 5'b10100; //divu
                6'b100000: alucontrol <= 5'b00100; //add
                6'b100001: alucontrol <= 5'b00101; //addu
                6'b100010: alucontrol <= 5'b00110; //sub
                6'b100011: alucontrol <= 5'b00111; //subu
                6'b100100: alucontrol <= 5'b00000; //and
                6'b100101: alucontrol <= 5'b00001; //or
                6'b100110: alucontrol <= 5'b00010; //xor
                6'b100111: alucontrol <= 5'b00011; //nor
                6'b101010: alucontrol <= 5'b01000; //SLT
                6'b101011: alucontrol <= 5'b01001; //sltu
                default: alucontrol <= 5'bxxxxx; // ???
                endcase
        endcase
    end
endmodule
