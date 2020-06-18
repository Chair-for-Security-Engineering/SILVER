in 0 0_0 # a[0]
in 1 0_1 # a[1]
in 2 1_0 # b[0]
in 3 1_1 # b[1]
ref 4
ref 5
xor 2 4 # b[0] refreshed
xor 3 4 # b[1] refreshed
reg 6 # b[0]
reg 7 # b[1]
and 9 0 # b1 * a0
and 9 1 # b1 * a1
and 8 0 # b0 * a0
and 8 1 # b0 * a1
xor 13 5 #b0 * a1 + r 
xor 10 5 #b1 * a0 + r 
reg 14
reg 15
xor 16 11
xor 17 12
out 19 0_0 # c[0]
out 18 0_1 # c[1]