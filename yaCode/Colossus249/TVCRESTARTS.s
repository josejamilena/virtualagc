# Copyright:	Public domain.
# Filename:	TVCRESTARTS.s
# Purpose:	Part of the source code for Colossus, build 249.
#		It is part of the source code for the Command Module's (CM)
#		Apollo Guidance Computer (AGC), possibly for Apollo 8 and 9.
# Assembler:	yaYUL
# Reference:	Starts on p. 920 of 1701.pdf.
# Contact:	Ron Burkey <info@sandroid.org>.
# Website:	www.ibiblio.org/apollo/index.html
# Mod history:	08/23/04 RSB.	Began transcribing.
#		05/14/05 RSB	Corrected website reference above.
#
# The contents of the "Colossus249" files, in general, are transcribed 
# from a scanned document obtained from MIT's website,
# http://hrst.mit.edu/hrs/apollo/public/archive/1701.pdf.  Notations on this
# document read, in part:
#
#	Assemble revision 249 of AGC program Colossus by NASA
#	2021111-041.  October 28, 1968.  
#
#	This AGC program shall also be referred to as
#				Colossus 1A
#
#	Prepared by
#			Massachussets Institute of Technology
#			75 Cambridge Parkway
#			Cambridge, Massachusetts
#	under NASA contract NAS 9-4065.
#
# Refer directly to the online document mentioned above for further information.
# Please report any errors (relative to 1701.pdf) to info@sandroid.org.
#
# In some cases, where the source code for Luminary 131 overlaps that of 
# Colossus 249, this code is instead copied from the corresponding Luminary 131
# source file, and then is proofed to incorporate any changes.

# Page 920
# NAME....TVCRESTART PACKAGE, CONSISTING OF REDOTVC, ENABL1, 2, CMDSOUT, PHSCHK2, ETC.
# LOG SECTION....TVCRESTART PACKAGE		SUBROUTINE....DAPCSM
# MOD BY ENGEL					DATE....19 OCT, 1967
#
# FUNCTIONAL DESCRIPTION....
#
#      *RESTART-PROCESS THE TVC DAPS, INCLUDING PITCHDAP, YAWDAP,
#	TVCEXECUTIVE, (?) DAP, TVCINIT4, TVCDAPON, AND STROKE TEST.
#
#      *TVC RESTARTS DESERVE SPECIAL CONSIDERATION IN SEVERAL AREAS.
#	RESTART DOWN-TIME IS IMPORTANT BECAUSE OF THE TRANSIENTS INTRODUCED
#	BY TEH THRUST VECTOR RETURN TO THE ACTUATOR MECHANICAL NULLS
#	FOLLOWING TVC AND OPTICS-ERROR-COUNTER-DISENABLES (CHANNEL 12).
#	TVC USES A MIXTURE OF WAITLIST, T5, T6, AND JOB CALLS.  THERE IS
#	FILTER MEMORY (UP TO 7TH ORDER) TO BE PROTECTED IF WILD TRANSIENTS
#	ARE TO BE AVOIDED.  SEVERAL COUNTERS ARE INVOLVED FOR TIMING TVC
#	EVENTS SUCH AS SWITCHOVER AND STROKE TEST STARTUPS AND RE-STARTUPS.
#	THE TVC GAINS ARE DECREMENTED.  THE GIMBAL TRIM ESTIMATORS AND THE
#	BODY AXIS ATTITUDE ERROR INTEGRATORS INVOLVE DIGITAL SUMMATION.
#	DIGITAL DIFFERENTIATORS ARE INVOLVED IN THE BODY AXIS RATE ESTIMATIONS
#	AND IN THE OUTPUTTING OF ACTUATOR COMMANDS.  THERE IS AN
#	OFFSET-TRACKER-FILTER TO PROTECT.  ETC., ETC.
#
#      *THOSE QUANTITIES WHICH MUST BE PROTECTED ARE STORED IN TEMPORARY
#	REGISTERS AS THEY ARE COMPUTED, FOR UPDATING THE REAL REGISTERS
#	DURING COPYCYCLES.
#
#      *THE SEVERAL COPYCYCLES ARE EACH PROTECTED BY PHASE POINTS AT THEIR
#	BEGINNING AND AT THEIR TERMINATION.  THE PHASE POINTS ARE SIMPLY
#	"INCR" INSTRUCTIONS, EITHER "INCR TVCEXPHS" FOR COPYCYCLES
#	IN THE TVCEXECUTIVE, OR "INCR TVCPHASE" FOR THE PITCH AND YAW
#	COPYCYCLES.  INDEXING ON EACH OF THESE POINTERS THEN PERMITS A
#	RETURN TO THE APPROPRIATE RESTART POINTS.
#
#      *IF A RESTART OCCURS DURING EITHER COPYCYCLE, THAT COPYCYCLE IS
#	COMPLETED.  THEN THE NORMAL TVCINIT4....DAPINIT....PITCHDAP STARTUP
#	SEQUENCE IS CALLED UPON TO GET THINGS GOING AGAIN.
#
#      *TVC-ENABLE AND OPTICS-ERROR-COUNTER ENABLE MUST BE SET ASAP
#	(ALLOWING FOR PROCEDURAL DELAYS).  THEN THE ENGINES ARE COMMANDED
#	TO THE P,YACTOFF TRIM VALUES.  THE DAPS ARE THEN READY TO GO ON THE
#	AIR, WITH THE REGULAR STARTUP SEQUENCE, EITHER AT MRCLEAN FOR A
#	COMPLETE INITIALIZATION OR AT TVCIIT4 FOR A PARTIAL INITIALIZATION.
#
#      *FOR RESTARTS PRIOR TO THE SETTING OF THE T5 BITS IN IGNOVER THE
#	PRE40.6 SECTION OF S40.6 TAKES CARE OF RE-ESTABLISHING TRIMS.
#
#      *IF A RESTART OCCURS DURING THE TVCEXEC....TVCEXFIN SEQUENCE THE
#	COMPUTATIONS WILL BE COMPLETED, STARTING AT THE APPROPRIATE RESTART
#	POINT, AFTER THE DAPS ARE READY TO GO ON THE AIR.
#
#      *IF A RESTART OCCURS PRIOR TO TVCINIT4 (TVCPHAS = -1) E.G. DURING
#	THE EARLY DAP INITIALIZATION PHASE, THE DAP STARTUP SEQUENCE IS
#	ENTERED AT MRCLEAN FOR A FULL INITIALIZATION.
#
#      *RESTARTS ARE NOT CRITICAL TO THE ROLL DAP PERFORMANCES HENCE THE
#	ROLL DAP IS MERELY RESTARTED.
#
#      *RESTARTS DURING A STROKE TEST (STROKER IS NON-ZERO) WILL CAUSE THE
#	STROKE TEST TO BE TERMINATED.  A NEW V68 ENTRY WILL BE REQUIRED
# Page 921
#	TO GET IT GOING AGAIN (NO AUTOMATIC RESTART).
#  
#      *REDOTVC IS REACHED FOLLOWING ANY RESTART WHICH FINDS THE T5 BITS
#	(BITS 15,14 OF FLAGWRD6) SET FOR TVC.  IGNOVER PREPARES TVCPHASE = -1
# 	AND TVC EXPHS = 0 JUST BEFORE SETTING THESE BITS, JUST BEFORE
#	MAKING THE T5 CALL TO TVCDAPON.  T.V.N.G. TAKES OVER THE T5 CLOCK
#	TO CALL RCSUP/RCSDAPON WHICH RESETS THE T5 BITS (FOR RCS) ON A
#	NORMAL SHUTDOWN.
#
# CALLING SEQUENCE....T5, IN PARTICULAR BY ELRSKIP OF FRESH START/RESTART
#
# NORMAL EXIT MODES....RESUME, NOQRSM, POSTJUMP (TO TVCINIT4 OR MRCLEAN)
#
# ALARM OR ABORT EXIT MODES....NONE
#
# SUBROUTINES CALLED....
#
#      *PCOPY+1, YCOPY+1 (PITCH AND YAW COPYCYCLES)
#
#      *ENABLE1,2, CMDSOUT (RE-ESTABLISH ACTUATOR TRIMS)
#
#      *MRCLEAN OR TVCINIT4 (TVCDAP INITIALIZATIONS)
#
#      *EXRSTRT AND TVCEXECUTIVE PHASE POINTS 1 THRU 9
#
#      *WAITLIST, IBNKCALL, POSTJUMP, ISWCALL
#
# OTHER INTERFACES....IGNOVER AND RCSDAPON (T5 BITS), ELRSKIP (CALLS IT)
#
# ERASABLE ININTIALIZATION REQUIRED....
#
#      *T5 BITS, TVCPHASE, TVCEXPHS
#
#      *TVC DAP VARIABLES
#
#      *OPERATIONS PERFORMED BY REDOTVC ARE BASED ON THE ASSUMPTION THAT
#	THE TVC DAPS ARE RUNNING NORMALLY
#
# OUTPUT....
#
#      *PITCH AND YAW TVC DAP COPYCYCLES COMPLETED IF INTERRUPTED
#
#      *TVCEXECUTIVE COMPLETED IF INTERRUPTED
#
#      *STROKE TEST TERMINATED IF INTERRUPTED
#
#      *ACTUATOR TRIMS RE-ESTABLISHED (ACTUATORS BACK ON THE AIR)
#
#      *TVC DAP INITIALIZATION AS REQUIRED
#
#      *ALL TVC DAP OPERATIONS ON THE AIR
#
# DEBRIS....TVC TEMPORARIES IN EBANK6

		BANK	16
		SETLOC	DAPROLL
		BANK
		EBANK=	TVCPHASE
		
		COUNT*	$$/RSRT
REDOTVC		LXCH	BANKRUPT	# TVC RESTART PACKAGE
# Page 922
		EXTEND
		QXCH	QRUPT		# ("TCR" IN "FINCOPY")
		
EXECPHS		CCS	TVCEXPHS	# CHECK TVCEXECUTIVE PHASE
		TCF	+2		#	MUST RESTART TVCEXECUTIVE
		TCF	TVCDAPHS	#	NO NEED TO RESTART TVCEXECUTIVE
		
		CAF	NINE		# 9CS DELAY TO FORCE EXRSTRT TO OCCUR
		TC	WAITLIST	#	BEFORE PITCHDAP, AFTER CMDSOUT
		EBANK=	TVCEXPHS
		2CADR	EXRSTRT

TVCDAPHS	CS	OCT37776	# CHECK BITS 15 AND 1 OF TVCPHASE TO SEE
		MASK	TVCPHASE	#	DAP RESTART LOCATION (-1,1,2,3)
		CCS	A
		TCF	FINCOPY		#	FINISH THE COPYCYCLE FIRST
		TCF	ENABL1		#	JUST PREPARE THE OUTCOUNTERS AND GO
		TCF	TRIM/CMD	#	(RE-)DO P,YCMD INITIALIZATION FIRST
ENABL1		CAF	BIT8		# TVC ENABLE, FOLLOWED BY 40 MS (MIN) WAIT
		AD	BIT11		#	OPTICS DAC DISENGAGE TOO
		EXTEND			#	(ENABL1 ENTRIES..+0,- CCS, FINCOPY)
		WOR	CHAN12
		CAF	TVCADDR		# WAIT, CALLING ENABL2 (BBCON THERE)
		TS	T5LOC
		CAF	TVCADDR +4	#	60 MS (TVCEXADR)
		TS	TIME5
		
		TCF	RESUME
ENABL2		LXCH	BANKRUPT	# CONTINUE PREPARATION OF OUTCOUNTERS

		CAF	BIT2		# OPTICS ERROR CNTR ENABLE, 4MS MIN WAIT
		EXTEND
		WOR	CHAN12
		CAF	TVCADDR +2	# WAIT, CALLING CMDSOUT (BBCON THERE)
		TS	T5LOC
		CAF	OCT37776	# 	20MS
		TS	TIME5
		
		TCF	NOQRSM
CMDSOUT		LXCH	BANKRUPT	# CONTNUE PREPARATION OF OUTCOUNTERS
		EXTEND
		QXCH	QRUPT
# Page 923
		CS	ZERO		# MOST RECENT ACTUATOR COMMANDS
		AD	PCMD		#	(AVOID +0)
		TS	TVCPITCH
		CS	ZERO
		AD	YCMD
		TS	TVCYAW
		
		CAF	PRIO6		# RELEASE THE COUNTERS (BITS 11,12)
		EXTEND
		WOR	CHAN14
		
PHSCHK2		CS	TVCPHASE	# CHECK TVCPHASE AGAIN
		EXTEND
		BZMF	+3
		TC	POSTJUMP	# 	IF NEGATIVE, RESTART AT MRCLEAN
		CADR	MRCLEAN		#		FOR FULL INITIALIZATION
		
CHKSTRK		CCS	STROKER		# CHECK FOR STROKE TEST IN PROGRESS
		TCF	TSTINITJ	# YES, KILL IT
		TCF	+2		# NO, PROCEED
		TCF	TSTINITJ	# YES, KILL IT
		
	+4	TC	POSTJUMP	#	IF POSTIVE OR ZERO, RESTART AT
		CADR	TVCINIT4	#		TVCINIT4 (ZEROS TVCPHASE, AND
					#		CALLS TVC DAPS)
FINCOPY		INDEX	TVCPHASE	# PICK UP THE APPROPRIATE COPYCYCLE
		CAF	TVCCADR
		TCR	ISWCALL		# RE-ENTER THE COPYCYCLE, RETURN AT END
		TCF	ENABL1		# NOW PREPARE THE OUTCOUNTERS
TRIM/CMD	EXTEND			# TVCDAPON INITIALIZATION NOT COMPLETED,
		DCA	PACTOFF		#	EG. P,YCMD MAY NOT BE SET.  SET...
		DXCH	PCMD
		TCF	ENABL1		# NOW PREPARE THE OUTCOUNTERS
TSTINITJ	CAF	ZERO		# DISABLE STROKE TEST (-0 SHOWS PRIOR V68)
		TS	STROKER		# (+0 MEANS NEW V68 REQUIRED FOR STARTUP)
		TCF	CHKSTRK +4
		
EXRSTRT		INDEX	TVCEXPHS	# TVCEXECUTIVE RESTARTS....GO TO
		CAF	TVCEXADR	#	APPROPRIATE RESTART POINT
		INDEX	A
		TCF	0

# Page 924
# TVC RESTART TABLES.... ORDER IS REQUIRED.  HI-ORDER WORDS ONLY, OF 2CADRS, SINCE BBCON IS ALREADY THERE.

TVCADDR		=	TVCCADR		# TABLE OF CADRS, UNUSED LOCS FOR GENADRS
TVCCADR		GENADR	ENABL2		# (FOR T5 CALL, UNUSED TABLE LOC)
	+1	CADR	PCOPY +1	# PITCH COPYCYCLE
	+2	GENADR	CMDSOUT		# (FOR T5 CALL, UNUSED TABLE LOC)
	+3	CADR	YCOPY +1	# YAW COPYCYCLE
TVCEXADR	OCT	37772		# (UNUSED TABLE LOC, FILL WITH 60MS, T5)
	+1	GENADR	EXECCOPY +1	# TVCEXECUTIVE RESTART POINTS (ORDERED)
	+2	GENADR	SWT/COR
	+3	GENADR	SWTCOPY +1
	+4	GENADR	TEMPSET
	+5	GENADR	CORSETUP
	+6	GENADR	CORCOPY +1
	+7	GENADR	CNTRCOPY
	+8D	GENADR	STRKUP
	+9D	GENADR	STRKTCPY +1
	

