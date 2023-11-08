/*
//////////////////////////////////////////////////////////////////////
Module name:            instruction_memory
Description:            the memory that stores all the prefetch instructions of the mips.
//////////////////////////////////////////////////////////////////////
*/
module instruction_memory(
  reset,
  read_adr,
  inst_out
);

  input reset;
  input [31:0] read_adr;//address is 32 bits
  output reg [31:0] inst_out;//word is 32 bits
  
  reg [31:0] inst_mem [8:0];// the instruction memory consists of 9 words.
  
 initial begin //6b op|5b s|5b t|5b d|sham|funct| // these are the fields of the instruction word.
 inst_mem[0]=32'b00000001010010010100000000100001;//add
 inst_mem[1]=32'b00000001010010010100000000100010;//sub
 inst_mem[2]=32'b00000001010010010100000000100100;//and
 inst_mem[3]=32'b00000001010010010100000000100101;//or
 inst_mem[4]=32'b00000001010010010100000000101010;//slt
 inst_mem[5]=32'b10001100000000110000000000000100;//lw
 inst_mem[6]=32'b10101100000000110000000000001000;//sw
 inst_mem[7]=32'b00010000101001000000000000000010;//beq not with offset=2.
 inst_mem[8]=32'b00010000100001000000000000000010;//beq with offset=2-> should perform inst_mem[2] instruction.

 end
 
 always@ * begin
	if (reset)
		inst_out<=0;
	else
		#3 inst_out<=inst_mem[(read_adr/4)%9];
 end 
endmodule


