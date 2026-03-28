# Clock
set_property PACKAGE_PIN F14 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Buttons
set_property PACKAGE_PIN J2 [get_ports {btn[0]}]
set_property PACKAGE_PIN J5 [get_ports {btn[1]}]

# LEDs
set_property PACKAGE_PIN G1 [get_ports {led[0]}]
set_property PACKAGE_PIN G2 [get_ports {led[1]}]
set_property PACKAGE_PIN F1 [get_ports {led[2]}]
set_property PACKAGE_PIN F2 [get_ports {led[3]}]
set_property PACKAGE_PIN E1 [get_ports {led[4]}]
set_property PACKAGE_PIN E2 [get_ports {led[5]}]