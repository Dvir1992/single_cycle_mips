onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_rf/reset
add wave -noupdate /tb_rf/clk
add wave -noupdate -radix unsigned /tb_rf/read_reg1
add wave -noupdate -radix unsigned /tb_rf/read_data1
add wave -noupdate -radix unsigned /tb_rf/reg_write
add wave -noupdate -radix unsigned /tb_rf/write_reg
add wave -noupdate -radix unsigned /tb_rf/write_data
add wave -noupdate /tb_rf/regs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {281 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {631 ps}
