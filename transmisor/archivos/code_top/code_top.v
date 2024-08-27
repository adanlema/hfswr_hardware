module code_top (
    input        i_clk,
    input        i_rst,
    input        i_sinc,
    input [31:0] i_codigo,
    input [31:0] i_numdig,
    input [31:0] i_tb,

    output [15:0] o_signal
);

  // reg | wire
  wire signal_code;

  // instanciacion de los modulos
  code_generator generador (
      .clk(i_clk),
      .rst(i_rst),
      .sinc(i_sinc),
      .codigo(i_codigo),
      .num_dig(i_numdig),
      .tiempo_b(i_tb),
      .out(signal_code)
  );

  code_signal signal (
      .clk(i_clk),
      .rst(i_rst),
      .sinc(i_sinc),
      .code(signal_code),
      .code_out(o_signal)
  );

endmodule
