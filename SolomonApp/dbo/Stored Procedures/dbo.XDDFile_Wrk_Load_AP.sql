
CREATE PROCEDURE XDDFile_Wrk_Load_AP
   @BatNbr	varchar( 10 ),
   @VendID	varchar( 15 )

AS

   SELECT	*
   FROM		APAdjust A (NoLock) LEFT OUTER JOIN APDoc V (nolock)
		ON A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
		ON A.AdjgAcct = C.Acct and A.AdjgSub = C.Sub and A.AdjgDocType = C.DocType
   		and A.AdjgRefNbr = C.RefNbr and A.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
		ON A.VendID = D.VendID and D.VendCust = 'V' 
   WHERE	A.AdjBatnbr = @BatNbr
   		and C.Status <> 'V'
   		and A.VendID LIKE @VendID
   ORDER BY 	A.AdjgAcct, A.AdjgSub,
                A.VendID, A.AdjBatNbr,
                A.AdjgRefNbr, A.AdjdDocType DESC

-- SELECT	*
-- FROM		APAdjust (NoLock),
--    		APDoc (NoLock),
--    		APDoc C (NoLock),
--    		XDDDepositor (NoLock)
--    WHERE	APAdjust.AdjdRefNbr = APDoc.RefNbr
--    		and APAdjust.AdjdDocType = APDoc.DocType
--    		and APAdjust.Vendid = XDDDepositor.Vendid
--    		and APAdjust.AdjgAcct = C.Acct
--    		and APAdjust.AdjgSub = C.Sub
--    		and APAdjust.AdjgDocType = C.DocType
--    		and APAdjust.AdjgRefNbr = C.RefNbr
--    		and C.Status <> 'V'
--    		and APAdjust.AdjgDocType <> 'ZC'
--    		and APAdjust.AdjBatnbr = @BatNbr
--    		and XDDDepositor.VendCust = 'V'
--    ORDER BY 	APAdjust.AdjgAcct, APAdjust.AdjgSub,
--              APAdjust.VendID, APAdjust.AdjBatNbr,
--              APAdjust.AdjgRefNbr, APAdjust.AdjdDocType DESC

