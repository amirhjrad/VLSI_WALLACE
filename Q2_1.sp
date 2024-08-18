
.lib 'mm018.l' tt

* NAND
.subckt NAND A B Y Vdd Vss
M1 N1 A Vdd Vdd PMOS L=0.18u W=2u
M2 Y B N1 Vdd PMOS L=0.18u W=2u
M3 Y A Vss Vss NMOS L=0.18u W=1u
M4 Y B Vss Vss NMOS L=0.18u W=1u
.ends NAND

* Define Full Adder
.subckt FA A B Cin S Cout Vdd Vss
x1 A B out1 Vdd Vss NAND
x2 A out1 out2 Vdd Vss NAND
x3 B out1 out3 Vdd Vss NAND
x4 out2 out3 out4 Vdd Vss NAND
x5 out4 Cin out5 Vdd Vss NAND
x6 out4 out5 out6 Vdd Vss NAND
x7 out5 Cin out7 Vdd Vss NAND
x8 out6 out7 S Vdd Vss NAND
x9 out5 out1 Cout Vdd Vss NAND
.ends FA

* Power Supplies
Vdd Vdd 0 1.8
Vss Vss 0 0

* Pulse Sources for Inputs
Va A 0 PULSE(0 1.8 0 0n 0n 5n 10n)
Vb B 0 PULSE(0 1.8 0 0 0n 6n 13n)
Vcin Cin 0 PULSE(0 1.8 0 0 0n 7n 16n)

* Va A 0 0
* Vb B 0 1.8
* Vcin Cin 0 1.8

* Va A 0 0
* Vb B 0 0
* Vcin Cin 0 1.8

* Instantiate
XFA A B Cin S Cout Vdd Vss FA

* Transient Analysis
.tran 1n 100n

.OPTIONS post=2

.end
