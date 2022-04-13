 
 #===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
if { $FOUNDRY == "sky130" } {
#    set MAX_ROUTING_LAYER   "6" 
    set WIRE_RC_LAYER       "met3" 
    set LAYER_M2            met2
    set LAYER_M3            met3
    set LAYER_M4            met4
    set LAYER_M5            met5
    set LAYER_M6            met6
    set LAYER_M7            met7
    set SIGNAL_LAYER        "met2-met5"
    set CLOCK_LAYER         "met2-met3"
} elseif { $FOUNDRY == "nangate45" } {
#    set MAX_ROUTING_LAYER   "6" 
    set WIRE_RC_LAYER       "metal3" 
    set LAYER_M2            metal2
    set LAYER_M3            metal3
    set LAYER_M4            metal4
    set LAYER_M5            metal5
    set LAYER_M6            metal6
    set LAYER_M7            metal7
    set LAYER_M8            metal8
    set LAYER_M9            metal9
    set LAYER_M10           metal10
    set SIGNAL_LAYER        "metal2-metal8"
    set CLOCK_LAYER         "metal2-metal5"
} elseif { $FOUNDRY == "asap7" } {
    set MAX_ROUTING_LAYER   "6" 
    set WIRE_RC_LAYER       "M3" 
    set LAYER_M2            M2
    set LAYER_M3            M3
    set LAYER_M4            M4
    set LAYER_M5            M5
    set LAYER_M6            M6
    set LAYER_M7            M7
    set LAYER_M8            M8
    set LAYER_M9            M9
    set SIGNAL_LAYER        "M2-M8"
    set CLOCK_LAYER         "M2-M5"
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
# Read SDC file
read_sdc $SDC_FILE

set db      [::ord::get_db]
set block   [[$db getChip] getBlock]
set tech    [$db getTech]

set layer_M2 [$tech findLayer $LAYER_M2]
set layer_M3 [$tech findLayer $LAYER_M3]
set layer_M4 [$tech findLayer $LAYER_M4]
set layer_M5 [$tech findLayer $LAYER_M5]
set layer_M6 [$tech findLayer $LAYER_M6]
set layer_M7 [$tech findLayer $LAYER_M7]

if { $FOUNDRY == "nangate45" } {
set layer_M8 [$tech findLayer $LAYER_M8]
set layer_M9 [$tech findLayer $LAYER_M9]
set layer_M10 [$tech findLayer $LAYER_M10]
} elseif { $FOUNDRY == "aspa7" } {
set layer_M8 [$tech findLayer $LAYER_M8]
set layer_M9 [$tech findLayer $LAYER_M9]
}

set distance 500

set allInsts [$block getInsts]

set cnt 0

# MEM
foreach inst $allInsts {
    set master [$inst getMaster]
    set name [$master getName]
    set loc_llx [lindex [$inst getLocation] 0]
    set loc_lly [lindex [$inst getLocation] 1]

    #[string match "S013PLL*" $name]||
    if {[string match "sky130_sram_1rw1r*" $name]} {
        puts "create route block around $name"
        set w [$master getWidth]
        set h [$master getHeight]
        puts "$name loc : $loc_llx $loc_lly"

        set llx_Mx [expr $loc_llx - $distance] 
        set lly_Mx [expr $loc_lly - $distance] 
        set urx_Mx [expr $loc_llx + $w + $distance] 
        set ury_Mx [expr $loc_lly + $h + $distance] 

        #set obs_M2 [odb::dbObstruction_create $block $layer_M2 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
        #set obs_M3 [odb::dbObstruction_create $block $layer_M3 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
        #set obs_M4 [odb::dbObstruction_create $block $layer_M4 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
        #set obs_M5 [odb::dbObstruction_create $block $layer_M5 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
        #set obs_M6 [odb::dbObstruction_create $block $layer_M6 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
        #set obs_M7 [odb::dbObstruction_create $block $layer_M7 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]

        incr cnt
    }
}

if {$cnt != 0} {
    puts "\[INFO\] created $cnt routing blockages over macros"
}

set_wire_rc -layer $WIRE_RC_LAYER

global_route -guide_file $RESULT_PATH/route.guide \
	     -overflow_iterations 200 \
	     -verbose 2 \

set_routing_layers -signal $SIGNAL_LAYER \
                   -clock  $CLOCK_LAYER 

set_global_routing_layer_adjustment $LAYER_M4 0.5
set_global_routing_layer_adjustment $LAYER_M5 0.5

# write output
write_def       $RESULT_PATH/$DESIGN.def
write_verilog   $RESULT_PATH/$DESIGN.v
exit

