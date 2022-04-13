#!/usr/bin/tclsh
#source ../../scripts/common/set_env.tcl

set PARAM [open ./droute.param w ]
puts $PARAM "guide:${PRE_RESULT_PATH}/route.guide"
puts $PARAM "outputguide:${RESULT_PATH}/output_guide.mod"
puts $PARAM "outputDRC:${RESULT_PATH}/droute_drc.rpt"
puts $PARAM "outputMaze:${RESULT_PATH}/maze.log"
puts $PARAM "threads:8"
puts $PARAM "verbose:1"
close $PARAM
