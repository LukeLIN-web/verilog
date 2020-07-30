module pc(D50,load,Clear,clk,pc_addr); 
input load, Clear, clk; 
input [5:0] D50; 
output reg [5:0] pc_addr; 
 
always @(posedge clk or posedge Clear) if(Clear) 
    pc_addr<=5'b00000; 
else begin 
    if(load)  pc_addr<=D50; 	 	 	  
    end 
endmodule 
