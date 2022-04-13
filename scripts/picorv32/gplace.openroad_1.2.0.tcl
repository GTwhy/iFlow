#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
if { $FOUNDRY == "sky130" } {
    set WIRE_RC_LAYER "met3"
} elseif { $FOUNDRY == "nangate45" } {
    set WIRE_RC_LAYER "metal3"
} elseif { $FOUNDRY == "asap7" } {
    set WIRE_RC_LAYER "M3"
}

set PLACE_DENSITY   "0.3"

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

set_wire_rc -layer $WIRE_RC_LAYER

global_placement -density $PLACE_DENSITY

#global_placement -incremental -overflow 0.1 -density $PLACE_DENSITY

# write output
write_def       $RESULT_PATH/$DESIGN.def
write_verilog   $RESULT_PATH/$DESIGN.v
exit

