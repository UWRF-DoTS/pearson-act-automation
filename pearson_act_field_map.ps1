<#
.SYNOPSIS
    Mappings of fixed space values to their positions and columns
.NOTES
    Full Name: ACTFields.ps1
    Author: Shane O'Malley-Potting - shane.omalley-potting@uwrf.edu
    Values may need to be updated annually
#>

$fixed_space_values = @(
    @{"column" = "Reporting Year"; "start"= 0; "length" = 2},
    @{"column" = "Student Last Name"; "start"= 2; "length" = 25},
    @{"column" = "Student First Name"; "start"= 27; "length" = 16},
    @{"column" = "Student Middle Name"; "start"= 43; "length" = 1},
    @{"column" = "Street Address"; "start"= 44; "length" = 40},
    @{"column" = "Country Code"; "start"= 84; "length" = 2},
    @{"column" = "Gender Numeric"; "start"= 86; "length" = 1},
    @{"column" = "Gender Alpha"; "start"= 87; "length" = 1},
    @{"column" = "Grade Level"; "start"= 88; "length" = 2},
    @{"column" = "ACT Id"; "start"= 90; "length" = 9},
    @{"column" = "Telephone Type"; "start"= 99; "length" = 1},
    @{"column" = "Date of Birth"; "start"= 100; "length" = 6},
    @{"column" = "Telephone 1"; "start"= 106; "length" = 10},
    @{"column" = "City"; "start"= 116; "length" = 25},
    @{"column" = "State Numeric"; "start"= 141; "length" = 2},
    @{"column" = "State Alpha"; "start"= 143; "length" = 2},
    @{"column" = "Zip4"; "start"= 145; "length" = 9},
    @{"column" = "Extended Date of Birth"; "start"= 154; "length" = 8},
    @{"column" = "ACT Before 09/2015 Combined English and Writing"; "start"= 162; "length" = 2},
    @{"column" = "ACT Before 09/2015 Writing"; "start"= 164; "length" = 2},
    @{"column" = "ACT Before 09/2015 Combined English and Writing Nat Norms"; "start"= 166; "length" = 2},
    @{"column" = "ACT Before 09/2015 Writing Nat Norms"; "start"= 168; "length" = 2},
    @{"column" = "ACT Before 09/2015 Essay Comment 1"; "start"= 170; "length" = 2},
    @{"column" = "ACT Before 09/2015 Essay Comment 2"; "start"= 172; "length" = 2},
    @{"column" = "ACT Before 09/2015 Essay Comment 3"; "start"= 174; "length" = 2},
    @{"column" = "ACT Before 09/2015 Essay Comment 4"; "start"= 176; "length" = 2},
    @{"column" = "Blank 3"; "start"= 178; "length" = 2},
    @{"column" = "ACT Before 10/89 English"; "start"= 180; "length" = 2},
    @{"column" = "ACT Before 10/89 Math"; "start"= 182; "length" = 2},
    @{"column" = "ACT Before 10/89 Social Studies"; "start"= 184; "length" = 2},
    @{"column" = "ACT Before 10/89 Sciences"; "start"= 186; "length" = 2},
    @{"column" = "ACT Before 10/89 Composite"; "start"= 188; "length" = 2},
    @{"column" = "Blank 4"; "start"= 190; "length" = 1},
    @{"column" = "State Assigned Student ID Number"; "start"= 191; "length" = 13},
    @{"column" = "CEEB Code"; "start"= 204; "length" = 6},
    @{"column" = "High School Grade English"; "start"= 210; "length" = 2},
    @{"column" = "High School Grade Math"; "start"= 212; "length" = 2},
    @{"column" = "High School Grade Social Studies"; "start"= 214; "length" = 2},
    @{"column" = "High School Grade Sciences"; "start"= 216; "length" = 2},
    @{"column" = "Blank 6"; "start"= 218; "length" = 1},
    @{"column" = "High School GPA"; "start"= 219; "length" = 3},
    @{"column" = "Graduation Year"; "start"= 222; "length" = 4},
    @{"column" = "Expandeded ACT Test Date"; "start"= 226; "length" = 6},
    @{"column" = "ACT Test Date"; "start"= 232; "length" = 4},
    @{"column" = "ACT Test Location"; "start"= 248; "length" = 1},
    @{"column" = "Province"; "start"= 249; "length" = 2},
    @{"column" = "Blank 7"; "start"= 251; "length" = 1},
    @{"column" = "Canadian Postal Code"; "start"= 252; "length" = 7},
    @{"column" = "Corr. Report"; "start"= 259; "length" = 1},
    @{"column" = "ACT Scale Score English"; "start"= 260; "length" = 2},
    @{"column" = "ACT Scale Score Math"; "start"= 262; "length" = 2},
    @{"column" = "ACT Scale Score Reading"; "start"= 264; "length" = 2},
    @{"column" = "ACT Scale Score Science"; "start"= 266; "length" = 2},
    @{"column" = "ACT Scale Score Composite"; "start"= 268; "length" = 2},
    @{"column" = "Blank 8"; "start"= 270; "length" = 1},
    @{"column" = "ACT Scale Score Sum"; "start"= 271; "length" = 3},
    @{"column" = "Blank 9"; "start"= 274; "length" = 4},
    @{"column" = "ACT Interest Science"; "start"= 278; "length" = 2},
    @{"column" = "ACT Interest Science Standard"; "start"= 280; "length" = 2},
    @{"column" = "ACT Interest Arts"; "start"= 282; "length" = 2},
    @{"column" = "ACT Interest Arts Standard"; "start"= 284; "length" = 2},
    @{"column" = "ACT Interest Social Service"; "start"= 286; "length" = 2},
    @{"column" = "ACT Interest Social Service Standard"; "start"= 288; "length" = 2},
    @{"column" = "ACT Interest Business Contact"; "start"= 290; "length" = 2},
    @{"column" = "ACT Interest Business Contact Standard"; "start"= 292; "length" = 2},
    @{"column" = "ACT Interest Business Ops"; "start"= 294; "length" = 2},
    @{"column" = "ACT Interest Business Ops Standard"; "start"= 296; "length" = 2},
    @{"column" = "ACT Interest Technical"; "start"= 298; "length" = 2},
    @{"column" = "ACT Interest Technical Standard"; "start"= 300; "length" = 2},
    @{"column" = "ACT Map Region 1"; "start"= 302; "length" = 2},
    @{"column" = "ACT Map Region 2"; "start"= 304; "length" = 2},
    @{"column" = "ACT Map Region 3"; "start"= 306; "length" = 2},
    @{"column" = "Blank 10"; "start"= 308; "length" = 2},
    @{"column" = "ACT College Choice Number"; "start"= 310; "length" = 1},
    @{"column" = "Blank 11"; "start"= 311; "length" = 4},
    @{"column" = "ACT College Choice Code"; "start"= 315; "length" = 4},
    @{"column" = "ACT Scale Subscore Usage"; "start"= 319; "length" = 2},
    @{"column" = "ACT Scale Subscore Rhetorical"; "start"= 321; "length" = 2},
    @{"column" = "ACT Scale Subscore Algebra"; "start"= 323; "length" = 2},
    @{"column" = "ACT Scale Subscore Geometry"; "start"= 325; "length" = 2},
    @{"column" = "ACT Scale Subscore Trigonometry"; "start"= 327; "length" = 2},
    @{"column" = "ACT Scale Subscore Social Studies"; "start"= 329; "length" = 2},
    @{"column" = "ACT Scale Subscore Arts"; "start"= 331; "length" = 2},
    @{"column" = "ACT Scale Subscore Percentile Usage"; "start"= 333; "length" = 2},
    @{"column" = "ACT Scale Subscore Percentile Rhetorical"; "start"= 335; "length" = 2},
    @{"column" = "ACT Scale Subscore Percentile Algebra"; "start"= 337; "length" = 2},
    @{"column" = "ACT Scale Subscore Percentile Geometry"; "start"= 339; "length" = 2},
    @{"column" = "ACT Scale Subscore Percentile Trigonometry"; "start"= 341; "length" = 2},
    @{"column" = "ACT Scale Subscore Percentile Social Studies"; "start"= 343; "length" = 2},
    @{"column" = "ACT Scale Subscore Percentile Arts"; "start"= 345; "length" = 2},
    @{"column" = "ACT Scale Subscore Local Norms Usage"; "start"= 347; "length" = 2},
    @{"column" = "ACT Scale Subscore Local Norms Rhetorical"; "start"= 349; "length" = 2},
    @{"column" = "ACT Scale Subscore Local Norms Algebra"; "start"= 351; "length" = 2},
    @{"column" = "ACT Scale Subscore Local Norms Geomertry"; "start"= 353; "length" = 2},
    @{"column" = "ACT Scale Subscore Local Norms Trig"; "start"= 355; "length" = 2},
    @{"column" = "ACT Scale Subscore Local Norms Social Service"; "start"= 357; "length" = 2},
    @{"column" = "ACT Scale Subscore Local Norms Arts"; "start"= 359; "length" = 2},
    @{"column" = "Blank 12"; "start"= 361; "length" = 7},
    @{"column" = "ACT Interest Science Percentile"; "start"= 368; "length" = 2},
    @{"column" = "ACT Interest Arts Percentile"; "start"= 370; "length" = 2},
    @{"column" = "ACT Interest Social Service Percentile"; "start"= 372; "length" = 2},
    @{"column" = "ACT Interest Business Contact Percentile"; "start"= 374; "length" = 2},
    @{"column" = "ACT Interest Business Ops Percentile"; "start"= 376; "length" = 2},
    @{"column" = "ACT Interest Technical Percentile"; "start"= 378; "length" = 2},
    @{"column" = "ACT Local ID Number"; "start"= 380; "length" = 8},
    @{"column" = "Mobility Index"; "start"= 390; "length" = 2},
    @{"column" = "Institution Type Index"; "start"= 392; "length" = 2},
    @{"column" = "Selectivity Index"; "start"= 394; "length" = 2},
    @{"column" = "Institution Size Index"; "start"= 396; "length" = 2},
    @{"column" = "Interest-Major Fit Score"; "start"= 398; "length" = 2},
    @{"column" = "SPS 1"; "start"= 400; "length" = 1},
    @{"column" = "SPS 2"; "start"= 401; "length" = 1},
    @{"column" = "SPS 3"; "start"= 402; "length" = 1},
    @{"column" = "SPS 4"; "start"= 403; "length" = 1},
    @{"column" = "SPS 5"; "start"= 404; "length" = 1},
    @{"column" = "SPS 6"; "start"= 405; "length" = 1},
    @{"column" = "SPS 7"; "start"= 406; "length" = 1},
    @{"column" = "SPS 8"; "start"= 407; "length" = 1},
    @{"column" = "SPS 9"; "start"= 408; "length" = 1},
    @{"column" = "SPS 10"; "start"= 409; "length" = 1},
    @{"column" = "SPS 11"; "start"= 410; "length" = 3},
    @{"column" = "SPS 12"; "start"= 413; "length" = 3},
    @{"column" = "SPS 13"; "start"= 416; "length" = 3},
    @{"column" = "SPS 14"; "start"= 419; "length" = 1},
    @{"column" = "SPS 15"; "start"= 420; "length" = 1},
    @{"column" = "SPS 16"; "start"= 421; "length" = 1},
    @{"column" = "SPS 17"; "start"= 422; "length" = 1},
    @{"column" = "SPS 18"; "start"= 423; "length" = 1},
    @{"column" = "SPS 19"; "start"= 424; "length" = 1},
    @{"column" = "SPS 20"; "start"= 425; "length" = 1},
    @{"column" = "SPS 21"; "start"= 426; "length" = 1},
    @{"column" = "SPS 22"; "start"= 427; "length" = 1},
    @{"column" = "SPS 23"; "start"= 428; "length" = 1},
    @{"column" = "SPS 24"; "start"= 429; "length" = 1},
    @{"column" = "SPS 25"; "start"= 430; "length" = 1},
    @{"column" = "SPS 26"; "start"= 431; "length" = 1},
    @{"column" = "SPS 27"; "start"= 432; "length" = 1},
    @{"column" = "SPS 28"; "start"= 433; "length" = 1},
    @{"column" = "SPS 29"; "start"= 434; "length" = 1},
    @{"column" = "SPS 30"; "start"= 435; "length" = 1},
    @{"column" = "SPS 31"; "start"= 436; "length" = 1},
    @{"column" = "SPS 32"; "start"= 437; "length" = 1},
    @{"column" = "SPS 33"; "start"= 438; "length" = 1},
    @{"column" = "SPS 34"; "start"= 439; "length" = 1},
    @{"column" = "SPS 35"; "start"= 440; "length" = 1},
    @{"column" = "SPS 36"; "start"= 441; "length" = 1},
    @{"column" = "SPS 37"; "start"= 442; "length" = 1},
    @{"column" = "SPS 38"; "start"= 443; "length" = 1},
    @{"column" = "SPS 39"; "start"= 444; "length" = 1},
    @{"column" = "SPS 40"; "start"= 445; "length" = 1},
    @{"column" = "SPS 41"; "start"= 446; "length" = 1},
    @{"column" = "SPS 42"; "start"= 447; "length" = 1},
    @{"column" = "SPS 43"; "start"= 448; "length" = 1},
    @{"column" = "SPS 44"; "start"= 449; "length" = 1},
    @{"column" = "SPS 45"; "start"= 450; "length" = 1},
    @{"column" = "SPS 46"; "start"= 451; "length" = 1},
    @{"column" = "SPS 47"; "start"= 452; "length" = 1},
    @{"column" = "SPS 48"; "start"= 453; "length" = 1},
    @{"column" = "SPS 49"; "start"= 454; "length" = 1},
    @{"column" = "SPS 50"; "start"= 455; "length" = 1},
    @{"column" = "SPS 51"; "start"= 456; "length" = 1},
    @{"column" = "SPS 52"; "start"= 457; "length" = 1},
    @{"column" = "SPS 53"; "start"= 458; "length" = 1},
    @{"column" = "SPS 54"; "start"= 459; "length" = 1},
    @{"column" = "SPS 55"; "start"= 460; "length" = 1},
    @{"column" = "SPS 56"; "start"= 461; "length" = 1},
    @{"column" = "SPS 57"; "start"= 462; "length" = 1},
    @{"column" = "SPS 58"; "start"= 463; "length" = 1},
    @{"column" = "SPS 59"; "start"= 464; "length" = 1},
    @{"column" = "SPS 60"; "start"= 465; "length" = 1},
    @{"column" = "SPS 61"; "start"= 466; "length" = 1},
    @{"column" = "SPS 62"; "start"= 467; "length" = 1},
    @{"column" = "SPS 63"; "start"= 468; "length" = 1},
    @{"column" = "SPS 64"; "start"= 469; "length" = 1},
    @{"column" = "SPS 65"; "start"= 470; "length" = 1},
    @{"column" = "SPS 66"; "start"= 471; "length" = 1},
    @{"column" = "SPS 67"; "start"= 472; "length" = 1},
    @{"column" = "SPS 68.1"; "start"= 473; "length" = 2},
    @{"column" = "SPS 68.2"; "start"= 475; "length" = 2},
    @{"column" = "SPS 68.3"; "start"= 477; "length" = 2},
    @{"column" = "SPS 68.4"; "start"= 479; "length" = 2},
    @{"column" = "SPS 68.5"; "start"= 481; "length" = 2},
    @{"column" = "SPS 69"; "start"= 483; "length" = 1},
    @{"column" = "SPS 70"; "start"= 484; "length" = 1},
    @{"column" = "SPS 71"; "start"= 485; "length" = 1},
    @{"column" = "SPS 72"; "start"= 486; "length" = 1},
    @{"column" = "SPS 73"; "start"= 487; "length" = 1},
    @{"column" = "SPS 74"; "start"= 488; "length" = 1},
    @{"column" = "SPS 75"; "start"= 489; "length" = 1},
    @{"column" = "SPS 76"; "start"= 490; "length" = 1},
    @{"column" = "SPS 77"; "start"= 491; "length" = 1},
    @{"column" = "SPS 78"; "start"= 492; "length" = 1},
    @{"column" = "SPS 79"; "start"= 493; "length" = 1},
    @{"column" = "SPS 80"; "start"= 494; "length" = 1},
    @{"column" = "SPS 81"; "start"= 495; "length" = 1},
    @{"column" = "SPS 82"; "start"= 496; "length" = 1},
    @{"column" = "SPS 83"; "start"= 497; "length" = 1},
    @{"column" = "SPS 84"; "start"= 498; "length" = 1},
    @{"column" = "SPS 85"; "start"= 499; "length" = 1},
    @{"column" = "SPS 86"; "start"= 500; "length" = 1},
    @{"column" = "SPS 87"; "start"= 501; "length" = 1},
    @{"column" = "SPS 88"; "start"= 502; "length" = 1},
    @{"column" = "SPS 89"; "start"= 503; "length" = 1},
    @{"column" = "SPS 90"; "start"= 504; "length" = 1},
    @{"column" = "SPS 91"; "start"= 505; "length" = 1},
    @{"column" = "SPS 92"; "start"= 506; "length" = 1},
    @{"column" = "SPS 93"; "start"= 507; "length" = 1},
    @{"column" = "SPS 94"; "start"= 508; "length" = 1},
    @{"column" = "SPS 95"; "start"= 509; "length" = 1},
    @{"column" = "SPS 96"; "start"= 510; "length" = 1},
    @{"column" = "SPS 97"; "start"= 511; "length" = 1},
    @{"column" = "SPS 98"; "start"= 512; "length" = 1},
    @{"column" = "SPS 99"; "start"= 513; "length" = 1},
    @{"column" = "SPS 100"; "start"= 514; "length" = 1},
    @{"column" = "SPS 101"; "start"= 515; "length" = 1},
    @{"column" = "SPS 102"; "start"= 516; "length" = 1},
    @{"column" = "SPS 103"; "start"= 517; "length" = 1},
    @{"column" = "SPS 104"; "start"= 518; "length" = 1},
    @{"column" = "SPS 105"; "start"= 519; "length" = 1},
    @{"column" = "SPS 106"; "start"= 520; "length" = 1},
    @{"column" = "SPS 107"; "start"= 521; "length" = 1},
    @{"column" = "SPS 108"; "start"= 522; "length" = 1},
    @{"column" = "SPS 109"; "start"= 523; "length" = 1},
    @{"column" = "SPS 110"; "start"= 524; "length" = 1},
    @{"column" = "SPS 111"; "start"= 525; "length" = 1},
    @{"column" = "SPS 112"; "start"= 526; "length" = 1},
    @{"column" = "SPS 113"; "start"= 527; "length" = 1},
    @{"column" = "SPS 114"; "start"= 528; "length" = 1},
    @{"column" = "SPS 115"; "start"= 529; "length" = 1},
    @{"column" = "SPS 116"; "start"= 530; "length" = 1},
    @{"column" = "SPS 117"; "start"= 531; "length" = 1},
    @{"column" = "SPS 118"; "start"= 532; "length" = 1},
    @{"column" = "SPS 119"; "start"= 533; "length" = 1},
    @{"column" = "SPS 120"; "start"= 534; "length" = 1},
    @{"column" = "SPS 121"; "start"= 535; "length" = 1},
    @{"column" = "SPS 122"; "start"= 536; "length" = 1},
    @{"column" = "SPS 123"; "start"= 537; "length" = 1},
    @{"column" = "SPS 124"; "start"= 538; "length" = 1},
    @{"column" = "SPS 125"; "start"= 539; "length" = 1},
    @{"column" = "SPS 126"; "start"= 540; "length" = 1},
    @{"column" = "SPS 127"; "start"= 541; "length" = 1},
    @{"column" = "SPS 128"; "start"= 542; "length" = 1},
    @{"column" = "SPS 129"; "start"= 543; "length" = 1},
    @{"column" = "SPS 130"; "start"= 544; "length" = 1},
    @{"column" = "SPS 131"; "start"= 545; "length" = 1},
    @{"column" = "SPS 132"; "start"= 546; "length" = 1},
    @{"column" = "SPS 133"; "start"= 547; "length" = 1},
    @{"column" = "SPS 134"; "start"= 548; "length" = 1},
    @{"column" = "SPS 135"; "start"= 549; "length" = 1},
    @{"column" = "Student E-mail Address"; "start"= 550; "length" = 50},
    @{"column" = "Blank 14"; "start"= 600; "length" = 4},
    @{"column" = "ACT EOS Released"; "start"= 604; "length" = 1},
    @{"column" = "Religious Affiliation"; "start"= 605; "length" = 2},
    @{"column" = "HISP/LAT"; "start"= 607; "length" = 1},
    @{"column" = "AM IND/AK NAT"; "start"= 608; "length" = 1},
    @{"column" = "ASIAN"; "start"= 609; "length" = 1},
    @{"column" = "CLK/AFR AMER"; "start"= 610; "length" = 1},
    @{"column" = "HAW/PAC"; "start"= 611; "length" = 1},
    @{"column" = "WHITE"; "start"= 612; "length" = 1},
    @{"column" = "PNTR"; "start"= 613; "length" = 1},
    @{"column" = "MULTICRACIAL"; "start"= 614; "length" = 1},
    @{"column" = "Blank 15"; "start"= 615; "length" = 15},
    @{"column" = "ACT HS Taken English 9"; "start"= 630; "length" = 1},
    @{"column" = "ACT HS Taken English 10"; "start"= 631; "length" = 1},
    @{"column" = "ACT HS Taken English 11"; "start"= 632; "length" = 1},
    @{"column" = "ACT HS Taken English 12"; "start"= 633; "length" = 1},
    @{"column" = "ACT HS Taken Other English"; "start"= 634; "length" = 1},
    @{"column" = "ACT HS Taken Algebra 1"; "start"= 635; "length" = 1},
    @{"column" = "ACT HS Taken Algebra 2"; "start"= 636; "length" = 1},
    @{"column" = "ACT HS Taken Geometry"; "start"= 637; "length" = 1},
    @{"column" = "ACT HS Taken Trig"; "start"= 638; "length" = 1},
    @{"column" = "ACT HS Taken Calculus"; "start"= 639; "length" = 1},
    @{"column" = "ACT HS Taken Other Math"; "start"= 640; "length" = 1},
    @{"column" = "ACT HS Taken Computers"; "start"= 641; "length" = 1},
    @{"column" = "ACT HS Taken Gen. science"; "start"= 642; "length" = 1},
    @{"column" = "ACT HS Taken Biology"; "start"= 643; "length" = 1},
    @{"column" = "ACT HS Taken Chemistry"; "start"= 644; "length" = 1},
    @{"column" = "ACT HS Taken Physics"; "start"= 645; "length" = 1},
    @{"column" = "ACT HS Taken US History"; "start"= 646; "length" = 1},
    @{"column" = "ACT HS Taken World History"; "start"= 647; "length" = 1},
    @{"column" = "ACT HS Taken Other History"; "start"= 648; "length" = 1},
    @{"column" = "ACT HS Taken Government"; "start"= 649; "length" = 1},
    @{"column" = "ACT HS Taken Economics"; "start"= 650; "length" = 1},
    @{"column" = "ACT HS Taken Geography"; "start"= 651; "length" = 1},
    @{"column" = "ACT HS Taken Psych"; "start"= 652; "length" = 1},
    @{"column" = "ACT HS Taken Spanish"; "start"= 653; "length" = 1},
    @{"column" = "ACT HS Taken French"; "start"= 654; "length" = 1},
    @{"column" = "ACT HS Taken German"; "start"= 655; "length" = 1},
    @{"column" = "ACT HS Taken Other Lang."; "start"= 656; "length" = 1},
    @{"column" = "ACT HS Taken Art"; "start"= 657; "length" = 1},
    @{"column" = "ACT HS Taken Music"; "start"= 658; "length" = 1},
    @{"column" = "ACT HS Taken Drama"; "start"= 659; "length" = 1},
    @{"column" = "ACT HS Grades English 9"; "start"= 660; "length" = 1},
    @{"column" = "ACT HS Grades English 10"; "start"= 661; "length" = 1},
    @{"column" = "ACT HS Grades English 11"; "start"= 662; "length" = 1},
    @{"column" = "ACT HS Grades English 12"; "start"= 663; "length" = 1},
    @{"column" = "ACT HS Grades Other English"; "start"= 664; "length" = 1},
    @{"column" = "ACT HS Grades Algebra 1"; "start"= 665; "length" = 1},
    @{"column" = "ACT HS Grades Algebra 2"; "start"= 666; "length" = 1},
    @{"column" = "ACT HS Grades Geometry"; "start"= 667; "length" = 1},
    @{"column" = "ACT HS Grades Trig"; "start"= 668; "length" = 1},
    @{"column" = "ACT HS Grades Calculus"; "start"= 669; "length" = 1},
    @{"column" = "ACT HS Grades Other Math"; "start"= 670; "length" = 1},
    @{"column" = "ACT HS Grades Computers"; "start"= 671; "length" = 1},
    @{"column" = "ACT HS Grades Gen. science"; "start"= 672; "length" = 1},
    @{"column" = "ACT HS Grades Biology"; "start"= 673; "length" = 1},
    @{"column" = "ACT HS Grades Chemistry"; "start"= 674; "length" = 1},
    @{"column" = "ACT HS Grades Physics"; "start"= 675; "length" = 1},
    @{"column" = "ACT HS Grades US History"; "start"= 676; "length" = 1},
    @{"column" = "ACT HS Grades World History"; "start"= 677; "length" = 1},
    @{"column" = "ACT HS Grades Other History"; "start"= 678; "length" = 1},
    @{"column" = "ACT HS Grades Government"; "start"= 679; "length" = 1},
    @{"column" = "ACT HS Grades Economics"; "start"= 680; "length" = 1},
    @{"column" = "ACT HS Grades Geography"; "start"= 681; "length" = 1},
    @{"column" = "ACT HS Grades Psych"; "start"= 682; "length" = 1},
    @{"column" = "ACT HS Grades Spanish"; "start"= 683; "length" = 1},
    @{"column" = "ACT HS Grades French"; "start"= 684; "length" = 1},
    @{"column" = "ACT HS Grades German"; "start"= 685; "length" = 1},
    @{"column" = "ACT HS Grades Other Lang."; "start"= 686; "length" = 1},
    @{"column" = "ACT HS Grades Art"; "start"= 687; "length" = 1},
    @{"column" = "ACT HS Grades Music"; "start"= 688; "length" = 1},
    @{"column" = "ACT HS Grades Drama"; "start"= 689; "length" = 1},
    @{"column" = " State-Assigned Student ID Number"; "start"= 690; "length" = 10},
    @{"column" = "ACT Predictive Percentile English"; "start"= 700; "length" = 2},
    @{"column" = "ACT Predictive Percentile Math"; "start"= 702; "length" = 2},
    @{"column" = "ACT Predictive Percentile Reading"; "start"= 704; "length" = 2},
    @{"column" = "ACT Predictive Percentile Science"; "start"= 706; "length" = 2},
    @{"column" = "ACT Predictive Percentile Composite"; "start"= 708; "length" = 2},
    @{"column" = "ACT Predictive Overall 1"; "start"= 710; "length" = 2},
    @{"column" = "ACT Predictive Overall 2"; "start"= 712; "length" = 2},
    @{"column" = "ACT Predictive Overall 3"; "start"= 714; "length" = 2},
    @{"column" = "ACT Predictive Overall 4"; "start"= 716; "length" = 2},
    @{"column" = "ACT Predictive Overall 5"; "start"= 718; "length" = 2},
    @{"column" = "ACT Predictive Specific 1"; "start"= 720; "length" = 2},
    @{"column" = "ACT Predictive Specific 2"; "start"= 722; "length" = 2},
    @{"column" = "ACT Predictive Specific 3"; "start"= 724; "length" = 2},
    @{"column" = "ACT Predictive Specific 4"; "start"= 726; "length" = 2},
    @{"column" = "ACT Predictive Specific 5"; "start"= 728; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Overall 1"; "start"= 730; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Overall 2"; "start"= 732; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Overall 3"; "start"= 734; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Overall 4"; "start"= 736; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Overall 5"; "start"= 738; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Specific 1"; "start"= 740; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Specific 2"; "start"= 742; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Specific 3"; "start"= 744; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Specific 4"; "start"= 746; "length" = 2},
    @{"column" = "ACT Predictive C or Higer Specific 5"; "start"= 748; "length" = 2},
    @{"column" = "ACT Predictive GPA Overall 1"; "start"= 750; "length" = 2},
    @{"column" = "ACT Predictive GPA Overall 2"; "start"= 752; "length" = 2},
    @{"column" = "ACT Predictive GPA Overall 3"; "start"= 754; "length" = 2},
    @{"column" = "ACT Predictive GPA Overall 4"; "start"= 756; "length" = 2},
    @{"column" = "ACT Predictive GPA Overall 5"; "start"= 758; "length" = 2},
    @{"column" = "ACT Predictive GPA Specific 1"; "start"= 760; "length" = 2},
    @{"column" = "ACT Predictive GPA Specific 2"; "start"= 762; "length" = 2},
    @{"column" = "ACT Predictive GPA Specific 3"; "start"= 764; "length" = 2},
    @{"column" = "ACT Predictive GPA Specific 4"; "start"= 766; "length" = 2},
    @{"column" = "ACT Predictive GPA Specific 5"; "start"= 768; "length" = 2},
    @{"column" = "Blank 17"; "start"= 770; "length" = 2},
    @{"column" = "ACT Scale Score English Percent"; "start"= 772; "length" = 2},
    @{"column" = "ACT Scale Score Math Percent"; "start"= 774; "length" = 2},
    @{"column" = "ACT Scale Score Reading Percent"; "start"= 776; "length" = 2},
    @{"column" = "ACT Scale Score Science Percent"; "start"= 778; "length" = 2},
    @{"column" = "ACT Scale Score Composite Percent"; "start"= 780; "length" = 2},
    @{"column" = "Norm Types"; "start"= 782; "length" = 1},
    @{"column" = "Blank 18"; "start"= 783; "length" = 7},
    @{"column" = "Writing Subject Score"; "start"= 790; "length" = 2},
    @{"column" = "Blank19"; "start"= 792; "length" = 3},
    @{"column" = "Ideas and Analysis"; "start"= 795; "length" = 2},
    @{"column" = "Development and Support"; "start"= 797; "length" = 2},
    @{"column" = " Organization"; "start"= 799; "length" = 2},
    @{"column" = "Lang Use and Conversations"; "start"= 801; "length" = 2},
    @{"column" = "Writing National Norms"; "start"= 803; "length" = 2},
    @{"column" = "Eng Lang Arts Score"; "start"= 805; "length" = 2},
    @{"column" = "ELA Nat Norm Percentage"; "start"= 807; "length" = 2},
    @{"column" = "Blank20"; "start"= 809; "length" = 3},
    @{"column" = "STEM Score"; "start"= 812; "length" = 2},
    @{"column" = "STEM Nat Norms Percentage"; "start"= 814; "length" = 2},
    @{"column" = "Blank21"; "start"= 816; "length" = 3},
    @{"column" = "Understanding Complex Test Score"; "start"= 819; "length" = 1},
    @{"column" = "Progress Toward Career Readiness Indicator"; "start"= 820; "length" = 1}
);


