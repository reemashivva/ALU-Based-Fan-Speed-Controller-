`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 22:36:52
// Design Name: 
// Module Name: TempFanController
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


module TempFanController (
    input [7:0] temp_in,          // Temperature input
    input clk,
    output reg [1:0] fan_speed    // 00 = Low, 01 = Med, 10 = High
);
    // ALU I/O
    reg [2:0] Opcode;
    reg [7:0] Operand1, Operand2;
    wire [15:0] Result;
    wire flagC, flagZ;

    // ALU instance
    alu U1 (
        .Opcode(Opcode),
        .Operand1(Operand1),
        .Operand2(Operand2),
        .Result(Result),
        .flagC(flagC),
        .flagZ(flagZ)
    );

    // Internal result for comparisons
    reg [7:0] diff20, diff40;

    always @(*) begin
        Opcode = 3'b001; // SUB

        // temp - 20
        Operand1 = temp_in;
        Operand2 = 8'd20;
        #1; // allow ALU to compute (for simulation only)
        diff20 = Result[7:0];

        // temp - 40
        Operand1 = temp_in;
        Operand2 = 8'd40;
        #1;
        diff40 = Result[7:0];

        // Compare MSBs
        if ($signed(diff20) < 0) begin
    fan_speed = 2'b00; // Low
end else if ($signed(diff40) < 0) begin
    fan_speed = 2'b01; // Medium
end else begin
    fan_speed = 2'b10; // High
end

    end

endmodule


