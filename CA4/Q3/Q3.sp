
.lib 'mm018.l' tt

* Inverter
.SUBCKT INV IN OUT Vdd Vss
M1 OUT IN Vdd Vdd PMOS L=0.18u W=2u
M2 OUT IN Vss Vss NMOS L=0.18u W=1u
.ENDS INV

* NAND
.subckt NAND A B Y Vdd Vss
M1 Y A Vdd Vdd PMOS L=0.18u W=2u
M2 Y B Vdd Vdd PMOS L=0.18u W=2u
M3 Y A N1 Vss NMOS L=0.18u W=1u
M4 N1 B Vss Vss NMOS L=0.18u W=1u
.ends NAND

* D-Latch 
.subckt DLATCH D CLK Q Qbar Vdd Vss
x2 D Dbar Vdd Vss INV
X3 D CLK out3 Vdd Vss NAND
X4 Dbar CLK out4 Vdd Vss NAND
X5 out3 out6 Q Vdd Vss NAND
X6 out4 Q Qbar Vdd Vss NAND
.ends DLATCH

* DFF
.subckt DFF D CLK Q Qbar Vdd Vss
x11 CLK CLkbar Vdd Vss INV
x22 D CLkbar q qbar Vdd Vss DLATCH
x33 CLkbar CLkbarbar Vdd Vss INV
x44 q CLkbarbar Q Qbar Vdd Vss DLATCH
.ends DFF

* Full Adder
.subckt FA A B Cin S Cout Vdd Vss
x1 A B AB_n Vdd Vss NAND
x2 A Cin AC_n Vdd Vss NAND
x3 B Cin BC_n Vdd Vss NAND
x4 AB_n AC_n S_n Vdd Vss NAND
x5 AB_n BC_n ABBC_n Vdd Vss NAND
x6 S_n Cin S Vdd Vss NAND
x7 ABBC_n S Cout Vdd Vss NAND
.ends FA


.subckt FA_DFF A B Cin CLK S Cout Vdd Vss
    x1 A CLK QA QAbar Vdd Vss DFF
    x2 B CLK QB QBbar Vdd Vss DFF
    x3 Cin CLK QCin QCinbar Vdd Vss DFF
    x4 QA QB QCin S1 Cout1 Vdd Vss FA
    x5 S1 CLK S QSbar Vdd Vss DFF
    x6 Cout1 CLK Cout QCbar Vdd Vss DFF
.ends FA_DFF

Vdd Vdd 0 1.8
Vss Vss 0 0
VA A 0 1.8
VB B 0 1.8
VC Cin 0 1.8
* Va A 0 PULSE(0 1.8 0 0n 0n 50n 100n)
* Vb B 0 PULSE(0 1.8 0 0 0n 60n 130n)
* Vcin Cin 0 PULSE(0 1.8 0 0 0n 70n 160n)
VCLK CLK 0 PULSE(0 1.8 0 0 0 5n 10n)


XFA_DFF A B Cin CLK S Cout Vdd Vss FA_DFF

* Print Outputs
.print TRAN V(A) V(B) V(S) V(Cout)
* Transient Analysis
.tran 1n 100n

.OPTIONS post=2

.end
