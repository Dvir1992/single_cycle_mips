/*
//////////////////////////////////////////////////////////////////////
Module name:            register_file
Description:            The purpose of the register file is to store variable information in a memory element smaller than the data memory so that it can be read quickly.
//////////////////////////////////////////////////////////////////////
*/
module register_file(
  clk,
  reset,
  read_reg1,
  read_reg2,
  write_reg,
  write_data,
  reg_write,
  read_data1,
  read_data2
);
  input clk;
  input reset;
  input [4:0] read_reg1;
  input [4:0] read_reg2;
  input [4:0] write_reg;
  input [31:0] write_data;
  input reg_write;
  output reg [31:0] read_data1;
  output reg [31:0] read_data2;
  
  reg [31:0] regs [31:0];// register fil consists of 32 registers.
  integer i;
  

   always@(posedge clk) begin
	if (reset)begin
		for (i=0;i<32;i=i+1)
			regs[i]<=i;	
	end
	else if (reg_write)
		regs[write_reg]<=write_data;
		
   end
  

   always@* begin
	if(reset)begin
		read_data1<=0;
		read_data2<=0;
	end
	else begin
		#2;
		read_data1<=regs[read_reg1];
		read_data2<=regs[read_reg2];
	end
   end
 
	
 
endmodule


