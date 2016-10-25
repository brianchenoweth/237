*----------------------------------------------------------------------
* Programmer: Brian Chenoweth
* Class Account: masc0706
* Assignment or Title: Program #2
* Filename: prog2.s
* Date completed: 03/23/15
*----------------------------------------------------------------------
* Problem statement:
* Input:
* Output:
* Error conditions tested:
* Included files:
* Method and/or pseudocode:
* References:
*----------------------------------------------------------------------
*	ORG     $0
	DC.L    $3000
	DC.L    start
	ORG     $3000
* Stack pointer value after a reset
* Program counter value after a reset
* Start at location 3000 Hex
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
	TWO:		EQU $40000000 
	PI:			EQU $40490FDA 
	ONE_THIRD:	EQU $3EAAAAAB

start:

		initIO * Initialize (required for I/O) 
		setEVT * Error handling routines
		initF * For floating point macros only

lineout 	title
lineout 	prompt1         *asks user for cost of end material
floatin 	buffer
cvtaf 		buffer,D1 	*converts user input to float
lineout 	prompt2		*asks user for cost of side material
floatin 	buffer
cvtaf		buffer,D2
lineout		prompt3		*asks user for volume
floatin 	buffer
cvtaf		buffer,D3
move.l 		D3,D4
fmul		D2,D4		*multiply side cost by volume
move.l 		D1,D5		*end material to d5
fmul		#PI,D5		*end material times pi
fmul 		#TWO,D5
fdiv		D5,D4
fpow		D4,#ONE_THIRD	*raise D4 to the power 1/3
move.l 		D0,D7		*radius
move.l 		D3,D5		*volume
fmul		#TWO,D0		*multiply radius by 2
cvtfa 		diameter,#2	*convert diameter to ascii
fmul 		#TWO,D3		*multiply volume by 2
fdiv		D7,D3
fmul 		D2,D3		*multiply side cost by 3
fmul 		#TWO,D1		*multiply end cost by 2
fmul		#PI,D1		*multiply that by pi
move.l    	D7,D6		*radius to d6
fmul      	D7,D7		*radius^2
fmul		D1,D7
fadd		D7,D3
move.l 		D3,D0		*can cost to d0
cvtfa     	cancost,#2	*can cost to ascii
fmul 		D6,D6
fmul 		#PI,D6
fdiv		D6,D5
move.l 		D5,D0
cvtfa 		canheight,#2
lineout		cost
lineout		diam
lineout		height
  break

*
*----------------------------------------------------------------------
*       Storage declarations

title:		dc.b 	'Program #2, Brian Chenoweth, masc0706',0
prompt1:	dc.b 	'Enter the cost of end material per square cm:',0
prompt2:	dc.b 	'Enter the cost of the side material per square cm:',0
prompt3:	dc.b 	'Enter the desired volume in milliliters:',0
buffer:		ds.b 	80
cost:		dc.b 	'Can Cost: '
cancost:	ds.b 	20
diam:		dc.b 	'Diameter: '
diameter:	ds.b 	20
height:		dc.b 	'Height: '
canheight:	ds.b 	20
	end
