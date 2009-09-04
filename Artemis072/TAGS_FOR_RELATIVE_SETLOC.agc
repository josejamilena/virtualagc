### FILE="Main.annotation"
# Copyright:	Public domain.
# Filename:	ABSOLUTE_LOCATIONS_FOR_UPDATES.agc
# Purpose:	Part of the source code for Artemis (i.e., Colossus 3),
#		build 072.  This is for the Command Module's (CM) 
#		Apollo Guidance Computer (AGC), we believe for 
#		Apollo 15-17.
# Assembler:	yaYUL
# Contact:	Onno Hommes <ohommes@alumni.cmu.edu>
# Website:	www.ibiblio.org/apollo/index.html
# Page scans:	www.ibiblio.org/apollo/ScansForConversion/Artemis072/
# Mod history:	2009-07-29 OH	Adapted from corresponding Comanche 055 file.
# 		2009-09-04 JL	Fixed typo: COHTAGS should be CDHTAGS.
# 		2009-09-04 JL	Added missing LATLONG1 declaration in bank 16. Fix typos. Remove P23S and SXTMARK1.

## Page 27
# TAGS FOR RELATIVE SETLOC AND BLANK BANK CARDS

FIXED		MEMORY	120000 - 167777
		COUNT	BANKSUM

# MODULE 1 CONTAINS BANKS 0 THROUGH 5

		BLOCK	02
FFTAG1		EQUALS
FFTAG2		EQUALS
FFTAG3		EQUALS
FFTAG4		EQUALS
FFTAG7		EQUALS
FFTAG8		EQUALS
EXECF2		EQUALS
WAITF2		EQUALS
FFTAG10		EQUALS
FFTAG12		EQUALS
P30SUBS		EQUALS
STOPRAT		EQUALS
		BNKSUM	02
		
		BLOCK	03
INTERF3		EQUALS
FFTAG6		EQUALS
FFTAG13		EQUALS
		BNKSUM	03
		
		BANK	00
DLAYJOB		EQUALS
INTERB0		EQUALS
		BNKSUM	00
		
		BANK	01
RESTART		EQUALS
R02		EQUALS
		BNKSUM	01
		
		
INTERB1		EQUALS
EXECB1		EQUALS
		BANK	4
VERB37		EQUALS
P50S4		EQUALS
CSI/CDH1	EQUALS
INTPRET2	EQUALS

## Page 28
MIDDGIM		EQUALS
P31TAG		EQUALS
C13BANK		EQUALS			# C13STALL - CHANGE CODE IF THIS IS MOVED
P60S6		EQUALS
		BNKSUM	04
		
		BANK	5
FRANDRES	EQUALS
DOWNTELM	EQUALS
DAPMASS		EQUALS
CONICS4		EQUALS
CSITAG1		EQUALS
INTINIT3	EQUALS
		BNKSUM	05
		
# MODULE 2 CONTAINS BANKS 6 THROUGH 13

		BANK	6
IMUCOMP		EQUALS
T4RUP		EQUALS
CSIPROG		EQUALS
P60S7		EQUALS
		BNKSUM	06
	
		BANK	7
SXTMARKE	EQUALS
MODESW		EQUALS
KEYRUPT		EQUALS
CSIPROG6	EQUALS
RATEBNK		EQUALS
		BNKSUM	07
		
		BANK	10
DISPLAYS	EQUALS
PHASETAB	EQUALS
COMGEOM2	EQUALS
P60S4		EQUALS
OPTDRV		EQUALS
CSIPROG8	EQUALS
KALCMON3	EQUALS
CONICS5		EQUALS
		BNKSUM	10
		
		BANK	11
## Page 29
ORBITAL		EQUALS
ORBITAL1	EQUALS			# CONSTANTS
INTVEL		EQUALS
S52/2		EQUALS
CONICS3		EQUALS
INTINIT1	EQUALS
		BNKSUM	11
		
		BANK	12
CONICS		EQUALS
E/PROG		EQUALS
CSIPROG2	EQUALS
CSI/CDH2	EQUALS
N90TAG		EQUALS
		BNKSUM	12
		
		BANK	13
P76LOC		EQUALS
LATLONG		EQUALS
INTINIT		EQUALS
SR52/1		EQUALS
ORBITAL2	EQUALS
E/PROG1		EQUALS
P24PROG		EQUALS
		BNKSUM	13
		
# MODULE 3 CONTAINS BANKS 14 THROUGH 21

		BANK 	14
P50S		EQUALS
RT53		EQUALS
P50S1		EQUALS
		BNKSUM	14	

		BANK	15
STARTAB		EQUALS
ETRYDAP		EQUALS
CDHTAGS		EQUALS
CONICS1		EQUALS
		BNKSUM	15

## Page 30		
		BANK	16
P40S1		EQUALS
DAPROLL		EQUALS
P50S2		EQUALS
INTVEL1		EQUALS
RTE2		EQUALS
CSIPROG5	EQUALS
LATLONG1	EQUALS
		BNKSUM	16
		
		BANK	17
EXTVRBS1	EQUALS
DAPS4		EQUALS
DAPS5		EQUALS
DAPS7		EQUALS
P50S3		EQUALS
CONICS2		EQUALS
		BNKSUM	17
		
		BANK	20
DAPS6		EQUALS
DAPS1		EQUALS
DAPS2		EQUALS
MANUSTUF	EQUALS
VAC5LOC		EQUALS
P15LOC		EQUALS
P29TAG2		EQUALS
		BNKSUM	20
		
		BANK	21
DAPS3		EQUALS
MYSUBS		EQUALS
P11THREE	EQUALS
		BNKSUM	21

# MODULE 4 CONTAINS BANKS 22 THROUGH 27

		BANK	22
RTBCODES	EQUALS
DAPS8		EQUALS
APOPERI		EQUALS
KALCMON2	EQUALS
KALCMON1	EQUALS
## Page 31
CSIPROG3	EQUALS
P36TAG		EQUALS
		BNKSUM	22

		BANK	23
P20S2		EQUALS
INFLIGHT	EQUALS
COMGEOM1	EQUALS
POWFLITE	EQUALS
POWFLIT1	EQUALS
POWFLIT2	EQUALS
R30LOC		EQUALS
CSIPROG4	EQUALS
		BNKSUM	23
		
		BANK	24
RTBCODE1	EQUALS
P40S		EQUALS
CSIPROG7	EQUALS
R36CM		EQUALS
P20S5		EQUALS
		BNKSUM	24
		
		BANK	25
REENTRY		EQUALS
		BNKSUM	25
		
		BANK	26
INTPRET1	EQUALS
REENTRY1	EQUALS
P60S		EQUALS
P60S1		EQUALS
P60S2		EQUALS
P60S3		EQUALS
PLANTIN		EQUALS			# LUNAR ROT
EPHEM		EQUALS
P05P06		EQUALS
26P50S		EQUALS
P30S1A		EQUALS
P11FOUR		EQUALS
		BNKSUM	26

## Page 32		
		BANK	27
TOF-FF		EQUALS
MANUVER		EQUALS
MANUVER1	EQUALS
P40S5		EQUALS
VECPT		EQUALS
MGIM		EQUALS
UPDATE2		EQUALS
R22S1		EQUALS
P60S5		EQUALS
CDHTAG		EQUALS
JANESUB		EQUALS
		BNKSUM	27

# MODULE 5 CONTAINS BANKS 30 THROUGH 35

		BANK	30
LOWSUPER	EQUALS
P20S1		EQUALS
P20S6		EQUALS
P40S3		EQUALS
P29TAG1		EQUALS
		BNKSUM	30
		
		BANK	31
RT23		EQUALS
R34		EQUALS
CDHTAG2		EQUALS
CSIPROG9	EQUALS
R31		EQUALS
P22S		EQUALS
RTE3		EQUALS
MEASINC3	EQUALS
V89TAG		EQUALS
		BNKSUM	31
		
		BANK	32
P20S9		EQUALS
RTE		EQUALS
DELRSPL1	EQUALS
IMUCAL3		EQUALS
		BNKSUM	32

## Page 33		
		BANK	33
TESTLEAD	EQUALS
IMUCAL		EQUALS
P11TWO		EQUALS
P15LOC1		EQUALS
		BNKSUM	33
		
		BANK	34
P11ONE		EQUALS
P20S3		EQUALS
P20S4		EQUALS
TOF-FF1		EQUALS
		BNKSUM	34
		
		BANK	35
RTECON1		EQUALS
CSI/CDH		EQUALS
P30S1		EQUALS
P20S8		EQUALS
INTINIT2	EQUALS
		BNKSUM	35
		
# MODULE 6 CONTAINS BANKS 36 THROUGH 43

		BANK	36
MEASINC		EQUALS
MEASINC1	EQUALS
P15LOC2		EQUALS
P20S7		EQUALS
RTE1		EQUALS
S3435LOC	EQUALS
		BNKSUM	36
		
		BANK	37
P20S		EQUALS
BODYATT		EQUALS
RENDEZ		EQUALS
SERVICES	EQUALS
CDHTAG3		EQUALS
		BNKSUM	37

## Page 34		
		BANK	40
PINSUPER	EQUALS
PINBALL1	EQUALS
		BNKSUM	40
		
		BANK	41
PINBALL2	EQUALS
		BNKSUM	41
		
		BANK	42
SBAND		EQUALS	
PINBALL3	EQUALS
EXTVBS		EQUALS
UPDATE3		EQUALS
		BNKSUM	42
		
		BANK	43
SELFCHEC	EQUALS
EXTVERBS	EQUALS
		BNKSUM	43
		
HI6ZEROS	EQUALS	ZEROVECS		# ZERO VECTOR ALWAYS IN HIGH MEMORY
LO6ZEROS	EQUALS	ZEROVEC			# ZERO VECTOR ALWAYS IN LOW MEMORY
HIDPHALF	EQUALS	UNITX
LODPHALF	EQUALS	XUNIT
HIDP1/4		EQUALS	DP1/4TH	
LODP1/4		EQUALS	D1/4			# 2DEC .25
HIUNITX		EQUALS	UNITX
HIUNITY		EQUALS	UNITY
HIUNITZ		EQUALS	UNITZ
LOUNITX		EQUALS	XUNIT			# 2DEC .5
LOUNITY		EQUALS	YUNIT			# 2DEC 0
LOUNITZ		EQUALS	ZUNIT			# 2DEC 0
3/4LOWDP	EQUALS	3/4			# 2DEC 3.0 B-2
		SBANK=	LOWSUPER

# ROPE-SPECIFIC ASSIGNS OBVIATING NEED TO CHECK COMPUTER FLAG IN DETVRUZVING INTEGRATION AREA ENTRIES
OTHPREC		EQUALS	LEMPREC
ATOPOTH		EQUALS	ATOPLEM
ATOPTHIS	EQUALS	ATOPCSM
MOONTHIS	EQUALS	CMOONFLG

## Page 35

MOONOTH		EQUALS	LMOONFLG
MOVATHIS	EQUALS	MOVEACSM
STATEST		EQUALS	V83CALL			# * TEMPORARY
THISPREC	EQUALS	CSMPREC
THISAXIS	=	UNITX
ERASID		EQUALS	LOW10			# DOWNLINK ERASABLE DUMP ID
DELAYNUM	EQUALS	THREE

# **************************************************************************************************************
