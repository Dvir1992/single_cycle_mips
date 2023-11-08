module tb_alu;
  reg reset;
  reg [31:0] data1;
  reg [31:0] data2;
  reg [2:0] op;
  wire [31:0] result;
  wire zero;
  reg [31:0] check;
  
  
  alu a(
  .reset(reset),
  .data1(data1),
  .data2(data2),
  .op(op),
  .result(result),
  .zero(zero)
  );
  

   initial begin
	 reset<=1;
	 #50;
	 reset<=0;
	 data1=$random%(2^31);
	 data2=$random%(2^31);
	 
	 op=3'b000;
	 #3;
	 if (result==(data1&data2))//and
		$display("%t: succuess",$time);
	 else
		$error("%t: faulite",$time);
		
	op=3'b001;
	 #3;
	 if (result==(data1|data2))//and
		$display("%t: succuess",$time);
	 else
		$error("%t: faulite",$time);
		
	op=3'b010;
	 #3;
	 if (result==(data1+data2))//and
		$display("%t: succuess",$time);
	 else
		$error("%t: faulite",$time);
		
	op=3'b110;
	 #3;
	 if (result==(data1-data2))//and
		$display("%t: succuess",$time);
	 else
		$error("%t: faulite",$time);
		
	op=3'b111;
	 #3;
	 if (result==(data1<<data2))//and
		$display("%t: succuess",$time);
	 else
		$error("%t: faulite",$time);
		

		 
	 
	 #10;	 	
    $finish;
   end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  


    
  
      
endmodule


