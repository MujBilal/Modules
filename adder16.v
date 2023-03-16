module adder16(a, b, cin, sum, cout);
input [15:0] a;
input [15:0] b;
input cin;
output [15:0] sum;
output cout;

wire [15:0] temp_sum;
wire temp_cout;

assign temp_sum = a + b + cin;
assign sum = temp_sum[15:0];
assign temp_cout = temp_sum[16];

assign cout = (temp_cout == 1'b1) ? 1'b1 : 1'b0;

endmodule

