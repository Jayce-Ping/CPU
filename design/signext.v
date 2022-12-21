`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 12:02:46
// Design Name: 
// Module Name: signext
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


module signext(// sign extend
    input [15:0] a,
    output [31:0] y
    );
    
    assign y = {{ 16{a[15]} }, a};
endmodule
