module code_generator #(
    parameter NB_REG = 32
) (
    input  wire                  clk,
    input  wire                  rst,
    input  wire                  sinc,
    input  wire [NB_REG - 1 : 0] num_dig,
    input  wire [NB_REG - 1 : 0] codigo,
    input  wire [NB_REG - 1 : 0] tiempo_b,
    output wire                  out
);

  localparam NB_SIZE = 8;
  localparam NB_COUNTER = 32;

  //////////////////////////////////////////////////////////////////////////////////
  //      WIRE AND REGISTERS
  //////////////////////////////////////////////////////////////////////////////////

  reg                      out_data = 0;
  reg [    NB_REG - 1 : 0] numero = 0;
  reg [    NB_REG - 1 : 0] codigo_tx = 0;
  reg [    NB_REG - 1 : 0] ancho_bit = 0;
  reg [   NB_SIZE - 1 : 0] bit_counter = 0;
  reg [NB_COUNTER - 1 : 0] counter = 0;


  always @(*) begin
    numero = num_dig;
    codigo_tx = codigo;
    ancho_bit = tiempo_b;
  end


  //////////////////////////////////////////////////////////////////////////////////
  //      LOGIC
  //////////////////////////////////////////////////////////////////////////////////

  always @(posedge clk) begin
    if (!rst) begin
      counter = 0;
      bit_counter = 0;
      out_data = 0;
    end else begin
      if (sinc) begin
        if (bit_counter < (numero - 0)) begin  // evaluar si va 0 o 1
          out_data = codigo[bit_counter];
          if (counter == (ancho_bit - 1'd1)) begin
            counter = 0;
            bit_counter = bit_counter + 1;  // Incremento el contador del bit.
          end else begin
            counter = counter + 1;
          end
        end else out_data = 0;
      end else begin
        counter = 0;
        bit_counter = 0;
        out_data = 0;
      end
    end
  end

  //////////////////////////////////////////////////////////////////////////////////
  //      OUTPUT
  //////////////////////////////////////////////////////////////////////////////////

  assign out = out_data;

endmodule
