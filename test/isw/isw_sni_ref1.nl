in 0 0_0 # a[0]
in 1 0_1 # a[1]
in 2 1_0 # b[0]
in 3 1_1 # b[1]
ref 4 # refresh
ref 5 # r01
xor 2 4
xor 3 4
reg 6 # reg[b0]
reg 7 # reg[b1]
and 0 9 
xor 10 5 # u01 = r01 + a0 * b1
and 1 8
xor 12 5 # u10 = r01 + a1 * b0
and 0 8 # u00 = a0 * b0
and 1 9 # u11 = a1 * b1
reg 11 # reg[u01]
reg 13 # reg[u10]
reg 14 # reg[u00]
reg 15 # reg[u11]
xor 18 16 
xor 19 17 
reg 20
reg 21
out 22 0_0
out 23 0_1