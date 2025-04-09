`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2025 20:40:42
// Design Name: 
// Module Name: wallace_multiplier
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


module wallace_multiplier #(parameter N = 8) (
    input [N-1:0] A, B,
    output [2*N-1:0] Product
);
    wire [N-1:0] partial_products [N-1:0];

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : partial_product_gen
            for (j = 0; j < N; j = j + 1) begin : bit_product
                assign partial_products[i][j] = A[i] & B[j];
            end
        end
    endgenerate

    // Wallace Tree Reduction
    reg [2*N-1:0] sum, carry;
    integer k;

    always @(*) begin
        sum = 0;
        carry = 0;

        for (k = 0; k < N; k = k + 1) begin
            sum = sum + ({ {N{1'b0}}, partial_products[k] } << k);
        end
    end

    wire [2*N-1:0] kogge_sum;
    wire cout;

    // Instantiate Kogge-Stone Adder for Final Summation
    kogge_stone_adder #(2*N) KSA (
        .A(sum),
        .B(carry),
        .Cin(0),
        .Sum(kogge_sum),
        .Cout(cout)
    );

    assign Product = kogge_sum;

endmodule

