# Copyright:    Public domain.
# Filename:     LUNAR_AND_SOLAR_EPHEMERIDES_SUBROUTINES.s
# Purpose:      Part of the source code for Comanche, build 055. It
#               is part of the source code for the Command Module's
#               (CM) Apollo Guidance Computer (AGC), Apollo 11.
# Assembler:    yaYUL
# Reference:    pp. 785-788
# Contact:      Ron Burkey <info@sandroid.org>
# Website:      http://www.ibiblio.org/apollo.
# Mod history:  2009-05-12 RSB	Adapted from Colossus249 file of the same
#				name and Comanche 055 page images.
#
# The contents of the "Comanche055" files, in general, are transcribed 
# from scanned documents. 
#
#       Assemble revision 055 of AGC program Comanche by NASA
#       2021113-051.  April 1, 1969.  
#
#       This AGC program shall also be referred to as Colossus 2A
#
#       Prepared by
#                       Massachussets Institute of Technology
#                       75 Cambridge Parkway
#                       Cambridge, Massachusetts
#
#       under NASA contract NAS 9-4065.
#
# Refer directly to the online document mentioned above for further
# information.  Please report any errors to info@sandroid.org.

# Page 785
# LUNAR AND SOLAR EPHEMERIDES SUBROUTINES
#
# FUNCTIONAL DESCRIPTION
#
#	THESE SUBROUTINES ARE USED TO DETERMINE THE POSITION AND VELOCITY
#	VECTORS OF THE SUN AND THE MOON RELATIVE TO THE EARTH AT THE
#	SPECIFIED GROUND ELAPSED TIME INPUT BY THE USER.
#
#	THE POSITION OF THE MOON IS STORED IN THE COMPUTER IN TEH FORM OF
#	A NINTH DEGREE POLYNOMIAL APPROXIMATION WHICH IS VALID OVER A 15
#	DAY INTERVAL BEGINNING SHORTLY BEFORE LAUNCH.  THEREFORE THE TIME
#	INPUT BY THE USER SHOULD FALL WITHIN THIS 15 DAY INTERVAL.
#
#	LSPOS COMPUTES THE POSITION VECTORS OF THE SUN AND THE MOON.
#
#	LUNPOS COMPUTES THE POSITION VECTOR OF THE MOON.
#
#	LUNVEL COMPUTES THE VELOCITY VECTOR OF THE MOON.
#
#	SOLPOS COMPUTES THE POSITION VECTOR OF THE SUN.
#
# CALLING SEQUENCE
#
#	DLOAD	CALL
#		TIME		GROUND ELAPSED TIME
#		SUBROUTINE	LSPOS OR LUNPOS OR LUNVEL OR SOLPOS
#
# INPUT
#
#	1) SPECIFIED GROUND ELAPSED TIME IN CS x B-28 LOADED IN MPAC.
#
#	2) TIMEMO -- TIME AT THE CENTER OF THE RANGE OVER WHICH THE LUNAR
#	POSITION POLYNOMIAL IS VALID IN CS x B-42.
#
#	3) VECOEM -- VECTOR COEFFICIENTS OF THE LUNAR POSITION POLYNOMIAL
#	LOADED IN DESCENDING SEQUENCE IN METERS/CS**N x B-2
#
#	4) RESO -- POSITION VECTOR OF THE SUN RELATIVE TO THE EARTH AT
#	TIMEMO IN METERS x B-38
#
#	5) VESO -- VELOCITY VECTOR OF THE SUN RELATIVE TO THE EARTH AT
#	TIMEMO IN METERS/CS x B-9
# 
#	6) OMEGAES -- ANGULAR VELOCITY OF THE VECTOR RESO AT TIMEMO IN
#	REV/CS x B+26
#
#	ALL EXCEPT THE FIRST INPUT ARE INCLUDED IN THE PRE-LAUNCH
#	ERASABLE DATA LOAD.
#
# OUTPUT -- LSPOS
# Page 786
#
#	1) 2D OF VAC AREA CONTAINS THE POSITION VECTOR OF THE SUN RELATIVE
#	TO THE EARTH AT TIME INPUT BY THE USER IN METERS x B-38.
#
#	2) MPAC CONTAINS THE POSITION VECTOR OF THE MOON RELATIVE TO THE
#	EARTH AT TIME INPUT BY THE USER IN METERS x B-29
#
# OUTPUT -- LUNPOS
#
#	MPAC CONTAINS THE POSITION VECTOR OF THE MOON RELATIVE TO THE
#	EARTH AT THE TIME INPUT BY USER IN METERS x B-29
#
# OUTPUT -- LUNVEL
#
#	MPAC CONTAINS THE VELOCITY VECTOR OF THE MOON RELATIVE TO THE
#	EARTH AT THE TIME INPUT BY THE USER IN METERS/CS x B-7
#
# OUTPUT -- SOLPOS
#
#	MPAC CONTAINS THE POSITION VECTOR OF THE SUN RELATIVE TO THE EARTH
#	AT TIME INPUT BY THE USER IN METERS x B-38.
#
# SUBROUTINES USED
#
#	NONE
#
# REMARKS
#
#	THE VAC AREA IS USED FOR STORAGE OF INTERMEDIATE AND FINAL RESULTS
#	OF COMPUTATIONS.
#
#	S1, X1, AND X2 ARE USED BY THESE SUBROUTINES.
#
#	PRELAUNCH ERASABLE DATA LOAD ARE ONLY ERASABLE STORAGE USED BY
#	THESE SUBROUTINES.
#
#	RESTARTS DURING OPERATION OF THESE SUBROUTINES MUST BE HANDLED BY
#	THE USER.

		BANK	36
		SETLOC	EPHEM
		BANK
		
		COUNT*	$$/EPHEM
		EBANK=	END-E7
LSPOS		AXT,2			# COMPUTES POSITION VECTORS OF BOTH THE
			RESA		# SUN AND THE MOON.  THE POSITION VECTOR
		AXT,1	GOTO		# OF THE SUN IS STORED IN 2D OF THE VAC
			RES		# AREA.  THE POSITION VECTOR OF THE MOON
			LSTIME		# IS STORED IN MPAC.
LUNPOS		AXT,1	GOTO		# COMPUTES THE POSITION VECTOR OF THE MOON
			REM		# AND STORES IT IN MPAC.
			LSTIME
# Page 787
LUNVEL		AXT,1	GOTO		# COMPUTES THE VELOCITY VECTOR OF THE MOON
			VEM		# AND STORES IT IN MPAC.
			LSTIME
SOLPOS		STQ	AXT,1		# COMPUTES THE POSITION VECTOR OF THE SUN
			X2		# AND STORES IT IN MPAC.
			RES
LSTIME		SETPD	SR
			0D
			14D
		TAD	DCOMP
			TEPHEM
		TAD	DCOMP
			TIMEMO
		SL	SSP
			16D
			S1
			6D
		GOTO
			X1
RES		PUSH	DMP		#					PD- 2
			OMEGAES
		PUSH	COS		#					PD- 4
		VXSC	PDDL		#					PD- 8
			RESO	
		SIN	PDVL		#					PD-10
			RESO
		PUSH	UNIT		#					PD-16
		VXV	UNIT
			VESO
		VXV	VSL1		#					PD-10
		VXSC	VAD		#					PD-02
		VSL1	GOTO		# RES IN METERS x B-38 IN MPAC.
			X2
RESA		STODL	2D		# RES IN METERS x B-38 IN 2D OF VAC.	PD- 0
REM		AXT,1	PDVL		#					PD- 2
			54D
			VECOEM
REMA		VXSC	VAD*
			0D
			VECOEM +60D,1
		TIX,1	VSL2		# REM IN METERS x B-29 IN MPAC.
			REMA
		RVQ
VEM		AXT,1	PDDL		#					PD- 2
			48D
			NINEB4
		PUSH	VXSC		#					PD- 4
			VECOEM
VEMA		VXSC
			0D
# Page 788
		STODL	4D		#					PD- 2
		DSU	PUSH		#					PD- 4
			ONEB4
		VXSC*	VAD
			VECOEM +54D,1
			4D
		TIX,1	VSL2		# VEM IN METERS/CS x B-7 IN MPAC.
			VEMA
		RVQ
NINEB4		2DEC	9.0 B-4

ONEB4		2DEC	1.0 B-4



