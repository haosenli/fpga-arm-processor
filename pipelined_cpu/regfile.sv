`timescale 10 ps / 1 ps
module regfile(
    output logic [63:0] ReadData1, ReadData2, 
    input  logic [63:0] WriteData, 
    input  logic [4:0] ReadRegister1, ReadRegister2, WriteRegister,
    input  logic RegWrite, clk
    );
    logic [31:0] decode;
    logic [31:0][63:0] data;
    
    enabled_decoder_5x32 decoder (.wr_en(RegWrite), .addr(WriteRegister), .decode(decode));
    
    genvar i;
    generate
    for (i=0; i<31; i++) begin: registers
        register regi (.clk(clk), .wr_en(decode[i]), .wr_data(WriteData), .rd_data(data[i][63:0]));
    end
    endgenerate
    register regi31 (.clk(clk), .wr_en(1'b1), .wr_data(64'd0), .rd_data(data[31][63:0]));
                
    multiplexor mux_32v1 (.in(data), .addr(ReadRegister1), .out(ReadData1));
    multiplexor mux_32v2 (.in(data), .addr(ReadRegister2), .out(ReadData2));
		
endmodule 

module regstim(); 		

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;
	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.ReadData1, .ReadData2, .WriteData, 
					 .ReadRegister1, .ReadRegister2, .WriteRegister,
					 .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end
endmodule