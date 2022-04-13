#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================

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

# Read verilog
read_verilog $PRE_RESULT_PATH/$DESIGN.v

link_design $DESIGN

# write output
write_def       $RESULT_PATH/$DESIGN.def
exit

