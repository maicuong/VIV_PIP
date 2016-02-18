# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.cache/wt [current_project]
set_property parent.project_path C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_vhdl -library xil_defaultlib {
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/pos_et_d_ff.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/ha.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/reg_pos_et_d_ff.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/Byte.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/ctl_sig.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/rw_counter.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/op_decoder.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/rw_counter_16.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/reg_16.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/controller.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/sp_reg.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/VM.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/MEMORY.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/MEMORY_8.vhd
  C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/sources_1/imports/PIPELINE/PIPELINE.vhd
}
read_xdc C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/constrs_1/new/PIPELINE.xdc
set_property used_in_implementation false [get_files C:/FPGAPrj/VIVADO/PIPELINE/PIPELINE.srcs/constrs_1/new/PIPELINE.xdc]

synth_design -top PIPELINE -part xc7z010clg400-1
write_checkpoint -noxdef PIPELINE.dcp
catch { report_utilization -file PIPELINE_utilization_synth.rpt -pb PIPELINE_utilization_synth.pb }
