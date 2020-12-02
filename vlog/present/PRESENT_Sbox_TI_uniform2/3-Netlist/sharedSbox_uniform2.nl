in 0 3_0 # sboxIn1[3]
in 1 2_0 # sboxIn1[2]
in 2 1_0 # sboxIn1[1]
in 3 0_0 # sboxIn1[0]
in 4 3_1 # sboxIn2[3]
in 5 2_1 # sboxIn2[2]
in 6 1_1 # sboxIn2[1]
in 7 0_1 # sboxIn2[0]
in 8 3_2 # sboxIn3[3]
in 9 2_2 # sboxIn3[2]
in 10 1_2 # sboxIn3[1]
in 11 0_2 # sboxIn3[0]
not 11 # g1_U43
not 7 # g1_U39
xor 10 9 # g1_U10
xor 8 9 # g1_U8
xor 10 8 # g1_U6
not 6 # g1_U2
not 5 # g1_U1
not 3 # g2_U67
nand 11 8 # g2_U24
not 11 # g2_U12
not 8 # g2_U9
not 1 # g2_U7
not 2 # g2_U6
not 10 # g2_U5
not 9 # g2_U4
not 7 # g3_U44
xor 0 2 # g3_U43
xor 0 1 # g3_U41
not 3 # g3_U35
not 2 # g3_U26
not 1 # g3_U25
xnor 6 5 # g3_U24
xnor 6 4 # g3_U22
xnor 4 5 # g3_U21
nand 11 18 # g1_U49
nand 12 17 # g1_U48
nor 12 17 # g1_U44
nor 11 18 # g1_U42
nor 6 16 # g1_U33
or 15 5 # g1_U31
nor 17 18 # g1_U21
nand 17 18 # g1_U12
not 14 # g1_U11
nor 18 15 # g1_U9
or 16 17 # g1_U7
nor 18 6 # g1_U4
nor 17 5 # g1_U3
xnor 22 10 # g2_U64
xnor 26 8 # g2_U58
nand 21 22 # g2_U27
nand 26 10 # g2_U26
nand 25 9 # g2_U25
nand 8 21 # g2_U18
nor 26 25 # g2_U15
nand 22 11 # g2_U10
xnor 24 23 # g2_U8
nand 7 29 # g3_U50
nand 27 28 # g3_U49
nor 28 27 # g3_U45
nor 7 29 # g3_U42
and 32 35 # g3_U40
nand 34 31 # g3_U38
not 33 # g3_U36
nor 32 31 # g3_U34
nand 2 32 # g3_U31
nand 1 31 # g3_U29
nand 32 31 # g3_U27
and 2 34 # g3_U23
nand 35 1 # g3_U5
nand 37 36 # g1_U50
nor 39 38 # g1_U45
nor 14 43 # g1_U36
nand 42 14 # g1_U30
nand 48 16 # g1_U27
nand 47 15 # g1_U26
and 42 44 # g1_U22
and 16 47 # g1_U18
and 15 48 # g1_U17
nor 44 43 # g1_U13
nor 48 47 # g1_U5
nand 53 52 # g2_U70
nand 49 21 # g2_U65
nand 50 21 # g2_U59
nor 51 53 # g2_U40
nor 20 52 # g2_U39
nor 25 54 # g2_U34
nor 10 56 # g2_U33
nor 54 26 # g2_U30
nor 9 56 # g2_U29
not 57 # g2_U17
nand 21 57 # g2_U13
or 57 56 # g2_U11
nor 53 20 # g2_U2
nor 52 51 # g2_U1
nand 66 67 # g3_U54
nand 59 58 # g3_U51
nor 61 60 # g3_U46
nand 65 64 # g3_U37
nor 66 35 # g3_U32
nor 34 67 # g3_U30
nor 33 68 # g3_U28
nor 35 67 # g3_U14
nor 34 66 # g3_U13
nor 68 64 # g3_U11
and 33 65 # g3_U1
xnor 7 81 # g1_U54
nand 71 13 # g1_U51
xnor 44 72 # g1_U46
nand 74 41 # g1_U32
nand 76 75 # g1_U28
nor 79 78 # g1_U19
nor 45 80 # g1_U14
xor 11 82 # g2_U71
xor 22 91 # g2_U55
nor 86 85 # g2_U41
nor 88 87 # g2_U35
nor 90 89 # g2_U31
nand 91 54 # g2_U19
nand 93 92 # g2_U14
or 95 94 # g2_U3
xor 3 96 # g3_U55
nand 97 30 # g3_U52
xor 64 98 # g3_U47
nand 99 63 # g3_U39
nor 101 100 # g3_U33
or 104 103 # g3_U15
nor 69 102 # g3_U4
reg 96 # y3_s_current_state_reg_2_
reg 82 # y2_s_current_state_reg_2_
reg 81 # y1_s_current_state_reg_2_
nand 109 7 # g1_U47
nor 110 40 # g1_U34
nand 111 4 # g1_U29
nor 4 112 # g1_U20
nand 46 113 # g1_U15
xor 26 115 # g2_U62
xor 25 115 # g2_U56
nor 2 116 # g2_U50
or 23 118 # g2_U48
nand 23 121 # g2_U47
or 117 24 # g2_U46
nor 24 116 # g2_U42
nor 2 117 # g2_U36
nor 1 118 # g2_U32
nand 1 121 # g2_U28
nand 25 119 # g2_U20
nand 120 55 # g2_U16
nand 124 3 # g3_U48
nand 0 127 # g3_U16
nor 125 62 # g3_U9
nand 70 128 # g3_U6
nor 0 126 # g3_U2
reg 122 # y3_s_current_state_reg_3_
reg 114 # y2_s_current_state_reg_3_
reg 107 # y1_s_current_state_reg_3_
not 155 # f1_U29
not 154 # f1_U24
not 154 # f2_U49
not 156 # f2_U22
not 156 # f3_U29
not 155 # f3_U24
nand 132 108 # g1_U52
nor 4 133 # g1_U35
nor 135 77 # g1_U23
nand 136 4 # g1_U16
nand 11 137 # g2_U63
nand 138 11 # g2_U57
nand 141 140 # g2_U49
nor 145 144 # g2_U37
nor 9 147 # g2_U21
nand 149 123 # g3_U53
nor 0 151 # g3_U10
nand 152 0 # g3_U7
nor 106 153 # g3_U3
xor 4 163 # g1_U53
nor 164 73 # g1_U37
nand 166 165 # g1_U24
nand 167 83 # g2_U66
nand 168 84 # g2_U60
nor 169 139 # g2_U51
nand 146 170 # g2_U38
nand 171 92 # g2_U22
nor 173 105 # g3_U12
nand 175 174 # g3_U8
reg 172 # y3_s_current_state_reg_1_
xor 186 129 # f1_U19
not 186 # f1_U1
nand 134 177 # g1_U38
nand 178 7 # g1_U25
nand 179 19 # g2_U68
nand 180 3 # g2_U61
nand 142 181 # g2_U52
nor 182 143 # g2_U43
nand 148 183 # g2_U23
nand 30 185 # g3_U19
nand 184 150 # g3_U17
reg 176 # y1_s_current_state_reg_1_
xor 198 131 # f2_U18
not 198 # f2_U1
nand 189 13 # g1_U40
nand 192 191 # g2_U69
nand 193 0 # g2_U53
nor 0 194 # g2_U44
nand 3 197 # g3_U18
nand 190 201 # g1_U41
nor 195 204 # g2_U45
nand 205 196 # g3_U20
reg 202 # y2_s_current_state_reg_1_
xor 209 130 # f3_U19
not 209 # f3_U11
nand 207 203 # g2_U54
reg 208 # y3_s_current_state_reg_0_
reg 206 # y1_s_current_state_reg_0_
not 213 # f1_U16
nand 213 198 # f2_U44
nor 160 213 # f2_U23
nand 213 156 # f2_U19
not 214 # f2_U17
not 213 # f2_U16
nand 213 131 # f2_U9
nand 214 209 # f3_U46
nand 214 155 # f3_U32
nor 162 214 # f3_U25
not 214 # f3_U17
nand 214 130 # f3_U8
reg 212 # y2_s_current_state_reg_0_
nand 227 186 # f1_U46
nor 209 215 # f1_U38
nor 186 215 # f1_U36
nand 227 154 # f1_U32
nand 158 215 # f1_U27
nor 158 227 # f1_U25
nand 154 215 # f1_U21
not 227 # f1_U17
nand 227 129 # f1_U9
nand 219 216 # f2_U45
nand 220 198 # f2_U41
nor 186 219 # f2_U36
nor 198 219 # f2_U34
nor 199 217 # f2_U29
nand 199 217 # f2_U28
xor 199 217 # f2_U24
xor 199 218 # f2_U20
nand 221 219 # f2_U10
nand 131 220 # f2_U4
nor 214 220 # f2_U2
nand 225 209 # f3_U43
xnor 210 223 # f3_U33
xnor 224 210 # f3_U26
nand 225 155 # f3_U18
not 227 # f3_U16
nor 227 225 # f3_U4
nand 130 225 # f3_U1
nand 215 228 # f1_U47
nand 235 186 # f1_U43
xnor 229 235 # f1_U39
nand 209 230 # f1_U37
xnor 187 231 # f1_U33
xnor 233 187 # f1_U26
nand 235 154 # f1_U18
nand 236 215 # f1_U10
nand 129 235 # f1_U4
nor 213 235 # f1_U2
xor 238 186 # f2_U42
xnor 239 220 # f2_U37
nand 186 240 # f2_U35
nand 214 241 # f2_U30
nand 243 214 # f2_U25
nor 214 244 # f2_U21
xnor 246 129 # f2_U5
nand 131 247 # f2_U3
nand 252 222 # f3_U47
xor 248 198 # f3_U44
nor 198 252 # f3_U38
nor 209 252 # f3_U36
nand 252 249 # f3_U34
nand 162 252 # f3_U27
nand 155 252 # f3_U21
xnor 251 210 # f3_U20
nand 226 252 # f3_U9
nand 130 253 # f3_U5
xnor 254 131 # f3_U2
xor 256 209 # f1_U44
nand 257 186 # f1_U40
nand 215 259 # f1_U34
nand 260 232 # f1_U28
xnor 261 187 # f1_U20
xnor 263 130 # f1_U5
nand 129 264 # f1_U3
nor 159 269 # f2_U50
nand 265 214 # f2_U43
nand 266 198 # f2_U38
nand 242 268 # f2_U31
nor 154 269 # f2_U26
not 271 # f2_U11
nand 214 271 # f2_U6
nand 274 227 # f3_U45
xnor 275 225 # f3_U39
nand 198 276 # f3_U37
nand 250 278 # f3_U28
nand 280 279 # f3_U22
not 283 # f3_U6
nand 227 283 # f3_U3
nor 155 287 # f1_U52
nand 284 213 # f1_U45
nand 258 285 # f1_U41
nor 287 157 # f1_U30
nand 288 234 # f1_U22
not 289 # f1_U11
nand 213 289 # f1_U6
nand 159 294 # f2_U52
nor 270 291 # f2_U51
nand 292 237 # f2_U46
nand 267 293 # f2_U39
nand 154 294 # f2_U32
nor 270 295 # f2_U27
nand 214 296 # f2_U12
nand 272 297 # f2_U7
nor 156 301 # f3_U52
nor 161 302 # f3_U51
nand 298 273 # f3_U48
nand 299 209 # f3_U40
nor 301 161 # f3_U30
nor 156 302 # f3_U23
nand 282 304 # f3_U12
nand 227 303 # f3_U7
nor 157 309 # f1_U51
nand 306 255 # f1_U48
nand 158 307 # f1_U42
nor 155 309 # f1_U23
nand 213 310 # f1_U12
nand 290 311 # f1_U7
nand 313 312 # f2_U53
nand 156 314 # f2_U47
nand 160 315 # f2_U40
nand 317 316 # f2_U33
nand 245 318 # f2_U13
nand 200 319 # f2_U8
nor 321 320 # f3_U53
nand 155 322 # f3_U49
nand 300 323 # f3_U41
nor 325 324 # f3_U31
nand 211 326 # f3_U13
nand 281 327 # f3_U10
nor 328 305 # f1_U53
nand 154 329 # f1_U49
nor 331 308 # f1_U31
nand 262 332 # f1_U13
nand 188 333 # f1_U8
nand 336 335 # f2_U48
nand 198 338 # f2_U14
nand 340 277 # f3_U54
nand 162 342 # f3_U42
nand 343 277 # f3_U35
nand 209 345 # f3_U14
nand 346 286 # f1_U54
nand 330 347 # f1_U50
nand 348 286 # f1_U35
nand 186 349 # f1_U14
nand 339 352 # f2_U15
nand 354 341 # f3_U50
nand 344 356 # f3_U15
nand 350 360 # f1_U15
out 357 3_0 # share1[3]
out 358 2_0 # share1[2]
out 359 1_0 # share1[1]
out 364 0_0 # share1[0]
out 334 3_1 # share2[3]
out 351 2_1 # share2[2]
out 337 1_1 # share2[1]
out 361 0_1 # share2[0]
out 353 3_2 # share3[3]
out 362 2_2 # share3[2]
out 355 1_2 # share3[1]
out 363 0_2 # share3[0]
