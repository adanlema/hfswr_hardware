`timescale 1ns / 1ps

module code_top_tb;
  parameter MS = 1000000;
  parameter SIM_TIME = 3 * MS;
  // BARKER 11 - [1],[1],[1],[0],[0],[0],[1],[0],[0],[1],[0]

  // Localparam
  localparam NB_OUTPUT = 8;
  localparam NB_REG = 32;

  // Wire and Registers
  reg                      clk;
  reg                      rst;
  reg                      start;
  reg  [   NB_REG - 1 : 0] prt;
  reg  [   NB_REG - 1 : 0] period;
  reg  [   NB_REG - 1 : 0] num_dig;
  reg  [   NB_REG - 1 : 0] codigo;
  reg  [   NB_REG - 1 : 0] tb;
  wire                     sinc;
  wire [NB_OUTPUT - 1 : 0] signal_code;

  // Module Instance
  sinc_generator #(
      .NB_REG(NB_REG)
  ) sincgen1 (
      .clk(clk),
      .rst(rst),
      .start(start),
      .PRT_count_wire(prt),
      .T_count_wire(period),
      .sinc(sinc)
  );

  code_top #(
      .NB_REG(NB_REG),
      .NB_OUTPUT(NB_OUTPUT)
  ) codetop1 (
      .i_clk(clk),
      .i_rst(rst),
      .i_sinc(sinc),
      .i_codigo(codigo),
      .i_numdig(num_dig),
      .i_tb(tb),
      .o_signal(signal_code)
  );



  // Generador de reloj
  always #4.069 clk = ~clk;

  // Inicialización de señales
  initial begin
    // Con esto puedo abrir el GTKWave
    $dumpfile("code_top_tb.vcd");
    $dumpvars(0, code_top_tb);

    clk     = 0;
    rst     = 0;
    prt     = 32'd2457600;  // PRF = 50Hz
    tb      = 32'd24576;  // AB = 5 kHz
    num_dig = 32'd11;
    period  = 32'd270336;  // num_dig * tb
    codigo  = 32'b11100010010;  // barker_11
    start   = 0;
    #1000;
    start = 1;
    #10 rst = 1;
    #SIM_TIME;
    $finish;
  end

endmodule
