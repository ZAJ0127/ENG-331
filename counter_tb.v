module counter_tb;
	reg capture, reset, clock;
	wire cout;

	wire valid;
	counter DUT (
		 capture, reset, clock, D, Q, valid
	);
	
	
	initial begin 
		$display( $time, ": Test | S    ");
		$display( $time, ":------+------" );
		$monitor( $time, ":  %1d  | %2d ", capture, cout );
	end
	
	initial begin
			{ test } = 1'b00;
		#10 { test } = 1'b01;
		#10 { test } = 2'b10;
		#10 { test } = 2'b11;		
		#10 $stop();
	end
	
endmodule