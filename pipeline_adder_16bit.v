`timescale 1ns/1ns

module pipeline_adder_16bit(clk,reset,a, b, cin, sum, cout);
input clk,reset;
input [15:0] a,b;
input cin;
output [15:0] sum;
output  cout;

wire [2:0] c;
wire [15:0] s;
reg [3:0] r1,r2,r3;
reg[3:0] s1,s2,s3,s4;
reg[3:0] t1,t2,t3,t4,t5;
reg[3:0] u1,u2,u3,u4,u5,u6;
reg[3:0]t1,t2,t3,t4,t5;
reg a1,a2,a3;


carry_select_adder_4bit_slice CLA1(
.a(a[3:0]), 
.b(b[3:0]), 
.cin(cin),
.sum(s[3:0]),
.cout(c[0]));

carry_select_adder_4bit_slice CLA2(
.a(s1),
.b(s2), 
.cin(a1), 
.sum(s[7:4]),
 .cout(c[1]));

carry_select_adder_4bit_slice CLA3(
.a(t3),
 .b(t4), 
.cin(a2),
 .sum(s[11:8]),
 .cout(c[2]));

carry_select_adder_4bit_slice CLA4(
.a(u5),
 .b(u6), 
.cin(a3),
 .sum(sum[15:12]),
 .cout(cout));


always @(posedge clk or posedge reset)
begin
		if (reset)
		begin
		     r1<=0;r2<=0;r3<=0;
		     a1<=0;a2<=0;a3<=0;
		     s1<=0;s2<=0;s3<=0;s4<=0;
		     t1<=0;t2<=0;t3<=0;t4<=0;t5<=0;
		     u1<=0;u2<=0;u3<=0;u4<=0;u5<=0;u6<=0;
	        end

else
begin
//1st level
	   r1<=s[3:0];
	   r2<=r1;
	   r3<=r1;
	  
	   
//2nd Level 	
	  s1<=a[7:4];
	  s2<=b[7:4];
	  a1<=c[0];
	  s3<=s[7:4];
	  s4<=s3;
	  
//3rd Level 
	 t1<=a[11:8];
	 t2<=b[11:8];
	 t3<=t1;
	 t4<=t2;
	 a2<=c[1];
	 t5<=s[11:8];

//4th Level
	 u1<=a[15:12];
	 u2<=b[15:12];
	 u3<=u1;
	 u4<=u2;
	 u5<=u3;
	 u6<=u4;
	 a3<=c[2];
     end
	
end

assign  sum[3:0]=r3;
assign  sum[7:4]=s4;
assign  sum[11:8]=t5;
endmodule

/////////////////////////////////////
//4-bit Carry Select Adder Slice
/////////////////////////////////////


module carry_select_adder_4bit_slice(
a,
b, 
cin,
sum, 
cout);
input [3:0] a,b;
input cin;
output [3:0] sum;
output  cout;

wire [3:0] s0,s1;
wire  c0,c1;

ripple_carry_4_bit rca1 (
.a(a[3:0]), 
.b(b[3:0]), 
.cin(1'b0), 
.sum(s0[3:0]), 
.cout(c0));//for input carry zero
ripple_carry_4_bit rca2 (
.a(a[3:0]), 
.b(b[3:0]), 
.cin(1'b1), 
.sum(s1[3:0]), 
.cout(c1));//for input carry 1

mux2X1 #(4) ms0(
.in0(s0[3:0]),
.in1(s1[3:0]),
.sel(cin),
.out(sum[3:0]));
mux2X1 #(1) mc0 (
.in0(c0),
.in1(c1),
.sel(cin),
.out(cout));

endmodule


/////////////////////
//2X1 Mux
/////////////////////

module mux2X1( in0,in1,sel,out);
parameter width=16; 
input [width-1:0] in0,in1;
input sel;
output [width-1:0] out;
assign out=(sel)?in1:in0;
endmodule

/////////////////////////////////
//4-bit Ripple Carry Adder
/////////////////////////////////

module ripple_carry_4_bit(a, b, cin, sum, cout);
input [3:0] a,b;
input cin;
wire c1,c2,c3;
output [3:0] sum;
output  cout;

full_adder fa0(.a(a[0]), .b(b[0]),.cin(cin), .sum(sum[0]),.cout(c1));
full_adder fa1(.a(a[1]), .b(b[1]), .cin(c1), .sum(sum[1]),.cout(c2));
full_adder fa2(.a(a[2]), .b(b[2]), .cin(c2), .sum(sum[2]),.cout(c3));
full_adder fa3(.a(a[3]), .b(b[3]), .cin(c3), .sum(sum[3]),.cout(cout));
endmodule

////////////////////////////////////
//1bit Full Adder
////////////////////////////////////

module full_adder(a,b,cin,sum, cout);
input a,b,cin;
output sum, cout;
wire x,y,z;
half_adder  h1(.a(a), .b(b), .sum(x), .cout(y));
half_adder  h2(.a(x), .b(cin), .sum(sum), .cout(z));
or or_1(cout,z,y);
endmodule

//////////////////////////////////
// 1 bit Half Adder
//////////////////////////////////

module half_adder( a,b, sum, cout );
input a,b;
output sum,  cout;
xor xor_1 (sum,a,b);
and and_1 (cout,a,b);
endmodule
