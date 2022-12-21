`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 12:02:05
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input we3, whl,
    input [4:0] ra1,ra2,wa3,
    input [31:0] wd3,wd4,
    output [31:0] rd1,rd2
    );
    reg [31:0] rf[31:0];
    reg [31:0] hi, lo;//register hi and lo, store the result of muti and div
    //three ported register file
    //read two ports combinationally
    //write third port on rising edge of clock
    //register 0 hardwired to 0

    always @(posedge clk) begin
        if(we3) begin
            if(whl === 1) begin
                hi <= wd4;
                lo <= wd3;
            end
            else rf[wa3] <= wd3;
        end
    end
    assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
    assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
