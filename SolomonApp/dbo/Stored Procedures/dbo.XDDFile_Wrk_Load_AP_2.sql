
CREATE PROCEDURE XDDFile_Wrk_Load_AP_2
   @VchRefNbr	varchar( 10 ),
   @VchDocType	varchar( 2 ),
   @ChkRefNbr	varchar( 10 ),
   @ChkDocType	varchar( 2 ),
   @VendID	varchar( 15 ),
   @Acct	varchar( 10 ),
   @SubAcct	varchar( 24 )

AS

   -- Unique index on APAdjust
   -- AdjdRefNbr, AdjdDocType, AdjgRefNbr, AdjgDocType, VendId, AdjgAcct, AdjgSub

   SELECT	V.*
   FROM		APAdjust A (NoLock) LEFT OUTER JOIN APDoc V (nolock)
		ON A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType LEFT OUTER JOIN XDDDepositor D (NoLock)
		ON A.VendID = D.VendID and D.VendCust = 'V' 
   WHERE	A.AdjdRefNbr = @VchRefNbr
   		and A.AdjdDocType = @VchDocType
   		and A.AdjgRefNbr = @ChkRefNbr
   		and A.AdjgDocType = @ChkDocType
   		and A.VendID = @VendID
   		and A.AdjgAcct = @Acct
   		and A.AdjgSub = @SubAcct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Load_AP_2] TO [MSDSL]
    AS [dbo];

