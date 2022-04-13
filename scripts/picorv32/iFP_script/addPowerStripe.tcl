source ../../scripts/$DESIGN/iFP_script/user_pg.tcl 

stdcell_rail_grid -layer_name "met1" -net_name_power VDD -net_name_ground VSS -width 0.48 
stdcell_stripe_grid -layer_name "met4" -net_name_power VDD -net_name_ground VSS -width 1.60 -pitch 27.14 -offset 13.570
stdcell_stripe_grid -layer_name "met5" -net_name_power VDD -net_name_ground VSS -width 1.60 -pitch 27.200 -offset 13.600

set connect1 "met1 met4"
set connect2 "met4 met5"
connect_two_layer -layers [concat $connect1 $connect2]

