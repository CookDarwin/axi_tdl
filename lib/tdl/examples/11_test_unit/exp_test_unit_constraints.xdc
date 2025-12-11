##-------------------------- CLOCK SET ---------------------------------- ##
set_system_jitter 0.1 
##========================== CLOCK SET ================================== ##
##-------------------------- PIN SET ---------------------------------- ##
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
