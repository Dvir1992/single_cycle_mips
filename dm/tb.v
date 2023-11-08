module tb_dm;
  reg clk;
  reg reset;
  reg [31:0] read_adr;
  reg [31:0] write_adr;
  reg [31:0] write_data;
  reg memwrite;
  reg memread;
  wire [31:0] read_data;
  
  reg [31:0] data_mem [255:0];
  integer i;
  
  
 data_memory tb(
	.clk(clk),
	.reset(reset),
	.read_adr(read_adr),
	.write_adr(write_adr),
	.write_data(write_data),
	.memwrite(memwrite),
	.memread(memread),
	.read_data(read_data)
	);
  
   initial begin //6b op|5b s|5b t|5b d|sham|funct| // these are the fields of the dataruction word.
	for (i=0;i<256;i=i+1)begin
		data_mem[i]=i;
	end
   end

   initial begin
    clk=0;
	reset=1;
	read_adr=0;
	write_adr=0;
	write_data=0;
	memwrite=0;
	memread=0;
	#50;
	reset=0;
	//reading and writing check
	i=0;
	repeat(256) begin
		memread=1;
		read_adr=i;
		write_adr=i;
		write_data=255-i;
		#4;
		if(read_data==i)
			$display("success");
		else
			$error("%t:failure",$time);	
		memread=0;
		memwrite=1;
		@(posedge clk);
		data_mem[write_adr]=write_data;
		if(data_mem[write_adr]==255-i)
				$display("success");
		else
			$error("%t:failure",$time);	
		memwrite=0;
		i=i+1;
	#10;	
	end
    $finish;
   end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  

    
  always#5 clk=~clk;  
  
      
endmodule

