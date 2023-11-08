onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ctrl/reset
add wave -noupdate /tb_ctrl/regdst
add wave -noupdate /tb_ctrl/reg_write
add wave -noupdate /tb_ctrl/op
add wave -noupdate /tb_ctrl/memwrite
add wave -noupdate /tb_ctrl/memtoreg
add wave -noupdate /tb_ctrl/memread
add wave -noupdate /tb_ctrl/funct
add wave -noupdate /tb_ctrl/alusrc
add wave -noupdate /tb_ctrl/aluop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49 ps} 0}
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
WaveRestoreZoom {0 ps} {4 ps}
