`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/12 12:41:38
// Design Name:
// Module Name: testbench
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


module testbench();
    reg clk, reset;
    wire [31:0] writedata, dataadr;
    wire memwrite;
    //instantiate device to be tested
    top dut(clk, reset, writedata, dataadr, memwrite);
    
    //initialize test
    initial begin
        reset <= 1;#2;
        reset <= 0;
    end
    
    //generate clock to sequence tests
    always begin
        clk <= 1;#5;
        clk <= 0;#5;
    end
    
    // check results
    // test 1
    always @ (negedge clk)
    begin
        if (memwrite) begin
            if (dataadr === 84 & writedata === 7) begin
                $display ("Simulation succeeded");
                $stop;
                end else if (dataadr !== 80) begin
                $display ("Simulation failed");
                $stop;
            end
        end
    end
    // test 2
    // always @(negedge clk) begin
    //     if (memwrite) begin
    //         if (dataadr === 96 && writedata === {32{1'b1}}) begin
    //             $display("Congratulations, simulation succeeded!");
    //             $stop;
    //         end
    //     end
    // end
endmodule
