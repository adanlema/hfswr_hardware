module code_top #(
    parameter NB_REG    = 32,
    parameter NB_OUTPUT = 16
) (
    input                  i_clk,
    input                  i_rst,
    input                  i_sinc,
    input [NB_REG - 1 : 0] i_codigo,
    input [NB_REG - 1 : 0] i_numdig,
    input [NB_REG - 1 : 0] i_tb,

    output [NB_OUTPUT - 1 : 0] o_signal
);

  //////////////////////////////////////////////////////////////////////////////////
  //      WIRE AND REGISTERS
  //////////////////////////////////////////////////////////////////////////////////

  wire w_code;

  //////////////////////////////////////////////////////////////////////////////////
  //      INSTANCE MODULES
  //////////////////////////////////////////////////////////////////////////////////

  code_generator #(
      .NB_REG(NB_REG)
  ) generador (
      .clk(i_clk),
      .rst(i_rst),
      .sinc(i_sinc),
      .codigo(i_codigo),
      .num_dig(i_numdig),
      .tiempo_b(i_tb),
      .out(w_code)
  );

  code_signal #(
      .NB_OUTPUT(NB_OUTPUT)
  ) signal (
      .clk(i_clk),
      .rst(i_rst),
      .sinc(i_sinc),
      .code(w_code),
      .code_out(o_signal)
  );

endmodule
