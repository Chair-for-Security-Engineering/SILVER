in 0 0:0 # a[0]
in 1 0:1 # a[1]
in 2 0:2 # a[2]
in 3 0:3 # a[3]
in 4 1:0 # b[0]
in 5 1:1 # b[1]
in 6 1:2 # b[2]
in 7 1:3 # b[3]
ref 8
ref 9
ref 10
ref 11
ref 12
ref 13
and 4 0 # a[0]b[0]
and 5 0 # a[0]b[1]
and 6 0 # a[0]b[2]
and 7 0 # a[0]b[3]
and 4 1 # a[1]b[0]
and 5 1 # a[1]b[1]
and 6 1 # a[1]b[2]
and 7 1 # a[1]b[3]
and 4 2 # a[2]b[0]
and 5 2 # a[2]b[1]
and 6 2 # a[2]b[2]
and 7 2 # a[2]b[3]
and 4 3 # a[3]b[0]
and 5 3 # a[3]b[1]
and 6 3 # a[3]b[2]
and 7 3 # a[3]b[3]
xor 15 8 # a[0]b[1] + r0
xor 18 8 # a[1]b[0] + r0
xor 16 9 # a[0]b[2] + r1
xor 22 9 # a[2]b[0] + r1
xor 20 10 # a[1]b[2] + r2
xor 23 10 # a[2]b[1] + r2
xor 26 11 # a[3]b[0] + r3
xor 17 11 # a[0]b[3] + r3
xor 27 12 # a[3]b[1] + r4
xor 21 12 # a[1]b[3] + r4
xor 25 13 # a[2]b[3] + r5
xor 28 13 # a[3]b[2] + r5
reg 14
reg 19
reg 24
reg 29
reg 30
reg 31
reg 32
reg 33
reg 34
reg 35
reg 36
reg 37
reg 38
reg 39
reg 40
reg 41
xor 42 46
xor 43 47
xor 44 49
xor 45 52
xor 58 48
xor 59 50
xor 60 51
xor 61 54
xor 62 53
xor 63 55
xor 64 56
xor 65 57
out 66 0:0
out 67 0:1
out 68 0:2
out 69 0:3