#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
if { $FOUNDRY == "sky130" } {
    set DISTANCE 14 
    if { $TRACK == "HS" } {
        set TAPCELL_MASTER "sky130_fd_sc_hs__tap_1" 
        set ENDCAP_MASTER  "sky130_fd_sc_hs__fill_1"
    } elseif { $TRACK == "HD" } {
        set TAPCELL_MASTER "sky130_fd_sc_hd__tap_1"
	set ENDCAP_MASTER  "sky130_fd_sc_hd__fill_1"
    }
} elseif { $FOUNDRY == "nangate45" } {
    set DISTANCE 120
    set TAPCELL_MASTER "TAPCELL_X1"
    set ENDCAP_MASTER  "TAPCELL_X1"
} elseif { $FOUNDRY == "asap7" } {
    set DISTANCE 25
    set TAPCELL_MASTER "TAPCELL_ASAP7_75t_R"
    set ENDCAP_MASTER  "TAPCELL_ASAP7_75t_R"
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

# Read def files
read_def $PRE_RESULT_PATH/$DESIGN.def

tapcell \
  -distance $DISTANCE \
  -tapcell_master $TAPCELL_MASTER \
  -endcap_master $ENDCAP_MASTER 

# write output
write_def       $RESULT_PATH/$DESIGN.def
write_verilog   $RESULT_PATH/$DESIGN.v
exit

