TARGET = dsn
SOURCES = sinc_generator_tb.v sinc_generator.v
VCD_FILE = sinc_generator_tb.vcd
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