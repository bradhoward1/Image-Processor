// Define 1 ns as the delay time unit and 100 ps of precision in the waveform
`timescale 1 ns / 100 ps
module my_tri_tb;
// inputs to the module (wire)
wire[31:0] in;
wire oe;

// outputs of the module (wire)
wire [31:0] out;

// Instantiate the module to test
my_tri adder(.out(out), .oe(oe), .in(in));
integer i = 6; // Use a 32-Bit integer as the For Loop variable
assign {oe} = 1'b1;
// Use the concatenation operator to quickly assign module inputs
assign {in} = 6; // Cin = i[16], A = i[15:8], B = i[7:0]
initial begin
// Allow time for the outputs to stabilize
#20;
// Display the outputs for the current inputs
$display("in:%b, oe:%b => out:%b",
in, oe, out);
// End the testbench
$finish;
end
// Define output waveform properties
initial begin
	// Output file name
	$dumpfile("my_tri.vcd");
	// Module to capture and what level, 0 means all wires
	$dumpvars(0, my_tri_tb);
end
endmodule