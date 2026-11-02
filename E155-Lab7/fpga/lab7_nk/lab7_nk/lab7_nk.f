-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/addroundkey.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/aes_core_tb.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/aes_starter.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/controlenables.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/counter.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/flopEN.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/input_to_state.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/keyexpansion.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/shiftrows.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/state_to_output.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/subbytes.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab7/fpga/src/subwords.sv" 
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
