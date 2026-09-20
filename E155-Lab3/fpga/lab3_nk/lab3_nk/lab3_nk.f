-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab2/fpga/src/scan.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab1/fpga/e155_lab1_nk/source/impl_1/freqconverter.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab1/fpga/e155_lab1_nk/source/impl_1/switch_7seg.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab3/fpga/src2/enableFlipFlop.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab3/fpga/src2/keyMapper.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab3/fpga/src2/keypadFSM.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab3/fpga/src2/keySwitchConverter.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab3/fpga/src2/lab3_nk.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab3/fpga/src2/synchronizer.sv" 
"C:/Users/nko/Documents/GitHub/E155-LabsNew/E155-Lab3/fpga/src2/findHighBit.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top lab3_nk
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run 100 ns"
