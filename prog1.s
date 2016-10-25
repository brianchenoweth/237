*----------------------------------------------------------------------
* Programmer:Brian Chenoweth	
* Class Account:masc0706 
* Assignment or Title:Program #1 
* Filename:prog1.s
* Date completed:03/09/15
*----------------------------------------------------------------------
* Problem statement:
* Input: 
* Output: 
* Error conditions tested: 
* Included files: 
* Method and/or pseudocode: 
* References: 
*----------------------------------------------------------------------
*
       ORG     $0
       DC.L    $3000           * Stack pointer value after a reset
       DC.L    start           * Program counter value after a reset
       ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/ma/cs237/bsvc/iomacs.s
#minclude /home/ma/cs237/bsvc/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	
	lineout		title	
	lineout		prompt		*asks user for date of birth	
	linein		buffer		*reads user input
	cvta2		buffer+6,#4	*convert year to two's complement, stores in D0
	move.w		#2015,D1	*moves 2015 to D1
	sub.w		D0,D1		*subtracts user year from 2015
	move.w		D1,D0		*moves result back to D0
	ext.l		D0		
	cvt2a		result,#3	*converts result to ascii
	stripp		result,#3	*removes leading zeros from result	
	lea		result,A1	*A1 gets address of result
	adda.l		D0,A1		*adds length of users age to A1
	move.b		#' ',(A1)+
	move.b		#'y',(A1)+
	move.b		#'e',(A1)+
	move.b		#'a',(A1)+
	move.b		#'r',(A1)+
	move.b		#'s',(A1)+
	move.b		#' ',(A1)+
	move.b		#'o',(A1)+
	move.b		#'l',(A1)+
	move.b		#'d',(A1)+
	move.b		#'.',(A1)+
	move.b		#' ',(A1)+
	move.b		#'*',(A1)+
	clr.b		(A1)		
	lea		stars+35,A2	*loads amount of stars needed into A2
	adda.l		D0,A2		*adds length of users age to A2
	clr.b		(A2)
	lineout		stars		*prints stars above answer1
	lineout		answer1		*prints answer1 and result
	lineout		stars		*prints stars below answer1
	move.b		#'*',(A2)
	


	
	

       break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:		dc.b	'Program #1, Brian Chenoweth, masc0706',0
prompt:		dc.b	'Enter your date of birth (MM/DD/YYYY):',0
buffer:		ds.b	80
answer1:	dc.b	'* In 2015 you will be '
result:		ds.b	20
stars:		dcb.b	40,'*'



       end
