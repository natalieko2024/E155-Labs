-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/addroundkey.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/aes_core_tb.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/aes_starter.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/input_to_state.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/keyexpansion.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/shiftrows.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/state_to_output.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/subbytes.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/input_to_state_tb.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/mixcolumns_tb.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/output_to_state_tb.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src2/shiftrows_tb.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top testbench_aes_core
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run -all"
