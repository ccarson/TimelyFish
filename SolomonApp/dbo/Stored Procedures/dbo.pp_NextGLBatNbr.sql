 --USETHISSYNTAX

CREATE PROCEDURE pp_NextGLBatNbr @NextBatNbr Char(10) OUTPUT AS

/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
**    Proc Name: pp_NextGLBatNbr
**++* Narrative: This procedure will output the next BatNbr to be used in the creation of a new GL Batch.
*++*            In the process of providing the next BatNbr, the procedure will also update the GLSetup
*++*            procedure can only be called once for each new BatNbr.  To capture the value for use
*++*            more than once in a calling procedure, a variable must be used to store the output value.
**    Inputs   : NextBatNbr char(10)      Next batnbr to be used for a GL Batch
**   Called by: pp_01400
*
*/

UPDATE GLSetup
	SET LastBatNbr =
	RIGHT(REPLICATE('0',LEN(LastBatNbr)) + RTRIM(LTRIM(STR(CONVERT(INT,(LastBatNbr)) + 1))),LEN(LastBatNbr)),
	@NextBatNbr = RIGHT(REPLICATE('0',LEN(LastBatNbr)) + RTRIM(LTRIM(STR(CONVERT(INT,(LastBatNbr)) + 1))),LEN(LastBatNbr))


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_NextGLBatNbr] TO [MSDSL]
    AS [dbo];

