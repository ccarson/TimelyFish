
CREATE PROCEDURE XDDFile_Wrk_Load_AR_2
   @CustID	varchar( 15 ),
   @DocType	varchar( 2 ),
   @RefNbr	varchar( 10 ),
   @BatNbr	varchar( 10 )

AS

	-- ARDoc unique index: CustId, DocType, RefNbr, BatNbr, BatSeq

   	SELECT		A.*, C.*
   	FROM		ARDoc A (NoLock) LEFT OUTER JOIN Customer C (nolock)
   			ON A.CustID = C.CustID
   	WHERE		A.CustID = @CustID
			and A.DocType = @DocType
			and A.RefNbr = @RefNbr
			and A.BatNbr = @BatNbr
--   			and A.BatSeq = @BatSeq

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Load_AR_2] TO [MSDSL]
    AS [dbo];

