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
# read data
foreach lef $LEF_FILES {
    read_lef $lef
}

#read_def "./SYN.def"
read_def $PRE_RESULT_PATH/$DESIGN.def


tapcell \
   -tapcell sky130_fd_sc_hs__tap_1 \
   -distance 14 \
   -endcap sky130_fd_sc_hs__fill_1

# output
write_def $RESULT_PATH/$DESIGN.def

exit

