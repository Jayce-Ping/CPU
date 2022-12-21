`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/12 13:03:12
// Design Name: 
// Module Name: imem
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


module imem(//instruction memory
    input [5:0] a,
    output [31:0] rd
    );
    reg [31:0] RAM[63:0];

    initial begin
        $readmemh("D:\\CompositionExperiment\\final\\cpu\\test.dat", RAM);//change to your own instruction memory file path
    end
    assign rd = RAM[a];//word aligned
endmodule
