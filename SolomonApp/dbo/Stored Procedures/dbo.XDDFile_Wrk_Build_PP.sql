
CREATE PROCEDURE XDDFile_Wrk_Build_PP
	@EBFileNbr		varchar( 6 ),
	@BatNbr			varchar( 10 ),
	@Module			varchar( 2 ),	-- AP/PR
	@InclIssues		smallint, 	-- 1-yes, 0-no
	@InclVoids		smallint,		-- 1-yes, 0-no
	@ComputerName		varchar( 21 ),
	@DemoMode			smallint,		-- 1-demo mode - 3 records, 0-all records
	@UserID			varchar( 10 )
	
AS

	if @Module = 'AP'
	BEGIN
		-- AP Checks
		INSERT INTO	XDDFile_Wrk
		(BnkBankAcct, BnkBankTransit,
		ChkAcct, ChkBatNbr, ChkCuryAmt, ChkCuryDiscAmt, ChkCuryID,
		ChkDocDate, ChkDocType, ChkPerPost, ChkRefNbr, ChkSub, 
		ChkCpnyID, ChkLUpd_DateTime, ChkLUpd_Prog, ChkLUpd_User, 
		ComputerName, EBFileNbr, DepBankAcctLen, DepBankTransitLen, 
		DepRecord, 
		FilCrLf, 
		FormatID, FileType, EditScrnNbr, KeepDelete,
		PerAppl, RecordSumAmt, RecordSummary, RecType, RecSection, 
		VendID, 
		VendName, 
		VendCust,
		Crtd_DateTime, Crtd_Prog, Crtd_User, 
		LUpd_DateTime, LUpd_Prog, LUpd_User)
				
		SELECT	Case when P.PPBankAcct = ''
				then P.BankAcct
				else P.PPBankAcct
				end, 
				P.BankTransit,  
				D.Acct, @BatNbr, D.CuryOrigDocAmt, D.CuryDiscTkn, D.CuryID,
				D.DocDate, D.DocType, D.PerPost, D.RefNbr, D.Sub,
				D.CpnyID, D.LUpd_DateTime, D.LUpd_Prog, D.LUpd_User,
				@ComputerName, @EBFileNbr, 0, 0,
				'C', 
				Case when F.CrLf = 1 then 'Y' else 'N' end,
				P.PPFormatID, 'P', B.EditScrnNbr, 'F',
				'', D.CuryOrigDocAmt, 'C', '10V', '20P',
				D.VendID, 
				case when charindex('~', V.RemitName) > 0
					then right(rtrim(V.RemitName), len(rtrim(V.RemitName)) - charindex('~', V.RemitName)) 
						+ ' ' + left(V.RemitName, charindex('~', V.RemitName)-1)
					else V.RemitName
					end, 
				'V', 
				GetDate(), 'DD500', @UserID,
				GetDate(), 'DD500', @UserID
				
		FROM	APDoc D (nolock) left outer join Batch B (nolock)
				ON D.BatNbr = B.BatNbr and B.Module = 'AP' left outer join XDDBank P (nolock)
				ON D.CpnyID = P.CpnyID and D.Acct = P.Acct and D.Sub = P.Sub left outer join Vendor V (nolock)
				ON D.VendID = V.VendID left outer join XDDPPFileFormat F (nolock)
				ON P.PPFormatID = F.FormatID
		WHERE	D.BatNbr = @BatNbr
				and ( (@InclIssues = 1 and @InclVoids = 1)
				       or
					 (@InclVoids = 0 and @InclIssues = 1 and D.Status <> 'V' and D.DocType <> 'VC')
  				       or
					 (@InclVoids = 1 and @InclIssues = 0 and (D.Status = 'V' or D.DocType = 'VC') )
				    )
				and D.DocType <> 'SC'
                                and D.DocType <> 'EP'    -- no electronic payments
	END
	
	else
	
	BEGIN

		-- Payroll Checks
		INSERT INTO	XDDFile_Wrk
		(BnkBankAcct, BnkBankTransit,
		ChkAcct, ChkBatNbr, ChkCuryAmt, ChkCuryDiscAmt, ChkCuryID,
		ChkDocDate, ChkDocType, ChkPerPost, ChkRefNbr, ChkSub, 
		ChkCpnyID, ChkLUpd_DateTime, ChkLUpd_Prog, ChkLUpd_User, 
		ComputerName, EBFileNbr, DepBankAcctLen, DepBankTransitLen, 
		DepRecord, 
		FilCrLf, 
		FormatID, FileType, EditScrnNbr, KeepDelete,
		PerAppl, RecordSumAmt, RecordSummary, RecType, RecSection, 
		VendID, 
		VendName, 
		VendCust,
		Crtd_DateTime, Crtd_Prog, Crtd_User, 
		LUpd_DateTime, LUpd_Prog, LUpd_User)

		SELECT	Case when P.PPBankAcct = ''
				then P.BankAcct
				else P.PPBankAcct
				end, 
				P.BankTransit, 
				D.Acct, @BatNbr, D.NetAmt, 0, '',
				D.ChkDate, D.DocType, D.PerPost, D.ChkNbr, D.Sub,
				D.CpnyID, D.LUpd_DateTime, D.LUpd_Prog, D.LUpd_User,
				@ComputerName, @EBFileNbr, 0, 0,
				'C', 
				Case when F.CrLf = 1 then 'Y' else 'N' end,
				P.PPFormatID, 'P', B.EditScrnNbr, 'F',
				D.PerEnt, D.NetAmt, 'C', '10V', '20P',
				D.EmpID, 
				case when charindex('~', E.Name) > 0
					then right(rtrim(E.Name), len(rtrim(E.Name)) - charindex('~', E.Name)) 
						+ ' ' + left(E.Name, charindex('~', E.Name)-1)
					else E.Name
					end, 
				'V', 
				GetDate(), 'DD500', @UserID,
				GetDate(), 'DD500', @UserID

	   FROM		PRDoc D (NoLock) left outer join Batch B (nolock)
				ON D.BatNbr = B.BatNbr and B.Module = 'PR' left outer join XDDBank P (nolock)
				ON D.CpnyID = P.CpnyID and D.Acct = P.Acct and D.Sub = P.Sub left outer join Employee E (nolock)
				ON D.EmpID = E.EmpID left outer join XDDPPFileFormat F (nolock)
				ON P.PPFormatID = F.FormatID
	   WHERE		D.Batnbr = @BatNbr
				and ( (@InclIssues = 1 and @InclVoids = 1)
				       or
					 (@InclVoids = 0 and @InclIssues = 1 and D.Status <> 'V' and D.DocType <> 'VC')
  				       or
					 (@InclVoids = 1 and @InclIssues = 0 and (D.Status = 'V' or D.DocType = 'VC') )
				    )
	   			and D.DocType Not IN ('ZC', 'SC')		-- No Zero, Stub Checks
	
	END	-- AP or PR

	if @DemoMode = 1
		DELETE 	FROM XDDFile_Wrk 
		WHERE	ebfilenbr = @EBFileNbr
				and RecordID not in (Select Top 3 W.recordid from XDDFile_Wrk W (nolock) where W.ebfilenbr = @EBFileNbr)

