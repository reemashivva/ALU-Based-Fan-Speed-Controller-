`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2025 20:38:39
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


module TempFanController_tb;

    reg [7:0] temp_in;
    reg clk;
    wire [1:0] fan_speed;

    // Instantiate the design under test (DUT)
    TempFanController uut (
        .temp_in(temp_in),
        .clk(clk),
        .fan_speed(fan_speed)
    );

    // Clock generation (if needed)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Stimulus block
    initial begin
        $display("Time\tTemp\tFanSpeed");
        $monitor("%g\t%d\t%b", $time, temp_in, fan_speed);

        // Test 1: Low speed (temp < 20)
        temp_in = 8'd10; #20;

        // Test 2: Medium speed (temp between 20 and 40)
        temp_in = 8'd25; #20;

        // Test 3: Edge of medium range
        temp_in = 8'd40; #20;

        // Test 4: High speed (temp > 40)
        temp_in = 8'd50; #20;

        // Test 5: Boundary test
        temp_in = 8'd20; #20;

        // Test 6: Boundary test
        temp_in = 8'd41; #20;

        $finish;
    end

endmodule

