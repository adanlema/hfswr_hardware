TARGET = dsn
SOURCES = code_top_tb.v code_top.v code_signal.v code_generator.v sinc_generator.v
VCD_FILE = code_top_tb.vcd
# Comandos
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

all: run

# Compilar con iverilog
$(TARGET): $(SOURCES)
	$(IVERILOG) -o $(TARGET) $(SOURCES)

# Ejecutar la simulación con vvp
run: $(TARGET)
	$(VVP) $(TARGET)

# Abrir gtkwave
wave: $(VCD_FILE)
	$(GTKWAVE) $(VCD_FILE)

# Limpiar archivos generados
clean:
	rm -f $(TARGET) $(VCD_FILE)

# Phony targets
.PHONY: all run wave clean