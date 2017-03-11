
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name auto_seller -dir "F:/COLAB/EELABS/mylab/auto_seller/planAhead_run_4" -part xc3s100ecp132-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "F:/COLAB/EELABS/mylab/auto_seller/top_module.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {F:/COLAB/EELABS/mylab/auto_seller} }
set_property target_constrs_file "top_module.ucf" [current_fileset -constrset]
add_files [list {top_module.ucf}] -fileset [get_property constrset [current_run]]
link_design
