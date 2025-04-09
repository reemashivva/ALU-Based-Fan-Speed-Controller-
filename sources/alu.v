`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2025 22:13:07
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



module alu(
    input [2:0] Opcode,
    input [7:0] Operand1, Operand2,
    output reg [15:0] Result = 16'b0,
    output reg flagC = 1'b0, flagZ = 1'b0
);

    parameter [2:0] ADD = 3'b000, SUB = 3'b001, MUL = 3'b010, 
                     AND_OP = 3'b011, OR_OP = 3'b100, NAND_OP = 3'b101, 
                     NOR_OP = 3'b110, XOR_OP = 3'b111;
    
    wire [7:0] sum_result, sub_result;
    wire add_cout, sub_bout;
    wire [15:0] mul_result;
    
    // Signed versions for subtraction
    wire signed [7:0] signed_op1 = Operand1;
    wire signed [7:0] signed_op2 = Operand2;
    wire signed [7:0] signed_sub_result = signed_op1 - signed_op2;

    // Instantiate Kogge-Stone Adder for Addition
    kogge_stone_adder #(8) KSA (
        .A(Operand1),
        .B(Operand2),
        .Cin(1'b0),
        .Sum(sum_result),
        .Cout(add_cout)
    );
    
    // Instantiate Wallace Multiplier for Multiplication
    wallace_multiplier #(8) WM (
        .A(Operand1),
        .B(Operand2),
        .Product(mul_result)
    );
    
    // Instantiate Kogge-Stone Subtractor
    kogge_stone_subtractor #(8) KSS (
        .A(Operand1),
        .B(Operand2),
        .Diff(sub_result),
        .Bout(sub_bout)
    );
    
    always @(*) begin
        case (Opcode)
            ADD: begin
                Result = {8'b0, sum_result};  // Store full 16-bit result
                flagC = add_cout;
                flagZ = (Result == 16'b0);
            end
            SUB: begin
                Result = {8'b0, signed_sub_result};  // Store signed subtraction
                flagC = ~sub_bout;  // Correct borrow handling
                flagZ = (Result == 16'b0);
            end
            MUL: begin
                Result = mul_result;
                flagZ = (Result == 16'b0);
            end
            AND_OP: begin
                Result = Operand1 & Operand2;
                flagZ = (Result == 16'b0);
            end
            OR_OP: begin
                Result = Operand1 | Operand2;
                flagZ = (Result == 16'b0);
            end
            NAND_OP: begin
                Result = ~(Operand1 & Operand2);
                flagZ = (Result == 16'b0);
            end
            NOR_OP: begin
                Result = ~(Operand1 | Operand2);
                flagZ = (Result == 16'b0);
            end
            XOR_OP: begin
                Result = Operand1 ^ Operand2;
                flagZ = (Result == 16'b0);
            end
            default: begin
                Result = 16'b0;
                flagC = 1'b0;
                flagZ = 1'b0;
            end
        endcase
    end 
endmodule


