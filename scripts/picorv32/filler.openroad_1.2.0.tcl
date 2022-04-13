#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
set FILL_CELLS  "sky130_fd_sc_hs__fill_1 sky130_fd_sc_hs__fill_2 sky130_fd_sc_hs__fill_4 sky130_fd_sc_hs__fill_8 " 

if { $FOUNDRY == "sky130" } {
    if { $TRACK == "HS" } {
        set FILL_CELLS        "sky130_fd_sc_hs__fill_1 sky130_fd_sc_hs__fill_2 sky130_fd_sc_hs__fill_4 sky130_fd_sc_hs__fill_8 "
    } elseif { $TRACK == "HD" } {
        set FILL_CELLS        "sky130_fd_sc_hd__fill_1 sky130_fd_sc_hd__fill_2 sky130_fd_sc_hd__fill_4 sky130_fd_sc_hd__fill_8 "
    }   
} elseif { $FOUNDRY == "nangate45" } {
    set FILL_CELLS        "FILLCELL_X1 FILLCELL_X2 FILLCELL_X4 FILLCELL_X8 FILLCELL_X16 FILLCELL_X32 "
} elseif { $FOUNDRY == "asap7" } {
    set FILL_CELLS        "FILLERxp5_ASAP7_75t_R"
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

filler_placement $FILL_CELLS
check_placement

# write output
write_def       $RESULT_PATH/$DESIGN.def
write_verilog   $RESULT_PATH/$DESIGN.v
exit

