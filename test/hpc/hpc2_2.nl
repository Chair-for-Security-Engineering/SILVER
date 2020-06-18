in 0 0_0 # a[0]
in 1 0_1 # a[1]
in 2 0_2 # a[2]
in 3 1_0 # b[0]
in 4 1_1 # b[1]
in 5 1_2 # b[2]
ref 6 # r01, r10
ref 7 # r02, r20
ref 8 # r12, r21
reg 6 # reg[r01], reg[r10] 
reg 7 # reg[r02], reg[r20]
reg 8 # reg[r12], reg[r21]
not 0 # a0'
not 1 # a1'
not 2 # a2'
and 12 9 # u01 = a0'*reg[r01]
xor 4 6 # v01 = b1 + r01
and 12 10 # u02 = a0'*reg[r02]
xor 5 7 # v02 = b2 + r02
and 13 9 # u10 = a1' * reg[r10]
xor 3 6 # v10 = b0 * r10
and 13 11 # u12 = a1' * reg[r12]
xor 5 8 # v12 = b2 + r12
and 14 10 # u20 = a2' * reg[r20]
xor 3 7 # v20 = b0 + r20
and 14 11 # u21 = a2' * reg[r21]
xor 4 8 # v21 = b1 + r21
reg 3 # reg[b0]
reg 4 # reg[b1]
reg 5 # reg[b2]
reg 15 # reg[u01]
reg 16 # reg[v01]
reg 17 # reg[u02]
reg 18 # reg[v02]
reg 19 # reg[u10]
reg 20 # reg[v10]
reg 21 # reg[u12]
reg 22 # reg[v12]
reg 23 # reg[u20]
reg 24 # reg[v20]
reg 25 # reg[u21]
reg 26 # reg[v21]
and 0 27 # a0 * reg[b0]
reg 42 # reg[a0 * reg[b0]]
and 0 31 # a0 * reg[v01]
reg 44 # reg[a0 * reg[v01]]
and 0 33 # a0 * reg[v02]
reg 46 #reg[a0 * reg[v02]]
xor 43 30
xor 48 45
xor 49 32
xor 50 47 # o0
and 1 28 
reg 52 #reg [a1 * reg[b0]]
and 1 35
reg 54 # reg[a1 * reg[v10]]
and 1 37
reg 56 # reg[a1 * reg[v12]]
xor 53 34
xor 58 55
xor 59 36
xor 60 57 # o1
and 2 29
reg 62 # reg[a2 * reg[b2]]
and 2 39
reg 64 # reg[a2 * reg[v20]
and 2 41 
reg 66 # reg[a2 * reg[v21]]
xor 63 38
xor 68 65
xor 69 40
xor 70 67 # o2
out 51 0_0
out 61 0_1
out 71 0_2