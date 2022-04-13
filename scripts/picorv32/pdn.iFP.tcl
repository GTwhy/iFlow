#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

# read data
foreach lef $LEF_FILES {
    read_lef $lef
}

#read_def "./SYN.def"
read_def $PRE_RESULT_PATH/$DESIGN.def

# sky130
source ../../scripts/$DESIGN/iFP_script/addPowerStripe.tcl

# output
write_def $RESULT_PATH/$DESIGN.def

exit
