#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
if { $FOUNDRY == "sky130" } {
    if { $TRACK == "HS" } {
        set ROOT_BUF        "sky130_fd_sc_hs__buf_1"
        set BUF_LIST        "sky130_fd_sc_hs__buf_1"
    } elseif { $TRACK == "HD" } {
        set ROOT_BUF        "sky130_fd_sc_hd__buf_1"
        set BUF_LIST        "sky130_fd_sc_hd__buf_1"
    }   
    set WIRE_RC_LAYER   "met3"
} elseif { $FOUNDRY == "nangate45" } {
    set ROOT_BUF        "CLKBUF_X2"
    set BUF_LIST        "CLKBUF_X2"
    set WIRE_RC_LAYER   "metal3"
} elseif { $FOUNDRY == "asap7" } {
    set ROOT_BUF        "BUFx4_ASAP7_75t_R"
    set BUF_LIST        "BUFx4_ASAP7_75t_R"
    set WIRE_RC_LAYER   "M3"
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

# Report timing before CTS
puts "\n=========================================================================="
puts "report_checks"
puts "--------------------------------------------------------------------------"
report_checks

# Run CTS
set_wire_rc -layer $WIRE_RC_LAYER
repair_clock_inverters
clock_tree_synthesis \
    -buf_list $BUF_LIST \
    -root_buf $ROOT_BUF \
    -sink_clustering_enable \
    -out_path $RESULT_PATH/
repair_clock_nets
set_placement_padding -global -left 3 -right 3
detailed_placement
check_placement

# write output
write_def       $RESULT_PATH/$DESIGN.def
write_verilog   $RESULT_PATH/$DESIGN.v
exit

