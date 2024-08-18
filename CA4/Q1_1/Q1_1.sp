
.lib 'mm018.l' tt

* Inverter
.SUBCKT INV IN OUT Vdd Vss
M1 OUT IN Vdd Vdd PMOS L=0.18u W=2u
M2 OUT IN Vss Vss NMOS L=0.18u W=1u
.ENDS INV

* NAND
.subckt NAND A B Y Vdd Vss
M1 N1 A Vdd Vdd PMOS L=0.18u W=2u
M2 Y B N1 Vdd PMOS L=0.18u W=2u
M3 Y A Vss Vss NMOS L=0.18u W=1u
M4 Y B Vss Vss NMOS L=0.18u W=1u
.ends NAND

* D-Latch 
.subckt DLATCH D CLK Q Qbar Vdd Vss
x1 CLK CLkbar Vdd Vss INV
x2 D Dbar Vdd Vss INV
X3 D CLkbar out3 Vdd Vss NAND
X4 Dbar CLkbar out4 Vdd Vss NAND
X5 out3 out6 Q Vdd Vss NAND
X6 out4 Q Qbar Vdd Vss NAND
.ends DLATCH

Vdd Vdd 0 1.8
Vss Vss 0 0

VCLK CLK 0 PULSE(0 1.8 0 0 0 5n 10n)
VD D 0 PULSE(0 1.8 0 0 0 17n 24n)

XDLATCH D CLK Q Qbar Vdd Vss DLATCH

.tran 1n 100n

* Measurement of Time Setup and Time Hold
.measure tran tsetup TRIG v(D) VAL=1.8 RISE=1 TARG v(CLK) VAL=0.9
.measure tran thold TRIG v(D) VAL=1.8 RISE=1 TARG v(CLK) VAL=0.9 TD=1n

.OPTIONS post=2

.end
