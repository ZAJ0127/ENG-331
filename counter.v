module dff (
  input rst_n, clock,
  input d,
  output reg q,
  output q_n
);

  always @(posedge clock )
    if( !rst_n )
      q <= 0;
    else
      q <= d;

  assign q_n = ~q;

endmodule

module dff_4bit (
  input rst_n, clock,
  input [3:0] D,
  output [3:0] Q
);

  wire [3:0] q_bar;

  dff U0 ( rst_n, clock, D[0], Q[0], q_bar[0] );
  dff U1 ( rst_n, clock, D[1], Q[1], q_bar[1] );
  dff U2 ( rst_n, clock, D[2], Q[2], q_bar[2] );
  dff U3 ( rst_n, clock, D[3], Q[3], q_bar[3] );

endmodule

module mux21 (
  input sel, in_0, in_1,
  output f
);

  assign f = sel ? in_1 : in_0;

endmodule

module mux21_2bit (
  input sel,
  input [1:0] in_0, in_1,
  output [1:0] f
);

  mux21 U0 ( sel, in_0[0], in_1[0], f[0] );
  mux21 U1 ( sel, in_0[1], in_1[1], f[1] );

endmodule



module fa (
  input Cin, A, B,
  output Cout, Sum
);

  assign Sum = Cin ^ A ^ B;
  assign Cout = ( Cin & A ) | ( A & B ) | ( Cin & B );

endmodule


module fa2bit (
  input [1:0] A, B,
  output [2:0] F
);

  wire w1;
  wire Cin_tied;

  assign Cin_tied = 1'b0;

  fa U1 ( Cin_tied, A[0], B[0], w1, F[0] );
  fa U2 ( w1, A[1], B[1], F[2], F[1] );

endmodule


module counter (
	input capture, reset, clock;
	input [1:0] test,
	output valid;
	output [1:0] cout
);

	wire [2:0] s;
	wire [1:0] c, r;
	wire [1:0] ground = 2'b00;

	wire [1:0] on = 2'b01;
	
	fa2bit V1 (.A(cout), .B(on), .F(s));
	mux21_2bit V2 ( .sel(capture), .in_0(cout), .in_1(s), .f(c));
	dff_2bit df ( .rst_n (reset), .clock (clock), .d(c), .q(cout);
	
	assign valid = cout & cout;
	
	
	
endmodule
	
	