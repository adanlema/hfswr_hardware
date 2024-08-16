`timescale 1ns / 1ps

module data_recovered(
    //LI
    input [1:0]     adc_clk_i,
    input           exp_r_io,
    input [15:0]    adc_dat_1,
    input [15:0]    adc_dat_2,
    input [31:0]    carrier_phase,
    input           on_off,
    output          adc_cdcs_o,
    //LD
    output          clk,
    output          valid,
    output [31:0]   datos
);

//////////////////////////////////////////////////////////////////////////////////
//      WIRE AND REGISTERS
//////////////////////////////////////////////////////////////////////////////////
// ADC
wire adc_clk_in;
reg [16-1:0] adc_dat_raw_ch1;
reg [16-1:0] adc_dat_raw_ch2;
reg [16-1:0] adc_dat_ch1;
reg [16-1:0] adc_dat_ch2;
// DDS
wire dds_data_tvalid;
wire [31:0] dds_data_tdata;
wire [15:0] sine_data;
wire [15:0] cosine_data; 

// MIXED
wire [15:0] real_data;
wire [15:0] img_data;


//CIC I
wire cic_i_data_tready;
wire cic_i_data_tvalid;
wire [23:0] cic_i_data_tdata;
//FIR I
wire fir_i_data_tready;
wire fir_i_data_tvalid;
wire [39:0] fir_i_data_tdata;
wire [16:0] fir_i_data_output;

//CIC Q
wire cic_q_data_tready;
wire cic_q_data_tvalid;
wire [23:0] cic_q_data_tdata;
//FIR Q
wire fir_q_data_tready;
wire fir_q_data_tvalid;
wire [39:0] fir_q_data_tdata;
wire [16:0] fir_q_data_output;


//////////////////////////////////////////////////////////////////////////////////
//      ADC DATOS DE OFFSET BINARY A TWO COMPLEMENT
//////////////////////////////////////////////////////////////////////////////////

IBUFDS i_clk (.I (adc_clk_i[1]), .IB (adc_clk_i[0]), .O (adc_clk_in));  // differential clock input
assign adc_cdcs_o = 1'b1 ;            // IMPORTANTE PARA EL ESTABILIZADOR.

always @(posedge adc_clk_in) begin
    adc_dat_raw_ch1 = adc_dat_1;
    adc_dat_raw_ch2 = adc_dat_2;
end
// Transformamos a 2's Complement
always @(posedge adc_clk_in) begin
  adc_dat_ch1 =  {~adc_dat_raw_ch1[15], adc_dat_raw_ch1[14:0]};
  adc_dat_ch2 =  {~adc_dat_raw_ch2[15], adc_dat_raw_ch2[14:0]};
end


//////////////////////////////////////////////////////////////////////////////////
//      DDS COMPILER (OSCILADOR)
//////////////////////////////////////////////////////////////////////////////////

dds_compiler_0 dds (
      .aclk(adc_clk_in),                                // input wire aclk
      .s_axis_phase_tvalid(1'b1),                       // input wire s_axis_phase_tvalid 
      .s_axis_phase_tdata(carrier_phase),                // input wire [31 : 0] s_axis_phase_tdata
      .m_axis_data_tvalid(dds_data_tvalid),             // output wire m_axis_data_tvalid
      .m_axis_data_tdata(dds_data_tdata)                // output wire [31 : 0] m_axis_data_tdata
    );
    
assign sine_data = dds_data_tdata[31:16];
assign cosine_data = dds_data_tdata[15:0];


//////////////////////////////////////////////////////////////////////////////////
//      MIXED
//////////////////////////////////////////////////////////////////////////////////
mixed mix (
    .clk(adc_clk_in),
    .rst(exp_r_io),
    .signal(adc_dat_ch1),
    .cosine(cosine_data),
    .sine(sine_data),
    .signal_real(real_data),
    .signal_img(img_data)
    );

//////////////////////////////////////////////////////////////////////////////////
//      ETAPA DE FILTRADO
//////////////////////////////////////////////////////////////////////////////////

// SIGNAL I (cosine)
filter_cic cic_i(
    .aclk(adc_clk_in),
    .s_axis_data_tdata(adc_dat_ch1),
    //.s_axis_data_tdata(real_data),
    .s_axis_data_tvalid(dds_data_tvalid),
    .s_axis_data_tready(cic_i_data_tready),
    .m_axis_data_tdata(cic_i_data_tdata),
    .m_axis_data_tvalid(cic_i_data_tvalid)
);

filter_fir fir_i(             // FS = 120kHz y FC = 10kHz
    .aclk(adc_clk_in),
    .s_axis_data_tvalid(cic_i_data_tvalid),
    .s_axis_data_tready(fir_i_data_tready),
    .s_axis_data_tdata(cic_i_data_tdata),
    .m_axis_data_tvalid(fir_i_data_tvalid),
    .m_axis_data_tdata(fir_i_data_tdata)
);
assign fir_i_data_output = fir_i_data_tdata[39:24];


// SIGNAL Q (sine)
filter_cic cic_q(
    .aclk(adc_clk_in),
    .s_axis_data_tdata(adc_dat_ch1),
    //.s_axis_data_tdata(img_data),
    .s_axis_data_tvalid(dds_data_tvalid),
    .s_axis_data_tready(cic_q_data_tready),
    .m_axis_data_tdata(cic_q_data_tdata),
    .m_axis_data_tvalid(cic_q_data_tvalid)
);

filter_fir fir_q(             // FS = 120kHz y FC = 10kHz
    .aclk(adc_clk_in),
    .s_axis_data_tvalid(cic_q_data_tvalid),
    .s_axis_data_tready(fir_q_data_tready),
    .s_axis_data_tdata(cic_q_data_tdata),
    .m_axis_data_tvalid(fir_q_data_tvalid),
    .m_axis_data_tdata(fir_q_data_tdata)
);
assign fir_q_data_output = fir_q_data_tdata[39:24];


//////////////////////////////////////////////////////////////////////////////////
//      SALIDA
//////////////////////////////////////////////////////////////////////////////////

//assign datos = {adc_dat_ch1,adc_dat_ch1};
assign datos    = {fir_i_data_output,fir_q_data_output};
assign valid    = (on_off)? fir_q_data_tvalid : 1'b0;
assign clk      = adc_clk_in;
 
endmodule
