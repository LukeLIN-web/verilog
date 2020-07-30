module decoder_2to4(in,out);    //2->4
input [1:0] in;
output [3:0] out;
reg [3:0] out;
always@ (*)
  begin 
      case(in)
        0: out= 4'b1110;
        1: out= 4'b1101;
        2: out= 4'b1011;
        3: out= 4'b0111;
      endcase

  end
endmodule


