// Define 1 ns as the delay time unit and 100 ps of precision in the waveform
`timescale 1 ns / 100 ps
module decoder_32_tb;
// inputs to the module (wire)
wire[4:0] select;
wire enable;

// outputs of the module (wire)
wire [31:0] out;

// Instantiate the module to test
decoder_32 adder(.out(out), .select(select), .enable(enable));
integer i = 6; // Use a 32-Bit integer as the For Loop variable
assign {enable} = 1'b0;
// Use the concatenation operator to quickly assign module inputs
assign {select} = 6; // Cin = i[16], A = i[15:8], B = i[7:0]
initial begin
// Allow time for the outputs to stabilize
#20;
// Display the outputs for the current inputs
$display("select:%b, enable:%b => out:%b",
select, enable, out);
// End the testbench
$finish;
end
// Define output waveform properties
initial begin
	// Output file name
	$dumpfile("decoder_32.vcd");
	// Module to capture and what level, 0 means all wires
	$dumpvars(0, decoder_32_tb);
end
endmodule