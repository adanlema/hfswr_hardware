module code_generator (
    input wire clk,
    input wire rst,
    input wire sinc,         
    input wire [31:0] num_dig,
    input wire [31:0] codigo,
    input wire [31:0] tiempo_b,
    output wire out   
);


reg [31:0] numero = 0;
reg [31:0] codigo_tx = 0;
reg [31:0] ancho_bit = 0;

reg out_data = 0;
reg [7:0] bit_counter = 0;
reg [31:0] counter = 0;  

always @(*) begin
    numero = num_dig;
    codigo_tx = codigo;
    ancho_bit = tiempo_b;
end

always @(posedge clk) begin
    if(!rst) begin
        counter = 0;
        bit_counter = 0;
        out_data = 0;
    end else begin
        if(sinc) begin
            if (bit_counter < (numero - 1)) begin
                out_data = codigo[bit_counter]; 
                if (counter == (ancho_bit - 1'd1)) begin
                    counter = 0;
                    bit_counter = bit_counter + 1; // Incremento el contador del bit.
                end else begin
                    counter = counter + 1;
                end
            end else
                out_data = 0;
        end else begin
            counter = 0;
            bit_counter = 0;
            out_data = 0; 
        end
    end
end

assign out = out_data;

endmodule