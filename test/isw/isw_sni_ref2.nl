in 0 0_0 # a[0]
in 1 0_1 # a[1]
in 2 0_2 # a[2]
in 3 1_0 # b[0]
in 4 1_1 # b[1]
in 5 1_2 # b[2]
ref 6
ref 7
ref 8 # r01
ref 9 # r02
ref 10 # r12
xor 6 7
reg 11
xor 3 6
xor 4 7
xor 5 12
reg 13 # b0 refreshed
reg 14 # b1 refreshed
reg 15 # b2 refreshed
and 0 16 # a0 * b0
and 0 17 # a0 * b1
and 0 18 # a0 * b2
and 1 16 # a1 * b0
and 1 17 # a1 * b1
and 1 18 # a1 * b2
and 2 16 # a2 * b0
and 2 17 # a2 * b1
and 2 18 # a2 * b2
xor 20 8 # u01
xor 21 9 # u02
xor 22 8 # u10
xor 24 10 # u12
xor 25 9 # u20
xor 26 10 # u21
reg 19 # reg[u00]
reg 28 # reg[u01]
reg 29 # reg[u02]
reg 30 # reg[u10]
reg 23 # reg[u11]
reg 31 # reg[u12]
reg 32 # reg[u20]
reg 33 # reg[u21]
reg 27 # reg[u22]
xor 34 35
xor 43 36 # o0
xor 37 38
xor 45 39 # o2
xor 40 41
xor 47 42 # o3
reg 44
reg 46
reg 48
out 49 0_0
out 50 0_1
out 51 0_2