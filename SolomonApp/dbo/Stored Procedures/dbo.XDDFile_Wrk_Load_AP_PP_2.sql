
CREATE PROCEDURE XDDFile_Wrk_Load_AP_PP_2
   @VchRefNbr	varchar( 10 ),
   @VchDocType	varchar( 2 ),
   @VendID	varchar( 15 )

AS

   -- Unique index on APDoc
   -- Acct, Sub, DocType, RefNbr, RecordID

   SELECT	*
   FROM		APDoc (nolock)
   WHERE	RefNbr = @VchRefNbr
   		and DocType = @VchDocType
   		and VendID = @VendID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Load_AP_PP_2] TO [MSDSL]
    AS [dbo];

