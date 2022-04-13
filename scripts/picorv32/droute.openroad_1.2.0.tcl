#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
set PARAM_FILE "$WORK_PATH/droute.param"
set GEN_PARAM  "$PROJ_PATH/scripts/$DESIGN/generateParam.tcl"
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

# generate droute.param file
source $GEN_PARAM

detailed_route -param $PARAM_FILE

# write output
write_def       $RESULT_PATH/$DESIGN.def
write_verilog   $RESULT_PATH/$DESIGN.v
exit

