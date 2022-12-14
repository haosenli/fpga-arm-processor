onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /adder_testbench/A
add wave -noupdate /adder_testbench/B
add wave -noupdate /adder_testbench/Cin
add wave -noupdate /adder_testbench/Cout_sel
add wave -noupdate /adder_testbench/sum_sel
add wave -noupdate /adder_testbench/sum
add wave -noupdate /adder_testbench/Cout
add wave -noupdate /adder_testbench/dut/and3
add wave -noupdate /adder_testbench/dut/and2
add wave -noupdate /adder_testbench/dut/and1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6930 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {67200 ps}
