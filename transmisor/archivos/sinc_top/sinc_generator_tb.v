`timescale 1ns / 1ps

module sinc_generator_tb;
    parameter MS = 1000000;
    parameter SIM_TIME = 23 * MS;
    // BARKER 11 - [1],[1],[1],[0],[0],[0],[1],[0],[0],[1],[0]

    reg         clk;
    reg         rst;
    reg         start;
    reg  [31:0] prt;
    reg  [31:0] period;
    wire         sinc;

    // Instancia del módulo bajo prueba
    sinc_generator sinc_gen(
    .clk(clk),
    .rst(rst),
    .start(start),
     .PRT_count_wire(prt),      
    .T_count_wire(period),          
    .sinc(sinc)  
    );

    // Generador de reloj
    always #4.069 clk = ~clk;

    // Inicialización de señales
    initial begin
        // Con esto puedo abrir el GTKWave
        $dumpfile("sinc_generator_tb.vcd");
        $dumpvars(0,sinc_generator_tb);

        clk     = 0;
        rst     = 0;
        prt     = 32'd2457600;      // PRF = 50Hz
        period  = 32'd270336;       // AB = 5 kHz
        start   = 1;
        #10 rst = 1;
        #SIM_TIME;
        $finish;
    end

endmodule