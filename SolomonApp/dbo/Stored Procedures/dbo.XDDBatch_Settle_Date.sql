
CREATE PROCEDURE XDDBatch_Settle_Date
	@BatNbr		varchar( 10 )
AS

	Declare 	@DateFlag	varchar( 1 )
	Declare 	@FormatID	varchar( 15 )
	Declare	        @NbrDates	int
	Declare 	@OneDate	smalldatetime
	Declare	        @RetValue	varchar( 20 )
	
	SET	@NbrDates = 0
	SET	@DateFlag = 'N'
	
	SELECT	@NbrDates = count(distinct docdate) 
	FROM	APDoc (nolock)
	WHERE	Doctype IN ('HC', 'EP') 
		and Batnbr = @BatNbr
	
	-- Determine if Settlement dates are being used at all
	-- <> 0 - we have a MCB
	if @NbrDates <> 0
	BEGIN
			-- Get FormatID for this batch
			/*
			SELECT TOP 1 @FormatID = D.FormatID
			FROM	APDoc A (nolock) left outer join XDDDepositor D (nolock) 
				ON A.VendID = D.VendID
			WHERE	A.BatNbr = @BatNbr
				and A.Doctype IN ('HC', 'EP')
				and D.VendCust = 'V'
			*/

			-- ***MVA - modified - needed to get first voucher... to get .VendAcct to get right format
			SELECT TOP 1 @FormatID = coalesce(D.FormatID, '')
			FROM	APTran T (nolock) LEFT OUTER JOIN APDoc V (nolock)
				ON T.VendID = V.VendID and T.CostType = V.DocType and T.UnitDesc = V.RefNbr  LEFT OUTER JOIN XDDDepositor D (nolock)
				ON T.VendID = D.VendID and D.VendCust = 'V' and V.eConfirm = D.VendAcct
				where 	T.batnbr = @BatNbr
					and T.DrCr = 'S'

				
			-- Now Look for any TxnTypes that are using Settlement Dates		
			-- If None, set NbrDates = 0
			if not exists(Select * from XDDTxnType (nolock) Where FormatID = @FormatID and ChkWF_CreateMCB = 'S')
				SET @NbrDates = 0
				
	END
	
	-- Returns	Multi/Date	2nd Pos		3rd Pos - Single Date
	--			N - not HC or not using Settlement dates
	--			M/D
	--			If D			Y - same dates must match
	--						N - same dates don't need to match
	-- Multiple dates, return M
	-- One Date,       return D + Date
	if @NbrDates = 0
		SET	@RetValue = 'N'
	else if @NbrDates > 1
		SET	@RetValue = 'M'
	else
	BEGIN
		SET	@OneDate = (Select Top 1 docdate
			FROM	APDoc (nolock)
			WHERE	Doctype IN ('HC', 'EP') 
				and Batnbr = @BatNbr)

		-- Check MCB - APTran - APDoc.eStatus - XDDTxnType.ChkWF_SameDate
		--	If one _SameDate = 1, then assume all are same Settlement Date in Batch
		if exists(select * from aptran T (nolock) LEFT OUTER JOIN APDoc D (nolock)
				ON T.VendID = D.VendID and T.UnitDesc = D.RefNbr and T.CostType = D.DocType LEFT OUTER JOIN XDDDepositor DD (nolock)
				ON T.VendID = DD.VendID and DD.VendCust = 'V' and D.eConfirm = DD.VendAcct LEFT OUTER JOIN XDDTxnType DT (nolock)
				ON DD.FormatID = DT.FormatID and D.eStatus = DT.eStatus
				where 	T.batnbr = @BatNbr
					and DT.ChkWF_SameDate = 1)
	
			SET	@RetValue = 'DY' + convert(varchar(10), @OneDate, 101)			
		else
			SET	@RetValue = 'DN' + convert(varchar(10), @OneDate, 101)			
		
	END	
	
	SELECT @RetValue

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatch_Settle_Date] TO [MSDSL]
    AS [dbo];

