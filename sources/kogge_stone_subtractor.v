`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2025 22:10:48
// Design Name: 
// Module Name: kogge_stone_subtractor
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


module kogge_stone_subtractor #(parameter N = 8) (
    input [N-1:0] A, B,
    output [N-1:0] Diff,
    output Bout
);
    wire [N-1:0] B_complement;
    wire [N-1:0] sum;
    wire cout;
    
    // Compute two's complement of B (B' + 1)
    assign B_complement = ~B + 1'b1;  
    
    // Use Kogge-Stone Adder to perform subtraction
    kogge_stone_adder #(N) KSA (
        .A(A),
        .B(B_complement),
        .Cin(1'b0),
        .Sum(sum),
        .Cout(cout)
    );
    
    assign Diff = sum;
    assign Bout = ~cout; // Borrow flag
endmodule

