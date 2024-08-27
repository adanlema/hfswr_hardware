`timescale 1ns / 1ps

module code_top_tb;
  parameter MS = 1000000;
  parameter SIM_TIME = 3 * MS;
  // BARKER 11 - [1],[1],[1],[0],[0],[0],[1],[0],[0],[1],[0]

  reg         clk;
  reg         rst;
  reg         start;
  reg  [31:0] prt;
  reg  [31:0] period;
  reg  [31:0] num_dig;
  reg  [31:0] codigo;
  reg  [31:0] tb;
  wire        sinc;
  wire [15:0] signal_code;

  // Instancia de los módulos bajo prueba
  sinc_generator sincgen1 (
      .clk(clk),
      .rst(rst),
      .start(start),
      .PRT_count_wire(prt),
      .T_count_wire(period),
      .sinc(sinc)
  );

  code_top codetop1 (
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
    start   = 1;
    #10 rst = 1;
    #SIM_TIME;
    $finish;
  end

endmodule
