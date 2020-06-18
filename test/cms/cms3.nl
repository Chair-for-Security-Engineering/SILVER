in 0 0_0
in 1 0_1
in 2 0_2
in 3 0_3
in 4 1_0
in 5 1_1
in 6 1_2
in 7 1_3
ref 8 # r1
ref 9 # r2
ref 10 # r3
ref 11 # r4
ref 12 # r5
ref 13 # r6
ref 14 # r7
ref 15 # r8
ref 16 # r9
ref 17 # r10
ref 18 # r11
ref 19 # r12
ref 20 # r13
ref 21 # r14
ref 22 # r15
ref 23 # 16
and 4 0
and 5 0
and 6 0
and 7 0
and 4 1
and 5 1
and 6 1
and 7 1
and 4 2
and 5 2
and 6 2
and 7 2
and 4 3
and 5 3
and 6 3
and 7 3
xor 24 8 # a[0]b[0] + r1
xor 25 9 # a[0]b[1] + r2
xor 26 10 # a[0]b[2] + r3
xor 27 11 # a[0]b[3] + r4
xor 28 12 # a[1]b[0] + r5
xor 29 13 # a[1]b[1] + r6
xor 30 14 # a[1]b[2] + r7
xor 31 15 # a[1]b[3] + r8
xor 32 16 # a[2]b[0] + r9
xor 33 17 # a[2]b[1] + r10
xor 34 18 # a[2]b[2] + r11
xor 35 19 # a[2]b[3] + r12
xor 36 20 # a[3]b[0] + r13
xor 37 21 # a[3]b[1] + r14
xor 38 22 # a[3]b[2] + r15
xor 39 23 # a[3]b[3] + r16
xor 55 8  # a[3]b[3] + r16 + r1
xor 40 9  # a[0]b[0] + r1 + r2
xor 41 10 # a[0]b[1] + r2 + r3
xor 42 11 # a[0]b[2] + r3 + r4
xor 43 12 # a[0]b[3] + r4 + r5
xor 44 13 # a[1]b[0] + r5 + r6
xor 45 14 # a[1]b[1] + r6 + r7
xor 46 15 # a[1]b[2] + r7 + r8
xor 47 16 # a[1]b[3] + r8 + r9
xor 48 17 # a[2]b[0] + r9 + r10
xor 49 18 # a[2]b[1] + r10 + r11
xor 50 19 # a[2]b[2] + r11 + r12
xor 51 20 # a[2]b[3] + r12 + r13
xor 52 21 # a[3]b[0] + r13 + r14
xor 53 22 # a[3]b[1] + r14 + r15
xor 54 23 # a[3]b[2] + r15 + r16
reg 57
reg 58
reg 59
reg 60
reg 61
reg 62
reg 63
reg 64
reg 65
reg 66
reg 67
reg 68
reg 69
reg 70
reg 71
reg 56
xor 73 72 # a[0]b[0] + a[0]b[1] + r1 + r3
xor 75 74 # a[0]b[2] + a[0]b[3] + r3 + r5
xor 77 76 # a[1]b[0] + a[1]b[1] + r5 + r7
xor 79 78 # a[1]b[2] + a[1]b[3] + r7 + r9
xor 81 80 # a[2]b[0] + a[2]b[1] + r9 + r11
xor 83 82 # a[2]b[2] + a[2]b[3] + r11 + r13
xor 85 84 # a[3]b[0] + a[3]b[1] + r13 + r15
xor 87 86 # a[3]b[2] + a[3]b[3] + r15 + r1
xor 89 88 # a[0]b + r1 + r5
xor 91 90 # a[1]b + r5 + r9
xor 93 92 # a[2]b + r9 + r13
xor 95 94 # a[3]b + r13 + r1
out 96 0_0
out 97 0_1
out 98 0_2
out 99 0_3