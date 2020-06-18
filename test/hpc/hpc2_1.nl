in 0 0_0 # a[0]
in 1 0_1 # a[1]
in 2 1_0 # b[0]
in 3 1_1 # b[1]
ref 4 # r01 = r10
reg 4 # reg[r01]
and 0 5 
xor 6 5 # u01 = a0' * reg[r01]
xor 3 4 # v01
and 1 5
xor 9 5 # u10
xor 2 4 # v10
reg 2 # reg[b0]
reg 3 # reg[b1]
reg 7 # reg[u01]
reg 8 # reg[v01]
reg 10 # reg[u10]
reg 11 # reg[v10]
and 0 12 # a0 * reg[b0]
reg 18 # reg[a0 * reg[b0]]
and 0 15 # a0 * reg[v01]
reg 20 # reg[a0 * reg[v01]]
and 1 13 # a1 * reg[b1]
reg 22 # reg[a1 * reg[b1]]
and 1 17 # a1 * reg[v10]
reg 24 # reg[a1 * reg[v10]]
xor 19 14
xor 26 21 # o0
xor 23 16
xor 28 25 # o1
out 27 0_0
out 29 0_1