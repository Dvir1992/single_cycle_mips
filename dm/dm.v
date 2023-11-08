/*
//////////////////////////////////////////////////////////////////////
Module name:            data_memory
Description:            serves for storing and keeping data required for the proper operation of the mips. more big and slow than the register file.
//////////////////////////////////////////////////////////////////////
*/
module data_memory(
  clk,
  reset,
  read_adr,
  write_adr,
  write_data,
  memwrite,
  memread,
  read_data
);
  input clk;
  input reset;
  input [31:0] read_adr;
  input [31:0] write_adr;
  input [31:0] write_data;
  input memwrite;
  input memread;
  output reg [31:0] read_data;
  wire [7:0] actual_read_adr;
  wire [7:0] actual_write_adr;
  integer i;
  
  
  reg [31:0] mem [255:0];// data memory has 2^8 addresses. each address point to 32 bit data.
  
  assign actual_read_adr=read_adr[7:0];//actually we don't have to do it. the verilog knows to cut the bits that don't have room in the bus. it's just to show the maximum address bits.
  assign actual_write_adr=write_adr[7:0];//same here.

   always@(posedge clk) begin
	if (reset)begin
		for (i=0;i<256;i=i+1)
			mem[i]<=i;	
	end
	else if (memwrite)
		mem[actual_write_adr]<=write_data;
		
   end
  

   always@* begin
	if(reset)begin
		read_data<=0;
	end
	else if (memread)begin
		#3;
		read_data<=mem[actual_read_adr];
	end
   end
 
	
 
endmodule

