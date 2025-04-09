`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2025 20:37:25
// Design Name: 
// Module Name: kogge_stone_adder
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


module kogge_stone_adder #(parameter N = 8) (
    input [N-1:0] A, B,
    input Cin,
    output [N-1:0] Sum,
    output Cout
);
    wire [N:0] carry; 
    wire [N-1:0] G, P;
    
    assign carry[0] = Cin;
    assign G = A & B;  // Generate
    assign P = A ^ B;  // Propagate

    genvar i, j;
    generate
        for (i = 0; i < $clog2(N); i = i + 1) begin : prefix_stage
            for (j = 0; j < N; j = j + 1) begin : prefix
                if (j >= (1 << i))
                    assign carry[j+1] = G[j] | (P[j] & carry[j - (1 << i) + 1]);
                else
                    assign carry[j+1] = G[j] | (P[j] & carry[j]); // Fixing propagation
            end
        end
    endgenerate

    assign Sum = P ^ carry[N-1:0]; 
    assign Cout = carry[N];

endmodule
