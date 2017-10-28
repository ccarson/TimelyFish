
CREATE PROCEDURE XDDBatchARLBErrors_Update_CustIDSugg
	@CustID		varchar(15),		-- may be blank or filled in
	@InvcNbr	varchar(10),		-- may be blank or filled in
	@RecordID	int,			-- xddbatcharlberrors.recordid
	@Crtd_Prog	varchar(8),
	@Crtd_User	varchar(10)
AS

	Declare @AllSameCury		tinyint
	Declare @BaseCuryID		varchar( 4 )
	Declare @CurrDate		smalldatetime
	Declare @InvBal			float
	Declare @InvBalPmtCury		float
	Declare @InvcNbrErr		varchar( 1 )
	Declare @InvcDocType		varchar( 2 )
	Declare @InvCuryID		varchar( 4 )
	Declare @PmtCuryEffDate		smalldatetime
	Declare @PmtCuryID		varchar( 4 )
	Declare @PmtCuryPrec		smallint
	Declare @PmtCuryRate		float
	Declare @PmtCuryRateType	varchar( 6 )

			
	SELECT	@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)
	SET 	@InvBalPmtCury = 0
	SET	@PmtCuryPrec = 2
	SET	@InvcNbrErr = ''
		
	-- If we're setting an Invoice number, check if the Inv. Apply Amt > Inv Balance
	if rtrim(@InvcNbr) <> '' 
	BEGIN

		-- Get InvBalPmtCury
		SELECT	@InvBalPmtCury = CuryDocBal,
			@InvCuryID = CuryID,
			@InvBal = DocBal,
			@InvcDocType = DocType
		FROM	ARDoc (nolock)
		WHERE	rtrim(RefNbr) = rtrim(@InvcNbr)
			and DocType IN ('IN', 'DM', 'FI')

		-- Multi-Currency checks
		if Exists(Select * from CMSetup (nolock))
		BEGIN
			-- Get PmtCuryID & CuryEffDate from xddbatcharlberrors.curyid
			SELECT	@PmtCuryEffDate = B.CuryEffDate,
				@PmtCuryID = B.CuryID,
				@PmtCuryRateType = B.CuryRateType,
				@PmtCuryRate = B.CuryRate
			FROM	XDDBatchARLBErrors E (nolock) LEFT OUTER JOIN XDDBatch B (nolock)
				ON E.LBBatNbr = B.BatNbr and B.FileType = 'L' and B.Module = 'AR'
			WHERE	E.RecordID = @RecordID
	
			-- What if there is no record in Currncy for this CuryID?
			SELECT	@PmtCuryPrec = c.DecPl
			FROM	Currncy c (nolock)
			WHERE	c.CuryID = @PmtCuryID
	
			-- Check if All Pending Applications (A/R & LB) for this invoice
			--	have the same CuryID and CuryRate
			--	If not, put set InvcNbrErr = 'P'
			EXEC XDDLB_Pending_Applic_Check @PmtCuryID, @PmtCuryRate,
				@CustID, @InvcNbr, 0, @AllSameCury OUTPUT

			if @AllSameCury = 0 
				SET @InvcNbrErr = 'P'
			else
			BEGIN
				-- If PmtCuryID <> InvCuryID, then must translate Inv Amts to Payment Cury
				if rtrim(@PmtCuryID) <> rtrim(@InvCuryID)
				BEGIN
		
					-- Get BaseCuryID
					SET	@BaseCuryID = ''
					SELECT	@BaseCuryID = BaseCuryID
					FROM	GLSetup (nolock)
					
					-- Translate InvBal (Base) to PmtCuryBal (Pmt Currency)
					EXEC XDDCurrency_From_To @BaseCuryID, @PmtCuryID, @PmtCuryRateType,
						@PmtCuryEffDate, @InvBal, 0, 0, '', '', @InvBalPmtCury OUTPUT
				END
			END

		END	-- Multi-Currency checks
		
	END

	UPDATE		XDDBatchARLBErrors
	SET		CustIDSugg = case when rtrim(@CustID) = ''
				then CustIDSugg
				else @CustID
				end,
			InvcNbr = case when rtrim(@InvcNbr) = ''
				then case when @CustID = ''		
					then InvcNbr
					else ''			-- blank InvcNbr if we have Good CustID, but no InvcNbr
					end
				else @InvcNbr
				end,	
			CustIDErr = case when rtrim(@CustID) = ''
				then CustIDErr
				else 'M'		-- Manual-Lookup	
				end,		
			InvcNbrErr = case when rtrim(@InvcNbr) = ''
				then case when @CustID = '' 
					then InvcNbrErr
					else ''			-- blank InvcNbrErr if we have Good CustID, but no InvcNbr
					end
				else case when @InvcNbrErr <> ''
					then @InvcNbrErr
					else case when round(InvApplyAmt - @InvBalPmtCury, @PmtCuryPrec) > 0
						then 'G'		-- Warning - InvApplyAmt > InvCuryBal
						else 'M'		-- Manual-Lookup	
						end
					end
				end,
			Selected = 1,			-- make it auto-selected...
			LUpd_DateTime = @CurrDate, 
			LUpd_Prog = @Crtd_Prog, 
			LUpd_User = @Crtd_User
	WHERE		RecordID = @RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLBErrors_Update_CustIDSugg] TO [MSDSL]
    AS [dbo];

