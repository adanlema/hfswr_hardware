# @Carcamo - Lema


############################################################################
# IO constraints                                                           #
############################################################################
### CLK ADC Input
set_property IOSTANDARD DIFF_HSTL_I_18  [get_ports adc_clk_i[*]]
set_property PACKAGE_PIN U18            [get_ports adc_clk_i[1]]
set_property PACKAGE_PIN U19            [get_ports adc_clk_i[0]]

### SALIDA CLK
set_property IOSTANDARD LVCMOS33 [get_ports exp_*_io]

set_property PACKAGE_PIN K17            [get_ports exp_p_io]
set_property PACKAGE_PIN K18            [get_ports exp_n_io]
set_property PACKAGE_PIN M14            [get_ports exp_r_io]
set_property PACKAGE_PIN G17            [get_ports exp_s_io]
set_property PULLUP         TRUE        [get_ports exp_r_io]

### DAC

# data
set_property IOSTANDARD LVCMOS33 [get_ports {dac_dat_o[*]}]
set_property SLEW       SLOW     [get_ports {dac_dat_o[*]}]
set_property DRIVE      8        [get_ports {dac_dat_o[*]}]
#set_property IOB        TRUE     [get_ports {dac_dat_o[*]}]

set_property PACKAGE_PIN M19 [get_ports {dac_dat_o[0]}]
set_property PACKAGE_PIN M20 [get_ports {dac_dat_o[1]}]
set_property PACKAGE_PIN L19 [get_ports {dac_dat_o[2]}]
set_property PACKAGE_PIN L20 [get_ports {dac_dat_o[3]}]
set_property PACKAGE_PIN K19 [get_ports {dac_dat_o[4]}]
set_property PACKAGE_PIN J19 [get_ports {dac_dat_o[5]}]
set_property PACKAGE_PIN J20 [get_ports {dac_dat_o[6]}]
set_property PACKAGE_PIN H20 [get_ports {dac_dat_o[7]}]
set_property PACKAGE_PIN G19 [get_ports {dac_dat_o[8]}]
set_property PACKAGE_PIN G20 [get_ports {dac_dat_o[9]}]
set_property PACKAGE_PIN F19 [get_ports {dac_dat_o[10]}]
set_property PACKAGE_PIN F20 [get_ports {dac_dat_o[11]}]
set_property PACKAGE_PIN D20 [get_ports {dac_dat_o[12]}]
set_property PACKAGE_PIN D19 [get_ports {dac_dat_o[13]}]

# control
set_property IOSTANDARD LVCMOS33 [get_ports dac_*_o]
set_property SLEW       FAST     [get_ports dac_*_o]
set_property DRIVE      8        [get_ports dac_*_o]
#set_property IOB        TRUE     [get_ports dac_*_o]

set_property PACKAGE_PIN M17 [get_ports dac_wrt_o]
set_property PACKAGE_PIN N16 [get_ports dac_sel_o]
set_property PACKAGE_PIN M18 [get_ports dac_clk_o]
set_property PACKAGE_PIN N15 [get_ports dac_rst_o]

