global_net_connect -net_name VDD   -instance_pin_name VDD   -is_power 1
global_net_connect -net_name VDDIO -instance_pin_name VDD33 -is_power 1
global_net_connect -net_name VSS   -instance_pin_name VSS   -is_power 0
global_net_connect -net_name VSS   -instance_pin_name VSSD  -is_power 0
global_net_connect -net_name FP    -instance_pin_name FP    -is_power 1


add_powernet_io -net_name VDD   -direction INOUT 
add_powernet_io -net_name VSS   -direction INOUT 
add_powernet_io -net_name VDDIO -direction INOUT 
