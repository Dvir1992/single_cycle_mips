module tb_im;
  reg reset;
  reg [31:0] read_adr;
  wire [31:0] inst_out;
  
  reg [31:0] inst_mem [8:0];
  integer i;
  
  
 instruction_memory tb(
	.reset(reset),
	.read_adr(read_adr),
	.inst_out(inst_out)
	);
  
   initial begin //6b op|5b s|5b t|5b d|sham|funct| // these are the fields of the instruction word.
	inst_mem[0]=32'b00000000010000010000000000100001;//add
	inst_mem[1]=32'b00000001000010110101000000100010;//sub
	inst_mem[2]=32'b00000001000011000101000000100100;//and
	inst_mem[3]=32'b00000001000011000101000000100101;//or
	inst_mem[4]=32'b00000000010000010000000000101010;//slt
	inst_mem[5]=32'b01001100000000110000000000000100;//lw
	inst_mem[6]=32'b10101100000000110000000000001000;//sw
	inst_mem[7]=32'b00010000101001000000000000000010;//beq not with offset=2.
	inst_mem[8]=32'b00010000100001000000000000000010;//beq with offset=2-> should perform inst_mem[2] instruction.

 end

   initial begin
	reset=1;
	#50;
	reset=0;
    read_adr=0;	
	i=0;
	repeat(8)begin//check if the instruction red correctly from the instruction memory
		@(inst_out);
		if(inst_mem[i]!=inst_out)
			$error("%t:failure", $time);
		else 
			$display("succsees");
		#5
		read_adr=(read_adr+4)%36;
		i=i+1;
	end
	#10;	
    $finish;
   end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  

    
  
      
endmodule
