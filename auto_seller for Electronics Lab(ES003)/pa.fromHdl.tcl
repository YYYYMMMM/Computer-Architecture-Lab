
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name auto_seller -dir "F:/COLAB/EELABS/mylab/auto_seller/planAhead_run_2" -part xc3s100ecp132-5
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "top_module.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {top_module.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top top_module $srcset
add_files [list {top_module.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s100ecp132-5
