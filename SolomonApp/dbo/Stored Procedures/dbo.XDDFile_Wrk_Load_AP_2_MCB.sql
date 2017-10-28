
CREATE PROCEDURE XDDFile_Wrk_Load_AP_2_MCB
   @VchRefNbr	varchar( 10 ),
   @VchDocType	varchar( 2 ),
   @VendID	varchar( 15 )

AS

   SELECT	*
   FROM		APDoc (nolock)
   WHERE	VendID = @VendID
   		and RefNbr = @VchRefNbr
   		and DocType = @VchDocType

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Load_AP_2_MCB] TO [MSDSL]
    AS [dbo];

