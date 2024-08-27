`timescale 1ns / 1ps

/**
 * GENERAL DESCRIPTION:
 *
 *   PHASE  ------------------------------------|       /-------\
 *                    /--------------\          |-----> |       |
 *   START. --------> |              |                  |  OSC  |
 *   PRT -----------> | SINCRONISMO  | ---------------> |       |
 *   PERIOD --------> |              |                  \-------|
 *                    \-------------/                       |
 *                          |                               |
 *                          |                               |       /--------\
 *                          |--->  /--------\               |----> |         |
 *   CODIGO -------------------->  |        |                      |  MIXED  |  ------> DAC DATOS
 *   NUM_DIG ------------------->  |  CODE  |  ------------------> |         |  
 *   t_b ----------------------->  |        |                      \--------/
 *                                 \-------/
 *
 * Diagrama de bloques del Transmisor del Radar de Onda Superficial
 * 
 */


module tx_radar (
    input  [ 1:0] adc_clk_i,
    input         exp_r_io,
    // REGISTERS MEMORY
    input         start,
    input  [31:0] phase,
    input  [31:0] period,
    input  [31:0] prt,
    input  [31:0] codigo,
    input  [31:0] num_dig,
    input  [31:0] t_b,
    // SIGNAL DAC
    output [13:0] dac_dat_o,  // DAC combined data
    output        dac_wrt_o,  // DAC write
    output        dac_sel_o,  // DAC channel select
    output        dac_clk_o,  // DAC clock
    output        dac_rst_o,  // DAC reset
    // CLK and SINCRONISMO
    output        exp_p_io,
    output        exp_n_io,
    output        exp_s_io
);

  //////////////////////////////////////////////////////////////////////////////////
  //      WIRE AND REGISTERS
  //////////////////////////////////////////////////////////////////////////////////
  // CLK ADC
  wire        adc_clk_in;

  // PLL signals
  wire        adc_clk_in;
  wire        pll_adc_clk;
  wire        pll_dac_clk_1x;
  wire        pll_dac_clk_2x;
  wire        pll_dac_clk_2p;
  wire        pll_locked;
  wire        adc_clk;
  // DAC signals
  wire        dac_clk_1x;
  wire        dac_clk_2x;
  wire        dac_clk_2p;
  reg         dac_rst;

  // Sincronismo
  wire        sincronismo;

  // OSCILADOR
  wire        dds_data_tvalid;
  wire [15:0] dds_data_tdata;

  // GENERADOR DEL CODIGO
  wire [15:0] mixed_data_input;

  // MIXED
  wire [15:0] signal_mod;
  reg  [13:0] signal_acon;
  wire [13:0] signal_dac;

  //////////////////////////////////////////////////////////////////////////////////
  //      CLK ADC INPUT and PLL
  //////////////////////////////////////////////////////////////////////////////////

  // differential clock input
  IBUFDS i_clk (
      .I (adc_clk_i[1]),
      .IB(adc_clk_i[0]),
      .O (adc_clk_in)
  );

  pll nco_pll (
      .clk       (adc_clk_in),      // clock
      .rstn      (exp_r_io),        // reset - active low
      .clk_adc   (pll_adc_clk),     // ADC clock
      .clk_dac_1x(pll_dac_clk_1x),  // DAC clock 125MHz
      .clk_dac_2x(pll_dac_clk_2x),  // DAC clock 250MHz
      .clk_dac_2p(pll_dac_clk_2p),  // DAC clock 250MHz -45DGR
      .pll_locked(pll_locked)
  );

  // DAC reset (active high)
  always @(posedge dac_clk_1x) begin
    dac_rst <= ~exp_r_io | ~pll_locked;
  end
  BUFG bufg_adc_clk (
      .O(adc_clk),
      .I(pll_adc_clk)
  );
  BUFG bufg_dac_clk_1x (
      .O(dac_clk_1x),
      .I(pll_dac_clk_1x)
  );
  BUFG bufg_dac_clk_2x (
      .O(dac_clk_2x),
      .I(pll_dac_clk_2x)
  );
  BUFG bufg_dac_clk_2p (
      .O(dac_clk_2p),
      .I(pll_dac_clk_2p)
  );


  //////////////////////////////////////////////////////////////////////////////////
  //     GENERACION DEL SINCRONISMO
  //////////////////////////////////////////////////////////////////////////////////

  sinc_generator sinc_gen (
      .clk(adc_clk),
      .rst(exp_r_io),
      .start(start),
      .PRT_count_wire(prt),
      .T_count_wire(period),
      .sinc(sincronismo)
  );

  //////////////////////////////////////////////////////////////////////////////////
  //     GENERACION DEL CODIGO A TRANSMITIR
  //////////////////////////////////////////////////////////////////////////////////
  code_top codetop1 (
      .i_clk(adc_clk),
      .i_rst(exp_r_io),
      .i_sinc(sincronismo),
      .i_codigo(codigo),
      .i_numdig(num_dig),
      .i_tb(t_b),
      .o_signal(mixed_data_input)
  );
  //////////////////////////////////////////////////////////////////////////////////
  //     OSCILADOR
  //////////////////////////////////////////////////////////////////////////////////
  oscilador dds (
      .aclk(adc_clk),
      .s_axis_phase_tvalid(sincronismo),
      .s_axis_phase_tdata(phase),
      .m_axis_data_tvalid(dds_data_tvalid),
      .m_axis_data_tdata(dds_data_tdata)
  );

  //////////////////////////////////////////////////////////////////////////////////
  //     MIXED
  //////////////////////////////////////////////////////////////////////////////////

  mezclador mixed (
      .CLK(adc_clk),
      .A  (mixed_data_input),
      .B  (dds_data_tdata),
      .P  (signal_mod)
  );

  // Acondicionamiento de la señal para el dac
  always @(*) begin
    signal_acon = signal_mod[15:2];
  end
  assign signal_dac = {~signal_acon[13], signal_acon[14-2:0]};

  //////////////////////////////////////////////////////////////////////////////////
  //      SALIDAS
  //////////////////////////////////////////////////////////////////////////////////      

  // CLOCK ADC and SINCRONISMO
  ODDR i_adc_clk_p (
      .Q (exp_p_io),
      .D1(1'b1),
      .D2(1'b0),
      .C (adc_clk_in),
      .CE(1'b1),
      .R (1'b0),
      .S (1'b0)
  );
  ODDR i_adc_clk_n (
      .Q (exp_n_io),
      .D1(1'b0),
      .D2(1'b1),
      .C (adc_clk_in),
      .CE(1'b1),
      .R (1'b0),
      .S (1'b0)
  );
  ODDR oddr_sinc (
      .Q (exp_s_io),
      .D1(sincronismo),
      .D2(sincronismo),
      .C (adc_clk_in),
      .CE(1'b1),
      .R (1'b0),
      .S (1'b0)
  );

  // DAC OUTPUTS
  ODDR oddr_dac_clk (
      .Q (dac_clk_o),
      .D1(1'b0),
      .D2(1'b1),
      .C (dac_clk_2p),
      .CE(1'b1),
      .R (1'b0),
      .S (1'b0)
  );
  ODDR oddr_dac_wrt (
      .Q (dac_wrt_o),
      .D1(1'b0),
      .D2(1'b1),
      .C (dac_clk_2x),
      .CE(1'b1),
      .R (1'b0),
      .S (1'b0)
  );
  ODDR oddr_dac_sel (
      .Q (dac_sel_o),
      .D1(1'b1),
      .D2(1'b0),
      .C (dac_clk_1x),
      .CE(1'b1),
      .R (dac_rst),
      .S (1'b0)
  );
  ODDR oddr_dac_rst (
      .Q (dac_rst_o),
      .D1(dac_rst),
      .D2(dac_rst),
      .C (dac_clk_1x),
      .CE(1'b1),
      .R (1'b0),
      .S (1'b0)
  );
  ODDR oddr_dac_dat[14-1:0] (
      .Q (dac_dat_o),
      .D1(1'b0),
      .D2(signal_dac),
      .C (dac_clk_1x),
      .CE(1'b1),
      .R (dac_rst),
      .S (1'b0)
  );
  // D1-->CANAL2 , D2-->CANAL1

endmodule
