#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
set MAX_FANOUT      "30" 
if { $FOUNDRY == "sky130" } {
    set WIRE_RC_LAYER       "met3"
    if { $TRACK == "HS" } {
         set TIEHI_CELL_AND_PORT "sky130_fd_sc_hs__conb_1 HI" 
         set TIELO_CELL_AND_PORT "sky130_fd_sc_hs__conb_1 LO" 
         set FIX_DRC_BUF         "sky130_fd_sc_hs__buf_8"
    } elseif { $TRACK == "HD" } {
	 set TIEHI_CELL_AND_PORT "sky130_fd_sc_hd__conb_1 HI"
         set TIELO_CELL_AND_PORT "sky130_fd_sc_hd__conb_1 LO" 
         set FIX_DRC_BUF         "sky130_fd_sc_hd__buf_8"
    }
} elseif { $FOUNDRY == "nangate45" } {
    set WIRE_RC_LAYER       "metal3"
    set TIEHI_CELL_AND_PORT "LOGIC1_X1 Z"
    set TIELO_CELL_AND_PORT "LOGIC0_X1 Z" 
    set FIX_DRC_BUF         "BUF_X4"
} elseif { $FOUNDRY == "asap7" } {
    set WIRE_RC_LAYER       "M3"
    set TIEHI_CELL_AND_PORT "TIEHIx1_ASAP7_75t_R H"
    set TIELO_CELL_AND_PORT "TIELOx1_ASAP7_75t_R L" 
    set FIX_DRC_BUF         "BUFx4_ASAP7_75t_R"
}

#===========================================================
#   main running
#===========================================================
# Read lef
foreach lef $LEF_FILES {
    read_lef $lef
}

# Read liberty files
foreach libFile $LIB_FILES {
    read_liberty $libFile
}

# Read def file
read_def $PRE_RESULT_PATH/$DESIGN.def
# Read sdc file
read_sdc $SDC_FILE

# Set res and cap
set_wire_rc -layer $WIRE_RC_LAYER

# pre report
log_begin $RPT_PATH/pre_resize.rpt

puts "\n=========================================================================="
puts "report_checks"
puts "--------------------------------------------------------------------------"
report_checks

puts "\n=========================================================================="
puts "report_tns"
puts "--------------------------------------------------------------------------"
report_tns

puts "\n=========================================================================="
puts "report_wns"
puts "--------------------------------------------------------------------------"
report_wns

puts "\n=========================================================================="
puts "report_design_area"
puts "--------------------------------------------------------------------------"
report_design_area
#log_end

# Set the dont use list
#set dont_use_cells ""
#foreach cell $DONT_USE_CELLS {
#    lappend dont_use_cells [get_full_name [get_lib_cells */$cell]]
#}

# Set the buffer cell
set buffer_cell [get_lib_cell */$FIX_DRC_BUF]

# Do not buffer chip-level designs
#puts "Perform port buffering..."
#buffer_ports -buffer_cell $buffer_cell

# Perform resizing
puts "Perform resizing..."
#resize -resize -dont_use $dont_use_cells
#resize -resize -dont_use {*/*DEL* */*V0 */*V1}

# Repair max cap
#puts "Repair max cap..."
#repair_max_cap -buffer_cell $buffer_cell

# Repair max slew
#puts "Repair max slew..."
#repair_max_slew -buffer_cell $buffer_cell

################################################################
# Repair max slew/cap/fanout violations and normalize slews
puts "Repair max slew/cap/fanout violations and normalize slews..."
estimate_parasitics -placement

repair_design

# Repair tie lo fanout
puts "Repair tie lo fanout..."
puts "******************************************"
set tielo_cell_name [lindex $TIELO_CELL_AND_PORT 0]
puts "******************************************"
set tielo_lib_name [get_name [get_property [get_lib_cell */$tielo_cell_name] library]]
set tielo_pin $tielo_lib_name/$tielo_cell_name/[lindex $TIELO_CELL_AND_PORT 1]
repair_tie_fanout -max_fanout 1 $tielo_pin

# Repair tie hi fanout
puts "Repair tie hi fanout..."
set tiehi_cell_name [lindex $TIEHI_CELL_AND_PORT 0]
set tiehi_lib_name [get_name [get_property [get_lib_cell */$tiehi_cell_name] library]]
set tiehi_pin $tiehi_lib_name/$tiehi_cell_name/[lindex $TIEHI_CELL_AND_PORT 1]
repair_tie_fanout -max_fanout 1 $tiehi_pin

# Repair max fanout
#puts "Repair max fanout..."
#repair_max_fanout -max_fanout $MAX_FANOUT -buffer_cell $buffer_cell

# Repair hold
#puts "Repair hold"
#repair_hold_violations -buffer_cell $buffer_cell

# post report
log_begin $RPT_PATH/post_resize.rpt

puts "\n=========================================================================="
puts "report_floating_nets"
puts "--------------------------------------------------------------------------"
report_floating_nets

puts "\n=========================================================================="
puts "report_checks"
puts "--------------------------------------------------------------------------"
report_checks

puts "\n=========================================================================="
puts "report_tns"
puts "--------------------------------------------------------------------------"
report_tns

puts "\n=========================================================================="
puts "report_wns"
puts "--------------------------------------------------------------------------"
report_wns

puts "\n=========================================================================="
puts "report_design_area"
puts "--------------------------------------------------------------------------"
report_design_area

log_end

# write output
write_def       $RESULT_PATH/$DESIGN.def
write_verilog   $RESULT_PATH/$DESIGN.v
exit

