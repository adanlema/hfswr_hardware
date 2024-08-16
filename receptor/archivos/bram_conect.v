module bram_conect(
    //LI
    input           clk,
    input           valid,
    input           sinc,
    input [31:0]    datos_i,
    //LD
    output          en_a_1,
    output          en_b_1,
    output          en_a_2,
    output          en_b_2,
    output  [3:0]   wrt_en,
    output [31:0]   addr,
    output [31:0]   datos_o
    );
    
    
    
    
//////////////////////////////////////////////////////////////////////////////////
//      WIRE AND REGISTERS
//////////////////////////////////////////////////////////////////////////////////

wire            w_sinc;
wire            wrdy_i;
wire            wrdy_o;
wire            wen_a;
wire            wen_b;
wire [3:0]      w_wrt_en;
wire [31:0]     w_addr;
wire [31:0]     w_data;


//////////////////////////////////////////////////////////////////////////////////
//      BLOQUES
//////////////////////////////////////////////////////////////////////////////////
bram_int bram_0 (
    .clk_i(clk),
    .valid(valid),
    .sinc(1'b1),
    .data_i(datos_i),
    .en(w_sinc),
    .rdy_to_read(wrdy_i),
    .wrt_en(w_wrt_en),
    .addr(w_addr),
    .data_o(w_data)
);

detector_flanco bram_1(
    .clk(clk),
    .e(wrdy_i),
    .s(wrdy_o)
);

bram_mux bram_2(
    .sinc(w_sinc),
    .wrt_en_i(w_wrt_en),
    .addr_i(w_addr),
    .data_i(w_data),
    .rdy_to_read(wrdy_o),
    .en_a(wen_a),
    .en_b(wen_b),
    .wrt_en_o(wrt_en),
    .data_o(datos_o),
    .addr_o(addr)
);


buffer_select bram_3(
    .clk(clk),
    .rdy_to_read(wrdy_o),
    .en_a(wen_a),
    .en_b(wen_b),
    .en_a_1(en_a_1),
    .en_b_1(en_b_1),
    .en_a_2(en_a_2),
    .en_b_2(en_b_2)
);



endmodule
