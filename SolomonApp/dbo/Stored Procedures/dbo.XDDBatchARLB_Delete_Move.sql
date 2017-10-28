
CREATE PROCEDURE XDDBatchARLB_Delete_Move
	@Action		varchar(1),		-- 'D'elete, 'M'ove back to Errors table
	@LBBatNbr	varchar(10),
	@AmountChgd	float,
	@RecordID	int
	
AS
	Declare @LineNbr	smallint
	Declare @LineNbrInc	smallint
		
	SET	@LineNbrInc = 32

	-- In all cases delete applications
	DELETE FROM	XDDBatchARLBApplic
	WHERE		PmtRecordID = @RecordID
	
	-- If move, then move to Errors table
	if @Action = 'M'
	BEGIN

		-- Initialize in case no records are yet in XDDBatchARLBErrors
		SET @LineNbr	= -32768

		-- Get Highest LineNbr for the Applications for this Payment
		SELECT TOP 1	@LineNbr = LineNbr + @LineNbrInc
		FROM		XDDBatchARLBErrors (nolock)
		WHERE		LBBatNbr = @LBBatNBr
		ORDER BY	LineNbr DESC

		-- Good LBCustID goes to Errors CustID
		-- Good CustID   goes to Errors CustIDSugg
		-- Reinstate CustIDErr, CustIDSugg, InvcNbrErr		
		INSERT	XDDBatchARLBErrors
			(Acct, Amount, AmountChgd, ApplicMethod, 
			BankAcct, BankTransit, CpnyID,
			Crtd_DateTime, Crtd_Prog, Crtd_User, CuryID,
			CustID, 	-- comes from Good LBCustID
			CustIDErr, 
			CustIDSugg, 	-- comes from Good CustID
			CustName, Descr, DocDate, DocType, 
			FileDate, FilePathName, FileRecord, FormatID, 
			InvApplyAmt, InvcNbr, InvcNbrErr, LBBatNbr, LineNbr,
			LUpd_DateTime, LUpd_Prog, LUpd_User,
			RefNbr,	Sub)
		SELECT 	Acct, Amount, @AmountChgd, ApplicMethod, 
			BankAcct, BankTransit, CpnyID,
			Crtd_DateTime, Crtd_Prog, Crtd_User, CuryID,
			LBCustID,	-- goes to Errors CustID
			CustIDErr, 
			CustID, 	-- goes to Errors CustIDSugg
			CustName, Descr, DocDate, DocType, 
			FileDate, FilePathName, FileRecord, FormatID, 
			InvApplyAmt, InvcNbr, InvcNbrErr, LBBatNbr, @LineNbr,
			LUpd_DateTime, LUpd_Prog, LUpd_User,
			RefNbr, Sub
		FROM	XDDBatchARLB
		WHERE	RecordID = @RecordID
	
	END
	
	-- Now delete the XDDBatchARLB record
	DELETE FROM	XDDBatchARLB
	WHERE		RecordID = @RecordID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_Delete_Move] TO [MSDSL]
    AS [dbo];

