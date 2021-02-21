##-------------------------- CLOCK SET ---------------------------------- ##
set_system_jitter 0.1 
create_clock -period 8.0 -name sys_clock -waveform {0.000 4.0} [get_ports sys_clock]
# set_input_jitter [get_clocks -of_objects [get_ports sys_clock]] 0.01
##========================== CLOCK SET ================================== ##
##-------------------------- PIN SET ---------------------------------- ##
set_property PACKAGE_PIN C7 [get_ports sys_clock]
set_property IOSTANDARD LVCMOS18 [get_ports sys_clock]
set_property PACKAGE_PIN A1 [get_ports odata[0]]
set_property IOSTANDARD LVCMOS18 [get_ports odata[0]]
set_property PACKAGE_PIN A3 [get_ports odata[1]]
set_property IOSTANDARD LVCMOS18 [get_ports odata[1]]
set_property PACKAGE_PIN B5 [get_ports odata[2]]
set_property IOSTANDARD LVCMOS25 [get_ports odata[2]]
set_property PACKAGE_PIN C6 [get_ports odata[3]]
set_property IOSTANDARD LVCMOS33 [get_ports odata[3]]
##========================== PIN SET ================================== ##

## -------------------------- FALSE PATH SET ---------------------------------- ##
# set_false_path -from [get_pins -hier -regexp .*cross_clk.*ltc.*] -to [all_registers]
set_max_delay -from [get_pins -hier -regexp .*cross_clk.*ltc.*] -to [all_registers] 20.00
## set_false_path -from [get_pins -hierarchical "*cross_clk*"] -to [all_registers]
# set_false_path -from [all_registers] -to [get_pins -hier -regexp .*cross_clk.*ltc.*]
set_max_delay -from [all_registers] -to [get_pins -hier -regexp .*cross_clk.*ltc.*] 20.00
## set_false_path -from [all_registers] -to [get_pins -hierarchical "*cross_clk*"]

# set_false_path -from [get_pins -hier -regexp .*xilinx_reset_sync.*reset_sync.*] -to [all_registers]
set_max_delay -from [get_pins -hier -regexp .*xilinx_reset_sync.*reset_sync.*] -to [all_registers] 40.000
## set_false_path -from [get_pins -hierarchical "*xilinx_reset_sync*reset_sync*"] -to [all_registers]

## ========================== FALSE PATH SET =================================== ##
## -------------------------- EX SET ---------------------------------- ##

## ========================== EX SET =================================== ##
## -------------------------- BITSTREAM SET ---------------------------------- ##

## ========================== BITSTREAM SET =================================== ##
