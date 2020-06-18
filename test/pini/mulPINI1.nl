in 0 0_0 # a[0]
in 1 0_1 # a[1]
in 2 1_0 # b[0]
in 3 1_1 # b[1]
ref 4 # r01, r10
xor 3 4 # s01 = b1+r01
and 0 4 
xor 6 4 # p01^0 = (a0 + 1)*r01
and 0 5 # p01^1 = a0 * s01
xor 7 8 # z01 = p01_0 + p01_1
xor 2 4 # s10 = b0 + r10
and 1 4 
xor 11 4 # p10^0 = (a1 +1) * r10
and 1 10 # p10^1 = (a1 * s10)
xor 12 13   # z10 = p10^0 + p10^1 
and 0 2 
xor 15 9 # c0 = a0*b0 +  z01
and 1 3
xor 17 14 # c1 = a1*b1 + z10
out 16 0_0
out 18 0_1