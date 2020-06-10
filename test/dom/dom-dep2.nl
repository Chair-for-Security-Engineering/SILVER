in 0 0:0 # a[0]
in 1 0:1 # a[1]
in 2 0:2 # a[2]
ref 3 1:0 # b[0]
ref 4 1:1 # b[1]
ref 5 1:2 # b[2]
ref 6
ref 7
ref 8
and 3 0 # a[0]b[0]
and 4 0 # a[0]b[1]
and 5 0 # a[0]b[2]
and 3 1 # a[1]b[0]
and 4 1 # a[1]b[1]
and 5 1 # a[1]b[2]
and 3 2 # a[2]b[0]
and 4 2 # a[2]b[1]
and 5 2 # a[2]b[2]
xor 10 6 # a[0]b[1] + r0
xor 12 6 # a[1]b[0] + r0
xor 11 7 # a[0]b[2] + r1
xor 15 7 # a[2]b[0] + r1
xor 14 8 # a[1]b[2] + r2
xor 16 8 # a[2]b[1] + r2
reg 9
reg 13
reg 17
reg 18
reg 19
reg 20
reg 21
reg 22
reg 23
xor 24 27
xor 25 28
xor 26 30
xor 33 29
xor 34 31
xor 35 32
xor 3 0 # a1 + z1
xor 4 1 # a2 + z2
xor 5 2 # a3 + z3
reg 39
reg 40
reg 41
xor 44 43
xor 45 42
and 46 0 # a1(a+z)
and 46 1 # a2(a+z)
and 46 2 # a3(a+z)
xor 47 36
xor 48 37
xor 49 38
out 50 0:0
out 51 0:1
out 52 0:2