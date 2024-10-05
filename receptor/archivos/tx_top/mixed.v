`timescale 1ns / 1ps

module mixed(
    input clk,
    input rst,
    input [15:0] signal,
    input [15:0] cosine,
    input [15:0] sine,
    output [15:0] signal_real,
    output [15:0] signal_img
    );


wire [15:0] signal_r;
wire [15:0] signal_i;

// MULTIPLICADOR PARTE REAL
mult_gen_cos mult_cos (
    .CLK(clk),
    .A(signal),
    .B(cosine),
    .P(signal_r)
    );
    
// MULTIPLICADOR PARTE IMAGINARIA
mult_gen_cos mult_sine (
    .CLK(clk),
    .A(signal),
    .B(sine),
    .P(signal_i)
    );

assign signal_real = signal_r;
assign signal_img = signal_i;

endmodule



