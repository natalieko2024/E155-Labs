-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/nko/my_designs/RadiantLatticeGitHub/e155_lab1_nk/source/impl_1/lab1_nk.sv" 
"C:/Users/nko/my_designs/RadiantLatticeGitHub/e155_lab1_nk/source/impl_1/oscillator.sv" 
"C:/Users/nko/my_designs/RadiantLatticeGitHub/e155_lab1_nk/source/impl_1/switch_7seg.sv" 
"C:/Users/nko/my_designs/RadiantLatticeGitHub/e155_lab1_nk/source/impl_1/lab1_nk_switch7seg_tb.sv" 
"C:/Users/nko/my_designs/RadiantLatticeGitHub/e155_lab1_nk/source/impl_1/lab1_nk_oscillator_tb.sv" 
"C:/Users/nko/my_designs/RadiantLatticeGitHub/e155_lab1_nk/source/impl_1/lab1_nk_top_tb.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top lab1_nk_oscillator_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run -all"
