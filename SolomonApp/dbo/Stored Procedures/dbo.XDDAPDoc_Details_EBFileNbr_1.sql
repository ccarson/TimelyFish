
CREATE PROCEDURE XDDAPDoc_Details_EBFileNbr_1
   @EBFileNbr		varchar( 6 ),
   @BatNbr		varchar( 10 ),	
   @FileType		varchar( 1 ),
   @Order		varchar( 1 )		-- "I"d, "N"ame

AS

	-- TempTable
	CREATE TABLE #TempTable
	(	VendID    		char ( 15 )	NOT NULL,
		VendName		char ( 60 )	NOT NULL,
		AdjBatNbr		char ( 10 )	NOT NULL,
		AdjdDocType		char ( 2 )	NOT NULL,
		AdjdRefNbr		char ( 10 )	NOT NULL,
		AdjgDocType		char ( 2 )	NOT NULL,
		AdjgRefNbr		char ( 10 )	NOT NULL,
		AdjgAcct		char ( 10 )	NOT NULL,
		AdjgSub			char ( 24 )	NOT NULL,
		ChkDiscAmt		float		NOT NULL,
		VchDiscAmt		float		NOT NULL,
		BatchType		char ( 3 )	NOT NULL,
		BatchStatusChk		char ( 1 )	NOT NULL,
		BatchStatusVch		char ( 1 )	NOT NULL,
		VchPaidAmt		float		NOT NULL,
		VendAcct		char ( 18 )	NOT NULL
	)

	-- Get APAdjust records
	INSERT INTO #TempTable
	(VendID, VendName, AdjBatNbr, AdjdDoctype, AdjdRefNbr, AdjgDoctype, AdjgRefNbr, AdjgAcct, AdjgSub, 
		ChkDiscAmt, VchDiscAmt, BatchType, BatchStatusChk, BatchStatusVch, VchPaidAmt, VendAcct)

   	SELECT	VE.VendID, VE.Name, A.AdjBatNbr, A.AdjdDoctype, A.AdjdRefNbr, A.AdjgDoctype, A.AdjgRefNbr, A.AdjgAcct, A.AdjgSub, 
   		A.CuryAdjgDiscAmt, A.CuryAdjdDiscAmt, 'CCB', Coalesce(BC.Status, 'C'), Coalesce(BV.Status, 'C'), A.CuryAdjgAmt,
		Coalesce(V.eConfirm, '')
	FROM	XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
		ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN APAdjust A (nolock)
		ON XB.BatNbr = A.AdjBatNbr LEFT OUTER JOIN APDoc V (nolock)
		ON A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
		ON A.AdjgAcct = C.Acct and A.AdjgSub = C.Sub and A.AdjgDocType = C.DocType
	   	and A.AdjgRefNbr = C.RefNbr and A.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
		ON A.VendID = D.VendID and V.eConfirm = D.VendAcct and D.VendCust = 'V' LEFT OUTER JOIN Vendor VE (nolock)
		ON A.VendID = VE.VendID LEFT OUTER JOIN Batch BC (nolock)
		ON C.BatNbr = BC.BatNbr and BC.Module = 'AP' LEFT OUTER JOIN Batch BV (nolock)
		ON V.BatNbr = BV.BatNbr and BV.Module = 'AP'
	WHERE	XF.EBFileNbr = @EBFileNbr
		and XB.Module = 'AP'
	   	and ((@FileType IN ('E', 'W') and XF.FileType IN ('E', 'W')) or (@FileType = 'P' and XF.FileType = 'P'))
	   	and A.AdjBatNbr LIKE @BatNbr

	-- Now check if we have Manual Check batches on hold
	INSERT INTO #TempTable
	(VendID, VendName, AdjBatNbr, AdjdDoctype, AdjdRefNbr, AdjgDoctype, AdjgRefNbr, AdjgAcct, AdjgSub, 
		ChkDiscAmt, VchDiscAmt, BatchType, BatchStatusChk, BatchStatusVch, VchPaidAmt, VendAcct)

	-- CostType = Voucher DocType
	-- UnitDesc = Voucher RefNbr
	-- CuryUnitPrice = Voucher Disc Amount
	-- Cury
   	SELECT	VE.VendID, VE.Name, T.BatNbr, T.CostType, T.UnitDesc, C.DocType, C.RefNbr, C.Acct, C.Sub, 
   		C.CuryDiscBal, T.CuryUnitPrice, 'MCB', 'H', Coalesce(BV.Status, 'C'), T.CuryTranAmt,
		Coalesce(V.eConfirm, '')
	FROM	XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
		ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN Batch B (nolock)
		ON XB.BatNbr = B.BatNbr and B.Module = 'AP' LEFT OUTER JOIN APTran T (nolock)
		ON XB.BatNbr = T.BatNbr LEFT OUTER JOIN APDoc C (nolock)
		ON T.BatNbr = C.BatNbr and T.RefNbr = C.RefNbr LEFT OUTER JOIN Vendor VE (nolock)
		ON C.VendID = VE.VendID LEFT OUTER JOIN APDoc V (nolock)
		ON C.VendID = V.VendID and T.CostType = V.DocType and T.UnitDesc = V.RefNbr LEFT OUTER JOIN Batch BV (nolock)
		ON V.BatNbr = BV.BatNbr and BV.Module = 'AP' LEFT OUTER JOIN XDDDepositor D (NoLock)
		ON C.VendID = D.VendID and V.eConfirm = D.VendAcct and D.VendCust = 'V' 
	WHERE	XF.EBFileNbr = @EBFileNbr
		and XB.Module = 'AP'
		and B.Status = 'H'
	   	and ((@FileType IN ('E', 'W') and XF.FileType IN ('E', 'W')) or (@FileType = 'P' and XF.FileType = 'P'))
	   	and T.BatNbr LIKE @BatNbr
	
	-- With Pos Pay, Voids created in AP Check Update - not in Void Entry (no APAdjust record)
	-- Add in APDoc records - Status = 'V' and DocType = 'VC'
   	if @FileType = 'P'
   	BEGIN   

	   INSERT INTO #TempTable
	   (VendID, VendName, AdjBatNbr, AdjdDoctype, AdjdRefNbr, AdjgDoctype, AdjgRefNbr, AdjgAcct, AdjgSub, 
		ChkDiscAmt, VchDiscAmt, BatchType, BatchStatusChk, BatchStatusVch, VchPaidAmt, VendAcct)

   	   SELECT	VE.VendID, VE.Name, '', '', '', C.Doctype, C.RefNbr, C.Acct, C.Sub, 
   	   		0, 0, 'CUP', 'V', '', 0, ''
	   FROM		APAdjust A (NoLock) RIGHT OUTER JOIN APDoc V (nolock)
			ON A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType RIGHT OUTER JOIN APDoc C (nolock)
	   		ON A.AdjgAcct = C.Acct and A.AdjgSub = C.Sub and A.AdjgDocType = C.DocType and A.AdjgRefNbr = C.RefNbr LEFT OUTER JOIN XDDBatch XB (nolock)
	   		ON C.BatNbr = XB.BatNbr LEFT OUTER JOIN XDDEBFile XF (nolock)
	   		ON XB.EBFileNbr = XF.EBFileNbr and XB.FileType = XF.FileType LEFT OUTER JOIN Vendor VE (nolock)
	   		ON C.VendID = VE.VendID
	   WHERE	XF.EBFileNbr = @EBFileNbr
			and XB.Module = 'AP'
	   		and ((@FileType IN ('E', 'W') and XF.FileType IN ('E', 'W')) or (@FileType = 'P' and XF.FileType = 'P'))
			and (C.Status = 'V' and C.DocType = 'VC') 		
			and A.AdjBatNbr Is Null
	   		and C.Batnbr LIKE @BatNbr
	END
	
	-- Now return records - in correctly sorted order
   	if @Order = 'I'

	   -- need voucher fields not APAdjust....
	   SELECT	T.VendID, T.AdjBatNbr, T.AdjdDocType, T.AdjdRefNbr, T.AdjgDocType, T.AdjgRefNbr, T.AdjgAcct, T.AdjgSub, 
	   		T.ChkDiscAmt, T.VchDiscAmt, T.BatchType, T.BatchStatusChk, T.BatchStatusVch, T.VchPaidAmt, T.VendAcct,
			C.*
	   FROM		#TempTable T LEFT OUTER JOIN APDoc V (nolock)
			ON T.VendID = V.VendID and T.AdjdRefNbr = V.RefNbr and T.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
			ON T.AdjgAcct = C.Acct and T.AdjgSub = C.Sub and T.AdjgDocType = C.DocType
	   		and T.AdjgRefNbr = C.RefNbr and T.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
			ON T.VendID = D.VendID and T.VendAcct = D.VendAcct and D.VendCust = 'V'
	   ORDER BY 	T.VendID, T.AdjBatNbr, T.AdjgRefNbr, T.AdjdDocType DESC

	else

	   SELECT	T.VendID, T.AdjBatNbr, T.AdjdDocType, T.AdjdRefNbr, T.AdjgDocType, T.AdjgRefNbr, T.AdjgAcct, T.AdjgSub, 
	   		T.ChkDiscAmt, T.VchDiscAmt, T.BatchType, T.BatchStatusChk, T.BatchStatusVch, T.VchPaidAmt, T.VendAcct,
			C.*
	   FROM		#TempTable T LEFT OUTER JOIN APDoc V (nolock)
			ON T.VendID = V.VendID and T.AdjdRefNbr = V.RefNbr and T.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
			ON T.AdjgAcct = C.Acct and T.AdjgSub = C.Sub and T.AdjgDocType = C.DocType
	   		and T.AdjgRefNbr = C.RefNbr and T.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
			ON T.VendID = D.VendID and T.VendAcct = D.VendAcct and D.VendCust = 'V'
	   ORDER BY 	T.VendName, T.VendID, T.AdjBatNbr, T.AdjgRefNbr, T.AdjdDocType DESC
