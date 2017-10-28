
CREATE PROCEDURE XDDFile_Wrk_Load_AP_1
   @BatNbr	varchar( 10 ),
   @VendID	varchar( 15 )

AS

   SELECT	A.*, C.*
   FROM		APAdjust A (NoLock) LEFT OUTER JOIN APDoc V (nolock)
		ON A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
		ON A.AdjgAcct = C.Acct and A.AdjgSub = C.Sub and A.AdjgDocType = C.DocType
   		and A.AdjgRefNbr = C.RefNbr and A.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
		ON A.VendID = D.VendID and V.eConfirm = D.VendAcct and D.VendCust = 'V'
   WHERE	A.AdjBatnbr = @BatNbr
   		and C.Status <> 'V'
   		and A.VendID LIKE @VendID
   ORDER BY 	A.AdjgAcct, A.AdjgSub,
                A.VendID, A.AdjBatNbr,
                A.AdjgRefNbr, A.AdjdDocType DESC
