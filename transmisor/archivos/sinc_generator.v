module sinc_generator (
    input wire          clk,
    input wire          rst,
    input wire          start,
    input wire [31:0]   T_count_wire,
    input wire [31:0]   PRT_count_wire,
    output wire         sinc
);


reg [31:0]  PRT;
reg [31:0]  T;

reg salida = 0;
reg [31:0] counter = 0;

always @(posedge clk) begin
    PRT = PRT_count_wire;
    T = T_count_wire;
end

always @(posedge clk) begin
    if(start) begin
        if(!rst) begin
            salida = 0;
            counter = 0; 
        end else begin
            if(counter < T) begin
                salida = 1;
                counter = counter + 1;
            end else begin
                if(counter < PRT) begin
                    salida = 0;
                    counter = counter + 1;
                end else begin
                    counter = 0;
                end
            end
        end
     end else begin
        salida = 0;
        counter = 0; 
     end
end

assign sinc = salida;

endmodule
