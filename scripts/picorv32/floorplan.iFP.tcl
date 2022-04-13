#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
# init
set DIE_AREA "0.0 0.0 1120 1020.8"
set CORE_AREA "10 12 1110 1011.2"
set PLACE_SITE unit
set IO_SITE  ""

#===========================================================
#   main running
#===========================================================
# read lef
foreach lef $LEF_FILES {
    read_lef $lef
}

#read design ".v .def"
#read_def $PRE_RESULT_PATH/$DESIGN.def
read_v $PRE_RESULT_PATH/$DESIGN.v


init_floorplan \
   -die_area $DIE_AREA \
   -core_area $CORE_AREA \
   -core_site $PLACE_SITE \
   -io_site $IO_SITE

# output
write_def $RESULT_PATH/$DESIGN.def

exit
