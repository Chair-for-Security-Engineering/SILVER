in 0 0_0 # a[0]
in 1 0_1 # a[1]
in 2 0_2 # a[2]
in 3 1_0 # b[0]
in 4 1_1 # b[1]
in 5 1_2 # b[2]
ref 6 # r01, r10
ref 7 # r02, r20
ref 8 # r12, r21
xor 4 6 # s01 = b1 + r01
and 0 6
xor 10 6 # p01_0 = a0 * r01 + r01
and 0 9 # p01_1 = a0 * s01
xor 11 12 # z01
xor 5 7 # s02 = b2 + r02
and 0 7 
xor 15 7 # p02_0 = a0 * r02 + r02
and 0 14 # p02_1 = a0 * s02
xor 16 17 # z02
xor 3 6 # s10 = b0 + r10
and 1 6
xor 20 6 # p10_0 = a1 * r10 + r10
and 1 19 # p10_1 = a1 * s10
xor 21 22 # z10
xor 5 8 # s12 = b2 + r12
and 1 8
xor 25 8 # p12_0 = a1 * r12 + r12
and 1 24 # p12_1 = a1 * s12
xor 26 27 # z12
xor 3 7 # s20 = b0 + r20
and 2 7
xor 30 7 # p20_0 = a2 * r20 + r20
and 2 29 # p20_1 = a2 * s20
xor 31 32 #z20
xor 4 8 # s21 = b1 + r21
and 2 8
xor 35 8 # p21_0 = a2 * r21 + r21
and 2 34 # p21_1 = a2 * s21
xor 36 37 #z21
and 0 3
xor 39 13 
xor 40 18 # c0
and 1 4 
xor 42 23
xor 43 28 # c1
and 2 5
xor 45 33
xor 46 38 #c3
out 41 0_0
out 44 0_1
out 47 0_2