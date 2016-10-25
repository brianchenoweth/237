*----------------------------------------------------------------------
* Programmer: Brian Chenoweth
* Class Account: masc0706
* Assignment or Title: Program 3
* Filename: prog3.s
* Date completed:04/14/15
*----------------------------------------------------------------------
* Problem statement: Change a number between 0 and 65535 to a base between 2 and 16
* Input: Base 10 number and base to convert to 
* Output: Number in new base
* Error conditions tested: If number < 0 or number > 65535
* Included files: prog3.s
* Method and/or pseudocode:  
* References: Riggins' java base converter
*----------------------------------------------------------------------
*
       ORG     $0
       DC.L    $3000           * Stack pointer value after a reset
       DC.L    start           * Program counter value after a reset
       ORG     $3000           * Start at location 3000 Hex
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
start:  initIO                  	* Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	

start2:	
	lineout		title

grt0:	
	clr.l     D0          *clears user input in D0
	lineout   numprompt		*asks user for number in base 10
	linein    buffer		  *buffer1 is user num in base 10
	stripp    buffer,D0
	cmp.b		  #5,D0
	BGT		    error
	move.l		D0,D6		    *copy of base 10 num
	lea		    buffer,A1		*load user base 10 num to A1
	sub		    #1,A1	
	clr.b		  D5

valid:	
	add.w		  #1,D5
	cmp.w		  D0,D5			
	BGT		    cvt
	add		    #1,A1
	cmp.b		  #'0',(A1) 
	BEQ		    valid
	cmp.b		  #'1',(A1)
	BEQ		    valid
	cmp.b		  #'2',(A1)
	BEQ		    valid
	cmp.b		  #'3',(A1)
	BEQ		    valid
	cmp.b		  #'4',(A1)
	BEQ		    valid
	cmp.b		  #'5',(A1)
	BEQ		    valid
	cmp.b		  #'6',(A1)
	BEQ		    valid
	cmp.b		  #'7',(A1)
	BEQ		    valid
	cmp.b		  #'8',(A1)
	BEQ		    valid
	cmp.b		  #'9',(A1)
	BEQ		    valid
	lineout		error1
	BRA		    start2

cvt:	
	cvta2		  buffer,D0
	move.l		D0,D3		   *num in D3
	cmp.l		  #0,D0		   *compare num to 0 
	bge		    les65		   *branch > or = 0
	bra		    error		   *branch error < 0

les65:	
	cmp.l     #65535,D0       *compare user input to 65535
	ble		    grt2            *if less than branch to next
	bra		    error           *branch to error if > 65535

error:
	lineout		error1		      *invalid input
	bra		    start		        *branch start if error

grt2:	
	clr.l     D0
	lineout		baseprompt    *base to convert to
	linein		buffer        *buffer for base
	stripp		buffer,D0
	cvta2		  buffer,D0     *convert to twos complement
	move.l		D0,D7		      *copy of base in D7
	cmp.l		  #2,D7		      *compare user base to 2		
	blt		    error2		    *branch to error2 if < 2

les16:
	cmp.l		  #16,D7		   *compare user base to 16
	ble		    next2        *branch if less than 16

error2:
	lineout		error1      *invalid input
	bra		    grt2        *branch to grt2 if error

next2:
	lea		  rem,A2		 *load A2 with 20 bites		
	sub.l		#1,D6		   *sub. 1 from base 10 num
	clr		  D5			

next3:
	tst.w		D3		   *check if user num 0
	BEQ		  end		   *if 0, branch to end
	divu		D7,D3		 *number/base
	swap		D3		
	cmp.b		#10,D3
	BLO		  add		   *branch if less than 10
	add.b		#$37,D3  *turn to ascii
	move.b	D3,(A2)+ *rem to A2, increment
	add.l		#1,D5		 *add 1 to counter
	swap		D3			
	ext.l		D3			
	bra		  next3		 *repeat loop
	
add:	
	add.b		#$30,D3		 *turn to ascii
	move.b	D3,(A2)+
	add.l		#1,D5		   *add 1 to counter
	swap		D3		
	ext.l		D3			
	bra		  next3
	
end:	
  lea		  output,A4 *load answer to A4

end2:
	move.b		-(A2),(A4)+ *reverse order
	dbra		  D5,end2			
	clr.b		  (A4)
	lineout		answer

						
				
				* Your code goes HERE


       break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

title:      dc.b	'Program #3, Brian Chenoweth, masc0706',0
numprompt:	dc.b	'Enter a base 10 number:',0
buffer:		  ds.b	80
baseprompt:	dc.b	'Enter the base to convert to:',0
buffer1:		ds.b	80
error1:		  dc.b	'ERROR: Invalid input, please enter valid input',0
base:       ds.b	80
rem:		    ds.b	20
answer:		  dc.b	'The answer is: '			
output:		  ds.b	20


				* Your storage declarations go 
				* HERE
       end
