############################################################################
# IO constraints                                                           #
############################################################################

### ADC

# ADC data CH1
set_property IOSTANDARD LVCMOS18 [get_ports {adc_dat_1[*]}]
set_property IOB        TRUE     [get_ports {adc_dat_1[*]}]

set_property PACKAGE_PIN V17     [get_ports {adc_dat_1[0]}]
set_property PACKAGE_PIN U17     [get_ports {adc_dat_1[1]}]
set_property PACKAGE_PIN Y17     [get_ports {adc_dat_1[2]}]
set_property PACKAGE_PIN W16     [get_ports {adc_dat_1[3]}]
set_property PACKAGE_PIN Y16     [get_ports {adc_dat_1[4]}]
set_property PACKAGE_PIN W15     [get_ports {adc_dat_1[5]}]
set_property PACKAGE_PIN W14     [get_ports {adc_dat_1[6]}]
set_property PACKAGE_PIN Y14     [get_ports {adc_dat_1[7]}]
set_property PACKAGE_PIN W13     [get_ports {adc_dat_1[8]}]
set_property PACKAGE_PIN V12     [get_ports {adc_dat_1[9]}]
set_property PACKAGE_PIN V13     [get_ports {adc_dat_1[10]}]
set_property PACKAGE_PIN T14     [get_ports {adc_dat_1[11]}]
set_property PACKAGE_PIN T15     [get_ports {adc_dat_1[12]}]
set_property PACKAGE_PIN V15     [get_ports {adc_dat_1[13]}]
set_property PACKAGE_PIN T16     [get_ports {adc_dat_1[14]}]
set_property PACKAGE_PIN V16     [get_ports {adc_dat_1[15]}]

# ADC data CH2
set_property IOSTANDARD LVCMOS18 [get_ports {adc_dat_2[*]}]
set_property IOB        TRUE     [get_ports {adc_dat_2[*]}]

set_property PACKAGE_PIN T17     [get_ports {adc_dat_2[0]}]
set_property PACKAGE_PIN R16     [get_ports {adc_dat_2[1]}]
set_property PACKAGE_PIN R18     [get_ports {adc_dat_2[2]}]
set_property PACKAGE_PIN P16     [get_ports {adc_dat_2[3]}]
set_property PACKAGE_PIN P18     [get_ports {adc_dat_2[4]}]
set_property PACKAGE_PIN N17     [get_ports {adc_dat_2[5]}]
set_property PACKAGE_PIN R19     [get_ports {adc_dat_2[6]}]
set_property PACKAGE_PIN T20     [get_ports {adc_dat_2[7]}]
set_property PACKAGE_PIN T19     [get_ports {adc_dat_2[8]}]
set_property PACKAGE_PIN U20     [get_ports {adc_dat_2[9]}]
set_property PACKAGE_PIN V20     [get_ports {adc_dat_2[10]}]
set_property PACKAGE_PIN W20     [get_ports {adc_dat_2[11]}]
set_property PACKAGE_PIN W19     [get_ports {adc_dat_2[12]}]
set_property PACKAGE_PIN Y19     [get_ports {adc_dat_2[13]}]
set_property PACKAGE_PIN W18     [get_ports {adc_dat_2[14]}]
set_property PACKAGE_PIN Y18     [get_ports {adc_dat_2[15]}]

# Input ADC Clock
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports adc_clk_i[*]]
set_property PACKAGE_PIN U18           [get_ports adc_clk_i[1]]
set_property PACKAGE_PIN U19           [get_ports adc_clk_i[0]]

# ADC Clock Stabilizer
set_property IOSTANDARD  LVCMOS18 [get_ports adc_cdcs_o]
set_property PACKAGE_PIN V18      [get_ports adc_cdcs_o]
set_property SLEW        FAST     [get_ports adc_cdcs_o]
set_property DRIVE       8        [get_ports adc_cdcs_o]


### RESET
set_property IOSTANDARD LVCMOS33 [get_ports exp_*_io]
set_property PULLUP     TRUE     [get_ports exp_*_io]

 # DIO7_p E1 pin 17
set_property PACKAGE_PIN M14     [get_ports exp_r_io]
# DIO0_p E1 pin 3
set_property PACKAGE_PIN G17     [get_ports exp_sinc_io]
