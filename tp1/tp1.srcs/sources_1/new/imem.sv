module imem
	#(parameter N = 32)
	(input logic [6:0] addr,
	output logic [N-1:0] q);
	 
	logic [N-1:0] ROM [0:127];
	
	initial
		begin
			ROM = '{default:0};
			ROM [0:98] ='{ 32'hf8008002,
								32'hf8000001,
									32'hf8000203,
									32'h8b050083,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8018003,
									32'hcb050083,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8020003,
									32'hcb0a03e4,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8028004,
									32'h8b040064,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8030004,
									32'hcb030025,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8038005,
									32'h8a1f0145,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8040005,
									32'h8a030145,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8048005,
									32'h8a140294,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8050014,
									32'haa1f0166,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8058006,
									32'haa030166,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8060006,
									32'hf840000c,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'h8b1f0187,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8068007,
									32'hf807000c,
									32'h8b0e01bf,
									32'hf807801f,
									32'hb40000a0,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8080015,
									32'hf8088015,
									32'h8b0103e2,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hcb010042,
									32'h8b0103f8,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf8090018,
									32'h8b080000,
									32'hb4ffff42,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf809001e,
									32'h8b1e03de,
									32'h8b1f03ff,
									32'hcb1503f5,
									32'h8b1403de,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf85f83d9,
									32'h8b1e03de,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'h8b1003de,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf81f83d9,
									//----------
									32'h8b1f03e0,
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'h91003c16,//addi
									32'h8b1f03ff,
									32'h8b1f03ff,
									32'hf80003d6,
									//-----------
									32'hd1004016,
									32'h8b1f03ff,
									32'h8b1f03ff, //subi
									32'hf80083d6,
									32'hb400001f};
					
		end
		
	assign q = ROM[addr];

endmodule

/*
STUR X1, [X0, #0] // MEM 0:0x1
STUR X2, [X0, #8] // MEM 1:0x2
STUR X3, [X16, #0] // MEM 2:0x3
ADD X3, X4, X5 
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X3, [X0, #24] // MEM 3:0x9 ---- x3
SUB X3, X4, X5
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X3, [X0, #32] // MEM 4:0xFFFFFFFFFFFFFFFF ---- x3
SUB X4, XZR, X10
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X4, [X0, #40] // MEM 5:0xFFFFFFFFFFFFFFF6 ---- x4
ADD X4, X3, X4
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X4, [X0, #48] // MEM 6:0xFFFFFFFFFFFFFFF5 ---- x4
SUB X5, X1, X3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X5, [X0, #56] // MEM 7:0x2 ---- x5
AND X5, X10, XZR
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X5, [X0, #64] // MEM 8:0x0 ---- x5
AND X5, X10, X3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X5, [X0, #72] // MEM 9:0xA ---- x5
AND X20, X20, X20
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X20, [X0, #80] // MEM 10:0x14 ---- x20 <-
ORR X6, X11, XZR
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X6, [X0, #88] // MEM 11:0xB ---- x6
ORR X6, X11, X3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X6, [X0, #96] // MEM 12:0xFFFFFFFFFFFFFFFF
LDUR X12, [X0, #0]
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ADD X7, X12, XZR
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X7, [X0, #104] // MEM 13:0x1
STUR X12, [X0, #112] // MEM 14:0x1
ADD XZR, X13, X14
STUR XZR, [X0, #120] // MEM 15:0x0
CBZ X0, L1
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X21, [X0, #128] // MEM 16:0x0(si falla CBZ =21)
L1: STUR X21, [X0, #136] // MEM 17:0x15 <-
ADD X2, XZR, X1
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
L2: SUB X2, X2, X1
ADD X24, XZR, X1
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X24, [X0, #144] // MEM 18:0x1 y MEM 19=0x1
ADD X0, X0, X8
CBZ X2, L2
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X30, [X0, #144] // MEM 20:0x1E
ADD X30, X30, X30
ADD XZR, XZR, XZR
SUB X21, XZR, X21
ADD X30, X30, X20
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
LDUR X25, [X30, #-8]
ADD X30, X30, X30
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ADD X30, X30, X16                                     
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X25, [X30, #-8] // MEM 21:0xA (= MEM 9)
//------------
ADD X0, XZR, XZR        <- 32'h8b1f03e0,
ADD XZR, XZR, XZR       <- 32'h8b1f03ff,
ADD XZR,XZR,XZR         <- 32'h8b1f03ff,           
ADDI X22 , X0, #15      <- 32'h91003c16,
ADD XZR, XZR, XZR       <- 32'h8b1f03ff,
ADD XZR,XZR,XZR         <- 32'h8b1f03ff,
STUR X22,[X30,#0]        <- 32'hf80003d6, //MEM 22: 0xF       
SUBI X22 , X0, #16      <- 32'hd1004016,
ADD XZR, XZR, XZR       <- 32'h8b1f03ff,
ADD XZR,XZR,XZR         <- 32'h8b1f03ff,
STUR X22,[X30,#8]        <- 32'hf80083d6, //MEM 23: 0xFFFFFFFFFFFFFFFF
//------------
finloop: CBZ XZR, finloop*/