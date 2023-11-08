module tb_rf;
  reg clk;
  reg reset;  
  reg [4:0] read_reg1;
  reg [4:0] read_reg2;
  reg [4:0] write_reg;
  reg [31:0] write_data;
  reg reg_write;
  wire [31:0] read_data1;
  wire [31:0] read_data2;
 
  reg [31:0] regs [31:0];
  integer i;
  
  
 register_file rf(
	.clk(clk),
	.reset(reset),
	.read_reg1(read_reg1),
	.read_reg2(read_reg2),
	.write_reg(write_reg),
	.write_data(write_data),
	.reg_write(reg_write),
	.read_data1(read_data1),
	.read_data2(read_data2)
	);
  
   initial begin 
	for(i=0;i<32;i=i+1)begin
		regs[i]=i;
	end
	i=0;

 end

   initial begin
	clk=0;
	reset=1;
	read_reg1=0;
	read_reg2=0;
	write_reg=0;
	write_data=31;
	reg_write=0;
	
	#50;
	
	reset=0;
	repeat(31)begin//check reading from all regs from both ports
		#4;
		read_reg1<=read_reg1+1;
		read_reg2<=read_reg2+1;		
		if((read_data1!=regs[read_reg1])||(read_data2!=regs[read_reg2]))
			$error("failure");
		else
			$display("success");
	end
	
	
	#100;
	read_reg1=0;
	reg_write=1;
	repeat(32) begin//check writing to all regs with reg_write=1 by checking if values are written in the clk posedge.
		write_data=31-write_reg;
		regs[write_reg]=write_data;
		@(posedge clk);
		#4;
		if(regs[write_reg]==read_data1)
			$display("%t:success",$time);
		else 
			$error("%t:failure",$time);
				
		write_reg=write_reg+1;	
		read_reg1=read_reg1+1;
	end
	#10;	
	
    $finish;
   end
   
	
 

  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  always#5 clk=~clk;
  

    
  
      
endmodule

