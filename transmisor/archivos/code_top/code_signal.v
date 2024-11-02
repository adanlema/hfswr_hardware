module code_signal #(
    parameter NB_OUTPUT = 16
) (
    input                      code,
    input                      clk,
    input                      rst,
    input                      sinc,
    output [NB_OUTPUT - 1 : 0] code_out
);

  //////////////////////////////////////////////////////////////////////////////////
  //      WIRE AND REGISTERS
  //////////////////////////////////////////////////////////////////////////////////

  reg [NB_OUTPUT - 1 : 0] out_data = 0;

  //////////////////////////////////////////////////////////////////////////////////
  //      LOGIC
  //////////////////////////////////////////////////////////////////////////////////

  always @(posedge clk) begin
    if (!rst) begin
      out_data = 0;
    end else begin
      if (sinc) begin
        if (code) begin
          out_data = {1'b0, {(NB_OUTPUT - 1) {1'b1}}};
        end else begin
          out_data = {1'b1, {(NB_OUTPUT - 1) {1'b0}}};
        end
      end else begin
        out_data = 0;
      end
    end
  end

  //////////////////////////////////////////////////////////////////////////////////
  //      OUTPUT
  //////////////////////////////////////////////////////////////////////////////////

  assign code_out = out_data;

endmodule
