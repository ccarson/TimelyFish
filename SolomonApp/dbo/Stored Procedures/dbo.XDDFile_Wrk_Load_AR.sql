
CREATE PROCEDURE XDDFile_Wrk_Load_AR
   @BatNbr	varchar( 10 ),
   @BatEFTGrp	smallint,
   @EFTTerms	varchar( 2 ),
   @CustID	varchar( 15 )

AS
	-- ARDoc unique index: CustId, DocType, RefNbr, BatNbr, BatSeq

   	SELECT		*
   	FROM		ARDoc A (NoLock) LEFT OUTER JOIN XDDDepositor D (nolock)
   			ON A.CustID = D.VendID and D.VendCust = 'C' LEFT OUTER JOIN XDDBatchAREFT B (nolock)
   			ON A.BatNbr = B.BatNbr and B.BatEFTGrp = @BatEFTGrp and A.RefNbr = B.RefNbr LEFT OUTER JOIN Customer C (nolock)
   			ON A.CustID = C.CustID
   	WHERE		A.BatNbr = @BatNbr
--   			and A.BatSeq = @BatSeq
   			and A.Terms LIKE @EFTTerms
   			and B.EFTAmount <> 0
   			and A.CustID LIKE @CustID
	ORDER BY 	B.CashAcct, B.CashSub,
                	A.CustID, A.BatNbr,
                	A.RefNbr, A.DocType
