module decoder_7(in,a,b,c,d,e,f,g);
input [3:0] in;
output a,b,c,d,e,f,g;
reg a,b,c,d,e,f,g;
always@(*)
  begin 
      case (in)
      0: {a,b,c,d,e,f,g}=7'b0000001;
      1: {a,b,c,d,e,f,g}=7'b1001111;
      2: {a,b,c,d,e,f,g}=7'b0010010;
      3: {a,b,c,d,e,f,g}=7'b0000110;
      4: {a,b,c,d,e,f,g}=7'b1001100;
      5: {a,b,c,d,e,f,g}=7'b0100100;
      6: {a,b,c,d,e,f,g}=7'b0100000;
      7: {a,b,c,d,e,f,g}=7'b0001111;
      8: {a,b,c,d,e,f,g}=7'b0000000;
      9: {a,b,c,d,e,f,g}=7'b0000100;
      default:  {a,b,c,d,e,f,g}=7'b1111111;
      endcase
end
endmodule

