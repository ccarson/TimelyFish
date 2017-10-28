
CREATE PROCEDURE XDDFile_Wrk_Load_AP_MCB_2
   @BatNbr	varchar( 10 ),
   @RefNbr	varchar( 10 ),
   @DocType	varchar( 2 )
   
AS

   SELECT	*
   FROM		APDoc C (nolock)
   WHERE	C.BatNbr = @BatNbr
   		and C.RefNbr = @RefNbr
   		and C.DocType = @DocType

