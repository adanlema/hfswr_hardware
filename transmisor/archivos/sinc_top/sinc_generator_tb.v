`timescale 1ns / 1ps

module sinc_generator_tb;

  parameter MS = 1000000;
  parameter SIM_TIME = 23 * MS;
  localparam NB_REG = 32;

  // Wire and registers
  reg                   clk;
  reg                   rst;
  reg                   start;
  reg  [NB_REG - 1 : 0] prt;
  reg  [NB_REG - 1 : 0] period;
  wire                  sinc;

  // Module Instance
  sinc_generator #(
      .NB_REG(NB_REG)
  ) sinc_gen (
      .clk(clk),
      .rst(rst),
      .start(start),
      .PRT_count_wire(prt),
      .T_count_wire(period),
      .sinc(sinc)
  );

  // Clock 122.88MHz
  always #4.069 clk = ~clk;


  initial begin
    // Open GTKWave
    $dumpfile("sinc_generator_tb.vcd");
    $dumpvars(0, sinc_generator_tb);

    clk    = 0;
    rst    = 0;
    prt    = 32'd2457600;  // PRF = 50Hz
    period = 32'd270336;  // AB = 5 kHz
    start  = 1;
    #10 rst = 1;
    #SIM_TIME;
    $finish;
  end

endmodule
