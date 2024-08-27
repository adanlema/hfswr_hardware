module code_signal (
    input code,
    input clk,
    input rst,
    input sinc,
    output [15:0] code_out
);


  reg [15:0] out_data = 0;

  always @(posedge clk) begin
    if (!rst) begin
      out_data = 0;
    end else begin
      if (sinc) begin
        if (code) begin
          out_data = 16'b0111111111111111;
        end else begin
          out_data = 16'b1000000000000000;
        end
      end else begin
        out_data = 0;
      end
    end
  end

  assign code_out = out_data;
endmodule
