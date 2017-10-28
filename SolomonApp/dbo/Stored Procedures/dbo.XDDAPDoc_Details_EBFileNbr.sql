
CREATE PROCEDURE XDDAPDoc_Details_EBFileNbr
   @EBFileNbr		varchar( 6 ),
   @BatNbr		varchar( 10 ),	
   @FileType		varchar( 1 ),		-- "C"omputer check, "M"anual check
   @Order		varchar( 1 )		-- "I"d, "N"ame

AS

	Declare @BatType	varchar( 1 )
	
	-- If MCB (OrigScrnNbr = DD520 and On Hold), then use different logic
	SELECT Top 1 	@BatType = case when (B.OrigScrnNbr = 'DD520' and B.Status = 'H')
					then 'M'
					else 'C'
					end
	FROM		XDDBatch X (nolock) LEFT OUTER JOIN Batch B (nolock)
			ON X.BatNbr = B.BatNbr and B.Module = 'AP'
	WHERE		X.EBFileNbr = @EBFileNbr
			and X.FileType = @FileType
			
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
		AdjgSub			char ( 24 )	NOT NULL
	)

	if @BatType = 'C'
	BEGIN
		INSERT INTO #TempTable
		(VendID, VendName, AdjBatNbr, AdjdDoctype, AdjdRefNbr, AdjgDoctype, AdjgRefNbr, AdjgAcct, AdjgSub)
		
	   	SELECT	VE.VendID, VE.Name, A.AdjBatNbr, A.AdjdDoctype, A.AdjdRefNbr, A.AdjgDoctype, A.AdjgRefNbr, A.AdjgAcct, A.AdjgSub
		FROM	XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
			ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN APAdjust A (nolock)
			ON XB.BatNbr = A.AdjBatNbr LEFT OUTER JOIN APDoc V (nolock)
			ON A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
			ON A.AdjgAcct = C.Acct and A.AdjgSub = C.Sub and A.AdjgDocType = C.DocType
		   	and A.AdjgRefNbr = C.RefNbr and A.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
			ON A.VendID = D.VendID and D.VendCust = 'V' and V.eConfirm = D.VendAcct LEFT OUTER JOIN Vendor VE (nolock)
			ON A.VendID = VE.VendID
		WHERE	XF.EBFileNbr = @EBFileNbr
			and XB.Module = 'AP'
		   	and ((@FileType IN ('E', 'W') and XF.FileType IN ('E', 'W')) or (@FileType = 'P' and XF.FileType = 'P'))
		   	and A.AdjBatNbr LIKE @BatNbr
	END

	else

        BEGIN
		INSERT INTO #TempTable
		(VendID, VendName, AdjBatNbr, AdjdDoctype, AdjdRefNbr, AdjgDoctype, AdjgRefNbr, AdjgAcct, AdjgSub)

		SELECT	T.VendID, VE.Name, T.BatNbr, T.CostType, T.UnitDesc, T.TranType, T.RefNbr, C.Acct, C.Sub
		FROM	XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
			ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN APTRAN T (nolock)
			ON XB.BatNbr = T.BatNbr and T.DrCr = 'S' LEFT OUTER JOIN APDoc C (nolock)
			ON T.VendID = C.VendID and T.RefNbr = C.RefNbr and T.TranType = C.Doctype LEFT OUTER JOIN Vendor VE (nolock)
			ON T.VendID = VE.VendID
		WHERE	XF.EBFileNbr = @EBFileNbr
			and XB.Module = 'AP'
		   	and (@FileType IN ('E', 'W') and XF.FileType IN ('E', 'W'))
		   	and T.BatNbr LIKE @BatNbr
	END
		
	-- With Pos Pay, Voids created in AP Check Update - not in Void Entry (no APAdjust record)
	-- Add in APDoc records - Status = 'V' and DocType = 'VC'
   	if @FileType = 'P'
   	BEGIN   

	   INSERT INTO #TempTable
	   (VendID, VendName, AdjBatNbr, AdjdDoctype, AdjdRefNbr, AdjgDoctype, AdjgRefNbr, AdjgAcct, AdjgSub)

   	   SELECT	VE.VendID, VE.Name, '', '', '', C.Doctype, C.RefNbr, C.Acct, C.Sub
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
	BEGIN
	
 	   if @BatType = 'C'
		   SELECT	A.*, V.*, C.*, D.*
		   FROM		#TempTable T LEFT OUTER JOIN APAdjust A (nolock)
				ON T.AdjBatNbr = A.AdjBatNbr 
					and T.AdjdDoctype = A.AdjdDocType
					and T.AdjdRefNbr = A.AdjdRefNbr
					and T.AdjgDocType = A.AdjgDoctype
					and T.AdjgRefNbr = A.AdjgRefNbr
					and T.AdjgAcct = A.AdjgAcct
					and T.AdjgSub = A.AdjgSub LEFT OUTER JOIN APDoc V (nolock)
				ON A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
				ON T.AdjgAcct = C.Acct and T.AdjgSub = C.Sub and T.AdjgDocType = C.DocType
		   		and T.AdjgRefNbr = C.RefNbr and T.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
				ON T.VendID = D.VendID and D.VendCust = 'V' and V.eConfirm = D.VendAcct
		   ORDER BY 	T.VendID, T.AdjBatNbr, T.AdjgRefNbr, T.AdjdDocType DESC
	   else

	   BEGIN
--				APTran value (DrCr=S)
-- APTran VchRefNbr 		= UnitDesc
--	  VchDoctype 		= CostType
--	  ChkDocType 		= TranType
-- 	  ChkRefNbr		= RefNbr
--	  ChkAcct		= Acct
--	  ChkSub		= Sub
--	  VchCuryAmt		= CuryTranAmt - amt applied
--	  VchAmt		= TranAmt - amt applied
--	  VchCuryDiscTaken	= CuryUnitPrice
--	  VchBasDiscTaken	= JobRate
--	  VchCuryID		= CuryID
--	  VchBasUnitPrice	= UnitPrice

		   -- First set of field duplicate what would be in APAdjust
		   SELECT	TR.TranAmt As AdjAmt,		-- AdjAmt			   As Double
    				TR.BatNbr As AdjBatNbr,		-- AdjBatNbr			   As String * 10
    				left(TR.CostType, 2) As AdjdDoctype,	-- AdjdDocType             As String * 2 
    				TR.JobRate As AdjDiscAmt,	-- AdjDiscAmt                      As Double 
    				TR.UnitDesc As AdjdRefNbr,	-- AdjdRefNbr                      As String * 10 
    				TR.Acct As AdjgAcct,		-- AdjgAcct                        As String * 10 
    				C.DocDate As AdjgDocDate,	-- TR.AdjgDocDate                  As Sdate 
    				TR.TranType As AdjgDocType,	-- AdjgDocType                     As String * 2 
    				C.PerPost As AdjgPerPost,	-- AdjgPerPost                     As String * 6 
    				TR.RefNbr As AdjgRefNbr,	-- AdjgRefNbr                      As String * 10 
    				TR.Sub As AdjgSub,		-- AdjgSub                         As String * 24 
    				TR.Crtd_DateTime As Crtd_DateTime, 	-- Crtd_DateTime           As Sdate 
    				TR.Crtd_Prog As Crtd_Prog,	-- Crtd_Prog                       As String * 8 
    				TR.Crtd_User As Crtd_User,	-- Crtd_User                       As String * 10 
    				TR.CuryTranAmt As CuryAdjdAmt,	-- CuryAdjdAmt                     As Double 
    				TR.CuryID As CuryAdjdCuryID,	-- CuryAdjdCuryId                  As String * 4 
    				TR.CuryUnitPrice As CuryAdjdDiscAmt,	-- CuryAdjdDiscAmt                 As Double 
    				TR.CuryMultDiv As CuryAdjdMultDiv,	-- CuryAdjdMultDiv                 As String * 1 
    				TR.CuryRate As CuryAdjdRate,		-- CuryAdjdRate                    As Double 
    				TR.CuryUnitPrice As CuryAdjgDiscAmt,	-- CuryAdjgAmt                     As Double 
    				TR.JobRate As CuryAdjgDiscAmt,		-- CuryAdjgDiscAmt                 As Double 
    				convert(float,0) As CuryRGOLAmt,	-- CuryRGOLAmt                     As Double 
    				convert(smalldatetime, 0) As DateAppl,	-- DateAppl                        As Sdate 
    				TR.LUpd_DateTime As LUpd_DateTime,	-- LUpd_DateTime                   As Sdate 
    				TR.LUpd_Prog As LUpd_Prog,		-- LUpd_Prog                       As String * 8 
    				TR.LUpd_User As LUpd_User,		-- LUpd_User                       As String * 10 
    				TR.PerEnt As PerAppl,			-- PerAppl                         As String * 6 
    				convert(varchar(30), '') As S4Future01,	-- S4Future01                      As String * 30 
    				convert(varchar(30), '') As S4Future02,	-- S4Future02                      As String * 30 
    				convert(float, 0) As S4Future03,	-- S4Future03                      As Double 
    				convert(float, 0) As S4Future04,	-- S4Future04                      As Double 
    				convert(float, 0) As S4Future05,	-- S4Future05                      As Double 
    				convert(float, 0) As S4Future06,	-- S4Future06                      As Double 
    				convert(smalldatetime, 0) As S4Future07,	-- S4Future07              As Sdate 
    				convert(smalldatetime, 0) As S4Future08,	-- S4Future08              As Sdate 
    				convert(int, 0) As S4Future09,		-- S4Future09                      As Long
    				convert(int, 0) As S4Future10,		-- S4Future10                      As Long
    				convert(varchar(10), '') As S4Future11,	-- S4Future11                      As String * 10 
    				convert(varchar(10), '') As S4Future12,	-- S4Future12                      As String * 10 
    				convert(varchar(30), '') As User1,	-- User1                      	   As String * 30 
    				convert(varchar(30), '') As User2,	-- User2                           As String * 30 
    				convert(float, 0) As User3,		-- User3                           As Double 
    				convert(float, 0) As User4,		-- User4                           As Double 
    				convert(varchar(10), '') As User5,	-- User5                           As String * 10 
    				convert(varchar(10), '') As User6,	-- User6                           As String * 10 
    				convert(smalldatetime, 0) As User7,	-- User7                           As Sdate 
    				convert(smalldatetime, 0) As User8,	-- User8                           As Sdate 
    				T.VendID As VendID,			-- VendId                          As String * 15 
		   		V.*, C.*, D.*
		   FROM		#TempTable T LEFT OUTER JOIN APTran TR (nolock)
				ON T.AdjBatNbr = TR.BatNbr 
					and T.AdjdDoctype = TR.CostType
					and T.AdjdRefNbr = TR.UnitDesc
					and T.AdjgDocType = TR.TranType
					and T.AdjgRefNbr = TR.RefNbr
					and T.AdjgAcct = TR.Acct
					and T.AdjgSub = TR.Sub LEFT OUTER JOIN APDoc V (nolock)
				ON T.AdjdRefNbr = V.RefNbr and T.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
				ON T.AdjgAcct = C.Acct and T.AdjgSub = C.Sub and T.AdjgDocType = C.DocType
		   		and T.AdjgRefNbr = C.RefNbr and T.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
				ON T.VendID = D.VendID and D.VendCust = 'V' and V.eConfirm = D.VendAcct
		   ORDER BY 	T.VendID, T.AdjBatNbr, T.AdjgRefNbr, T.AdjdDocType DESC
  

	   END
	   
	END
	   
	else

	BEGIN
 	   if @BatType = 'C'
		   SELECT	A.*, V.*, C.*, D.*
		   FROM		#TempTable T LEFT OUTER JOIN APAdjust A (nolock)
				ON T.AdjBatNbr = A.AdjBatNbr 
					and T.AdjdDoctype = A.AdjdDocType
					and T.AdjdRefNbr = A.AdjdRefNbr
					and T.AdjgDocType = A.AdjgDoctype
					and T.AdjgRefNbr = A.AdjgRefNbr
					and T.AdjgAcct = A.AdjgAcct
					and T.AdjgSub = A.AdjgSub LEFT OUTER JOIN APDoc V (nolock)
				ON A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
				ON T.AdjgAcct = C.Acct and T.AdjgSub = C.Sub and T.AdjgDocType = C.DocType
		   		and T.AdjgRefNbr = C.RefNbr and T.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
				ON T.VendID = D.VendID and D.VendCust = 'V' and V.eConfirm = D.VendAcct
		   ORDER BY 	T.VendName, T.VendID, T.AdjBatNbr, T.AdjgRefNbr, T.AdjdDocType DESC
	    else

	    BEGIN

		   -- First set of field duplicate what would be in APAdjust
		   SELECT	TR.TranAmt As AdjAmt,		-- AdjAmt
    				TR.BatNbr As AdjBatNbr,		-- AdjBatNbr
    				left(TR.CostType, 2) As AdjdDoctype,	-- AdjdDocType             As String * 2 
    				TR.JobRate As AdjDiscAmt,	-- AdjDiscAmt                      As Double 
    				TR.UnitDesc As AdjdRefNbr,	-- AdjdRefNbr                      As String * 10 
    				TR.Acct As AdjgAcct,		-- AdjgAcct                        As String * 10 
    				C.DocDate As AdjgDocDate,	-- TR.AdjgDocDate                     As Sdate 
    				TR.TranType As AdjgDocType,	-- AdjgDocType                     As String * 2 
    				C.PerPost As AdjgPerPost,	-- AdjgPerPost                     As String * 6 
    				TR.RefNbr As AdjgRefNbr,	-- AdjgRefNbr                      As String * 10 
    				TR.Sub As AdjgSub,		-- AdjgSub                         As String * 24 
    				TR.Crtd_DateTime As Crtd_DateTime, 	-- Crtd_DateTime                   As Sdate 
    				TR.Crtd_Prog As Crtd_Prog,	-- Crtd_Prog                       As String * 8 
    				TR.Crtd_User As Crtd_User,	-- Crtd_User                       As String * 10 
    				TR.CuryTranAmt As CuryAdjdAmt,	-- CuryAdjdAmt                     As Double 
    				TR.CuryID As CuryAdjdCuryID,	-- CuryAdjdCuryId                  As String * 4 
    				TR.CuryUnitPrice As CuryAdjdDiscAmt,	-- CuryAdjdDiscAmt                 As Double 
    				TR.CuryMultDiv As CuryAdjdMultDiv,	-- CuryAdjdMultDiv                 As String * 1 
    				TR.CuryRate As CuryAdjdRate,		-- CuryAdjdRate                    As Double 
    				TR.CuryUnitPrice As CuryAdjgDiscAmt,	-- CuryAdjgAmt                     As Double 
    				TR.JobRate As CuryAdjgDiscAmt,		-- CuryAdjgDiscAmt                 As Double 
    				convert(float,0) As CuryRGOLAmt,	-- CuryRGOLAmt                     As Double 
    				convert(smalldatetime, 0) As DateAppl,	-- DateAppl                        As Sdate 
    				TR.LUpd_DateTime As LUpd_DateTime,	-- LUpd_DateTime                   As Sdate 
    				TR.LUpd_Prog As LUpd_Prog,		-- LUpd_Prog                       As String * 8 
    				TR.LUpd_User As LUpd_User,		-- LUpd_User                       As String * 10 
    				TR.PerEnt As PerAppl,			-- PerAppl                         As String * 6 
    				convert(varchar(30), '') As S4Future01,	-- S4Future01                      As String * 30 
    				convert(varchar(30), '') As S4Future02,	-- S4Future02                      As String * 30 
    				convert(float, 0) As S4Future03,	-- S4Future03                      As Double 
    				convert(float, 0) As S4Future04,	-- S4Future04                      As Double 
    				convert(float, 0) As S4Future05,	-- S4Future05                      As Double 
    				convert(float, 0) As S4Future06,	-- S4Future06                      As Double 
    				convert(smalldatetime, 0) As S4Future07,	-- S4Future07                      As Sdate 
    				convert(smalldatetime, 0) As S4Future08,	-- S4Future08                      As Sdate 
    				convert(int, 0) As S4Future09,		-- S4Future09                      As Long
    				convert(int, 0) As S4Future10,		-- S4Future10                      As Long
    				convert(varchar(10), '') As S4Future11,	-- S4Future11                      As String * 10 
    				convert(varchar(10), '') As S4Future12,	-- S4Future12                      As String * 10 
    				convert(varchar(30), '') As User1,	-- User1                      	   As String * 30 
    				convert(varchar(30), '') As User2,	-- User2                           As String * 30 
    				convert(float, 0) As User3,		-- User3                           As Double 
    				convert(float, 0) As User4,		-- User4                           As Double 
    				convert(varchar(10), '') As User5,	-- User5                           As String * 10 
    				convert(varchar(10), '') As User6,	-- User6                           As String * 10 
    				convert(smalldatetime, 0) As User7,	-- User7                           As Sdate 
    				convert(smalldatetime, 0) As User8,	-- User8                           As Sdate 
    				T.VendID,				-- VendId                          As String * 15 
		   		V.*, C.*, D.*
		   FROM		#TempTable T LEFT OUTER JOIN APTran TR (nolock)
				ON T.AdjBatNbr = TR.BatNbr 
					and T.AdjdDoctype = TR.CostType
					and T.AdjdRefNbr = TR.UnitDesc
					and T.AdjgDocType = TR.TranType
					and T.AdjgRefNbr = TR.RefNbr
					and T.AdjgAcct = TR.Acct
					and T.AdjgSub = TR.Sub LEFT OUTER JOIN APDoc V (nolock)
				ON T.AdjdRefNbr = V.RefNbr and T.AdjdDocType = V.DocType LEFT OUTER JOIN APDoc C (nolock)
				ON T.AdjgAcct = C.Acct and T.AdjgSub = C.Sub and T.AdjgDocType = C.DocType
		   		and T.AdjgRefNbr = C.RefNbr and T.AdjgDocType <> 'ZC' LEFT OUTER JOIN XDDDepositor D (NoLock)
				ON T.VendID = D.VendID and D.VendCust = 'V' and V.eConfirm = D.VendAcct
		   ORDER BY 	T.VendName, T.VendID, T.AdjBatNbr, T.AdjgRefNbr, T.AdjdDocType DESC
	    
	   END		   	
	END    

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAPDoc_Details_EBFileNbr] TO [MSDSL]
    AS [dbo];

