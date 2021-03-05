**islamist
generate islamist = .
replace islamist = 1 if (V19 == 1)
replace islamist = 0 if (V19 == 2)
replace islamist = 0 if (V19 == 3)
replace islamist = 0 if (V19 == 4)
replace islamist = 0 if (V19 == 5)
replace islamist = 0 if (V19 == 6)
replace islamist = 0 if (V19 == 7)
replace islamist = 0 if (V19 == 8)
replace islamist = 0 if (V19 == 9)
replace islamist = 0 if (V19 == 10)
replace islamist = 0 if (V19 == 11)

generate islamist2 = 0
replace islamist2 = 1 if (V15 == 2)

**sharia support
generate islamist3 = 0
replace islamist3 = 1 if (V25 == 4)
replace islamist3 = 1 if (V25 == 5)
replace islamist3 = . if (V25 == 6)

**religious leaders
generate islamist4 = 0
replace islamist4 = 1 if (V27 == 4)
replace islamist4 = 1 if (V27 == 5)
replace islamist4 = . if (V27 == 6)

**democrat
generate democrat = 0
replace democrat = 1 if (V24 == 4)
replace democrat = 1 if (V24 == 5)
replace democrat = . if (V24 == 6)

**antiamerican
generate antiamerican = 0
replace antiamerican = 1 if (V26 == 1)
replace antiamerican = 1 if (V26 == 2)
replace antiamerican = . if (V26 == 6)

generate antiamerican2 = .
replace antiamerican2 = 1 if (V26 == 1)
replace antiamerican2 = 2 if (V26 == 2)
replace antiamerican2 = 3 if (V26 == 3)
replace antiamerican2 = 3 if (V26 == 4)
replace antiamerican2 = 3 if (V26 == 5)

**civilian targets
generate violence = 0
replace violence = 1 if (V29 == 4)
replace violence = 1 if (V29 == 5)
replace violence = . if (V29 == 6)

**Ennahda responses
generate new6_1 = V6_1
replace new6_1 = . if (V6_1 == 5)
replace new6_1 = . if (V6_1 == 6)

generate new6_2 = V6_2
replace new6_2 = . if (V6_2 == 5)
replace new6_2 = . if (V6_2 == 6)

generate new6_3 = V6_3
replace new6_3 = . if (V6_3 == 5)
replace new6_3 = . if (V6_3 == 6)

generate new6_4 = V6_4
replace new6_4 = . if (V6_4 == 5)
replace new6_4 = . if (V6_4 == 6)

generate new6_5 = V6_5
replace new6_5 = . if (V6_5 == 5)
replace new6_5 = . if (V6_5 == 6)

*left ideology
generate left = 0
replace left = 1 if (V19 == 2)
replace left = 1 if (V19 == 3)
replace left = 1 if (V19 == 4)
replace left = 1 if (V19 == 5)

**right ideology with Islamist
generate right = 0
replace right = 1 if (V19 == 1)
replace right = 1 if (V19 == 6)
replace right = 1 if (V19 == 7)
replace right = 1 if (V19 == 8)
replace right = 1 if (V19 == 9)

**right ideology without Islamist
generate right2 = 0
replace right2 = 1 if (V19 == 6)
replace right2 = 1 if (V19 == 7)
replace right2 = 1 if (V19 == 8)
replace right2 = 1 if (V19 == 9)

**quran reading
generate quran = .
replace quran = 1 if (V10 == 1)
replace quran = 2 if (V10 == 2)
replace quran = 3 if (V10 == 3)
replace quran = 4 if (V10 == 4)
replace quran = 5 if (V10 == 5)
replace quran = 5 if (V10 == 6)
replace quran = 5 if (V10 == 7)

*quran reading with a narrower scale
generate quran2 = .
replace quran2 = 1 if (V10 == 1)
replace quran2 = 2 if (V10 == 2)
replace quran2 = 2 if (V10 == 3)
replace quran2 = 3 if (V10 == 4)
replace quran2 = 3 if (V10 == 5)
replace quran2 = 3 if (V10 == 6)
replace quran2 = 3 if (V10 == 7)

**experiment index variable
replace V20_1 = . if (V20_1 == 6)
replace V20_2 = . if (V20_2 == 6)
replace V20_3 = . if (V20_3 == 6)
replace V20_4 = . if (V20_4 == 6)
replace V20_5 = . if (V20_5 == 6)
replace V20_6 = . if (V20_6 == 6)
replace V20_7 = . if (V20_7 == 6)
replace V20_8 = . if (V20_8 == 6)
replace V20_9 = . if (V20_9 == 6)
replace V20_10 = . if (V20_10 == 6)

generate index = V20_1 + V20_2 + V20_3 + V20_4 + V20_5 + V20_6 + V20_7 + V20_8 + V20_9 + V20_10

factor V20_1 V20_2
alpha V20_1 V20_2 V20_3 V20_4 V20_5 V20_6 V20_7 V20_8 V20_9 V20_10, item

**index variable individual items scaled to 0-1
nscale V20_1, nopost
nscale V20_2, nopost
nscale V20_3, nopost
nscale V20_4, nopost
nscale V20_5, nopost
nscale V20_6, nopost
nscale V20_7, nopost
nscale V20_8, nopost
nscale V20_9, nopost
nscale V20_10, nopost

generate index2 = V20_1 + V20_2 + V20_3 + V20_4 + V20_5 + V20_6 + V20_7 + V20_8 + V20_9 + V20_10

**religious knowledge index

generate rel1 = 0
replace rel1 = 1 if (V1_1 == 1)

generate rel2 = 0
replace rel2 = 1 if (V1_2 == 1)

generate rel3 = 0
replace rel3 = 1 if (V1_3 == 0)

generate rel4 = 0
replace rel4 = 1 if (V1_4 == 0)

generate rel5 = 0
replace rel5 = 1 if (V1_5 == 1)

generate rel6 = 0
replace rel6 = 1 if (V2_1 == 1)

generate rel7 = 0
replace rel7 = 1 if (V2_2 == 1)

generate rel8 = 0
replace rel8 = 1 if (V2_3 == 0)

generate rel9 = 0
replace rel9 = 1 if (V2_4 == 1)

generate rel10 = 0
replace rel10 = 1 if (V2_5 == 0)

generate rel11 = 0
replace rel11 = 1 if (V2_6 == 0)

generate relknow = rel1 + rel2 + rel3 + rel4 + rel5 + rel6 + rel7 + rel8 + rel9 + rel10 + rel11

alpha rel1  rel2 rel3 rel4 rel5 rel6 rel7 rel8 rel9 rel10 rel11, item

**relknow alternative specification with a narrow scale
generate relknow2 = 0
replace relknow2 = 1 if (relknow == 7)
replace relknow2 = 2 if (relknow == 8)
replace relknow2 = 3 if (relknow == 9)
replace relknow2 = 4 if (relknow == 10)
replace relknow2 = 5 if (relknow == 11)

**relknow alternative specification with a narrower scale
generate relknow3 = 0
replace relknow3 = 1 if (relknow == 8)
replace relknow3 = 1 if (relknow == 9)
replace relknow3 = 2 if (relknow == 10)
replace relknow3 = 2 if (relknow == 11)

**CI plots

ciplot index if V521==1, by(islamist) name(islamist1,replace)
ciplot index if V521==2, by(islamist) name(islamist2,replace)
ciplot index if V521==3, by(islamist) name(islamist3,replace)
ciplot index if V521==4, by(islamist) name(islamist4,replace)
graph combine islamist1 islamist2 islamist3 islamist4

ciplot index2 if V521==1, by(islamist) name(islamist1,replace)
ciplot index2 if V521==2, by(islamist) name(islamist2,replace)
ciplot index2 if V521==3, by(islamist) name(islamist3,replace)
ciplot index2 if V521==4, by(islamist) name(islamist4,replace)
graph combine islamist1 islamist2 islamist3 islamist4

ciplot index if V521==1, by(islamist3) name(graph15,replace) title("prime 1")
ciplot index if V521==2, by(islamist3) name(graph16,replace) title("prime 2")
ciplot index if V521==3, by(islamist3) name(graph17,replace) title("prime 3")
ciplot index if V521==4, by(islamist3) name(graph18,replace) title("no prime")
graph combine graph15 graph16 graph17 graph18

ciplot index2 if V521==1, by(islamist3) name(graph15,replace) title("prime 1")
ciplot index2 if V521==2, by(islamist3) name(graph16,replace) title("prime 2")
ciplot index2 if V521==3, by(islamist3) name(graph17,replace) title("prime 3")
ciplot index2 if V521==4, by(islamist3) name(graph18,replace) title("no prime")
graph combine graph15 graph16 graph17 graph18

ciplot index if V521==1, by(left) name(left1,replace) title("prime 1")
ciplot index if V521==2, by(left) name(left2,replace) title("prime 2")
ciplot index if V521==3, by(left) name(left3,replace) title("prime 3")
ciplot index if V521==4, by(left) name(left4,replace) title("no prime")
graph combine left1 left2 left3 left4

ciplot index2 if V521==1, by(left) name(graph3,replace)
ciplot index2 if V521==2, by(left) name(graph4,replace)
ciplot index2 if V521==3, by(left) name(graph5,replace)
ciplot index2 if V521==4, by(left) name(graph6,replace)
graph combine graph3 graph4 graph5 graph6

ciplot index if V521==1, by(right) name(graph7,replace)
ciplot index if V521==2, by(right) name(graph8,replace)
ciplot index if V521==3, by(right) name(graph9,replace)
ciplot index if V521==4, by(right) name(graph10,replace)
graph combine graph7 graph8 graph9 graph10

ciplot index if V521==1, by(right2) name(graph11,replace)
ciplot index if V521==2, by(right2) name(graph12,replace)
ciplot index if V521==3, by(right2) name(graph13,replace)
ciplot index if V521==4, by(right2) name(graph14,replace)
graph combine graph11 graph12 graph13 graph14

ciplot index if V521==1, by(antiamerican) name(american1,replace)
ciplot index if V521==2, by(antiamerican) name(american2,replace)
ciplot index if V521==3, by(antiamerican) name(american3,replace)
ciplot index if V521==4, by(antiamerican) name(american4,replace)
graph combine american1 american2 american3 american4

ciplot index if V521==1, by(antiamerican2) name(american21,replace)
ciplot index if V521==2, by(antiamerican2) name(american22,replace)
ciplot index if V521==3, by(antiamerican2) name(american23,replace)
ciplot index if V521==4, by(antiamerican2) name(american24,replace)
graph combine american21 american22 american23 american24

ciplot index if V521==1, by(relknow) name(relknow1,replace)
ciplot index if V521==2, by(relknow) name(relknow2,replace)
ciplot index if V521==3, by(relknow) name(relknow3,replace)
ciplot index if V521==4, by(relknow) name(relknow4,replace)
graph combine relknow1 relknow2 relknow3 relknow4

ciplot index if V521==1, by(relknow2) name(relknow21,replace)
ciplot index if V521==2, by(relknow2) name(relknow22,replace)
ciplot index if V521==3, by(relknow2) name(relknow23,replace)
ciplot index if V521==4, by(relknow2) name(relknow24,replace)
graph combine relknow21 relknow22 relknow23 relknow24

ciplot index if V521==1, by(relknow3) name(relknow31,replace)
ciplot index if V521==2, by(relknow3) name(relknow32,replace)
ciplot index if V521==3, by(relknow3) name(relknow33,replace)
ciplot index if V521==4, by(relknow3) name(relknow34,replace)
graph combine relknow31 relknow32 relknow33 relknow34

ciplot index2 if V521==1, by(relknow3) name(relknow31,replace)
ciplot index2 if V521==2, by(relknow3) name(relknow32,replace)
ciplot index2 if V521==3, by(relknow3) name(relknow33,replace)
ciplot index2 if V521==4, by(relknow3) name(relknow34,replace)
graph combine relknow31 relknow32 relknow33 relknow34

ciplot index if V521==1, by(quran) name(quran1,replace)
ciplot index if V521==2, by(quran) name(quran2,replace)
ciplot index if V521==3, by(quran) name(quran3,replace)
ciplot index if V521==4, by(quran) name(quran4,replace)
graph combine quran1 quran2 quran3 quran4

ciplot index if V521==1, by(quran2) name(quran1,replace)
ciplot index if V521==2, by(quran2) name(quran2,replace)
ciplot index if V521==3, by(quran2) name(quran3,replace)
ciplot index if V521==4, by(quran2) name(quran4,replace)
graph combine quran1 quran2 quran3 quran4

ciplot index2 if V521==1, by(quran2) name(quran1,replace)
ciplot index2 if V521==2, by(quran2) name(quran2,replace)
ciplot index2 if V521==3, by(quran2) name(quran3,replace)
ciplot index2 if V521==4, by(quran2) name(quran4,replace)
graph combine quran1 quran2 quran3 quran4
