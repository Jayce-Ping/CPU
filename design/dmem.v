`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 13:02:57
// Design Name: 
// Module Name: dmem
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


module dmem(//data memory
    input clk, we,
    input [2:0] readcontrol,
    input [1:0] writecontrol,
    input [31:0] a, wd,
    output [31:0] rd
    );
    reg [7:0] RAM[255:0];//addressed by byte
    reg [31:0] readout;
    always @(*) begin
        case(readcontrol)
            3'b000 : readout = { { 24{ RAM[a][7] } }, RAM[a]};//load byte
            3'b001 : readout = { 24'b0 , RAM[a]};//load byte unsigned
            3'b010 : readout = { { 16{ RAM[a+1][7]}}, RAM[a+1], RAM[a]};//load half word
            3'b011 : readout = { 16'b0, RAM[a+1], RAM[a]};//load half word unsigned
            3'b100 : readout = {RAM[a+3], RAM[a+2], RAM[a+1], RAM[a]};//load word
            default readout = {RAM[a+3], RAM[a+2], RAM[a+1], RAM[a]};//load word default
        endcase
    end
    assign rd = readout;

    always @(posedge clk) begin
        if(we) begin 
            case(writecontrol)
                2'b00 : {RAM[a+3], RAM[a+2], RAM[a+1], RAM[a]} <= wd;//store word
                2'b01 : {RAM[a+1], RAM[a]} <= {wd[15:8], wd[7:0]};//store half word
                2'b10 : RAM[a] <= wd[7:0];//store byte
                default : {RAM[a+3], RAM[a+2], RAM[a+1], RAM[a]} <= wd;//store word default
            endcase
        end
    end
endmodule
