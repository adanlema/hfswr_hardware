`timescale 1ns / 1ps

module enable_slicer(
    input [3:0] en,
    output      en_a_1,
    output      en_b_1,
    output      en_a_2,
    output      en_b_2
    );
    
assign en_a_1 = en[0];
assign en_b_1 = en[1];
assign en_a_2 = en[2];
assign en_b_2 = en[3];

endmodule
