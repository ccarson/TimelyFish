
CREATE PROCEDURE XDDDepositor_AREFT_Elig
	@CustID		varchar(15),
	@EffDate	smalldatetime,
	@FormatID	varchar(15)		-- Cash Acct Format ID to check (might be blank, if not checking)
AS

	Declare		@CustFormatID	varchar(15)
	Declare		@ReturnString	varchar(4)
--	declare		@AcctAppOption	smallint
	
	Set	@ReturnString = ''
	-- ReturnString Values
	-- "Y"		Eligible EFT Customer
	-- "N"		Not setup as EFT Customer
	-- "I"		Inactive
	-- "T"		Past Termination Date
	-- "P"		Not prenoted
	-- "F"		Format ID does not match
	-- "A"		Account not Approved (not implemented yet)
	
	-- Get Account Approval option
--   	SET	@AcctAppOption = 0
--	SELECT	@AcctAppOption = AcctApp
--	FROM	XDDSetupEX (nolock)

	-- Get Customer's Format ID
	SET	@CustFormatID = ''
	SELECT	@CustFormatID = FormatID
	FROM	XDDDepositor D (nolock)
	WHERE	D.VendCust = 'C'
		and D.VendID = @CustID
		
	if Exists (	SELECT	* 
			FROM	XDDDepositor D (nolock) LEFT JOIN XDDFileFormat F (nolock)
   				ON D.FormatID = F.FormatID
			WHERE	D.VendCust = 'C'
				and D.VendID = @CustID
				and (D.BankTransit <> '' 		-- allow for WTP as debits
				     or D.BankAcct <> ''		-- check as could be here by Lockbox
				     or D.WBeneAcct <> ''
				     or D.WBenBankSwift <> ''
				     ) 
				and ((F.PreNote = 1 and (D.PNStatus = 'A' or (D.PNStatus = 'P' and @EffDate >= D.PNDate)))
			   		or (F.PreNote = 0))
   				and D.Status = 'Y'	-- Active
   				and ( (D.TermDate = Convert(SmallDateTime, '01/01/1900')) or 	-- Not terminated
   		      			(D.TermDate <> Convert(SmallDateTime, '01/01/1900') and D.TermDate >= @EffDate)
   		    		     )
			--	and (@AcctAppOption = 0 or (@AcctAppOption <> 0 and D.AcctAppStatus = 'A'))	-- Account Approved     
   		    		and ((D.FormatID = @FormatID and @FormatID <> '') or @FormatID = '')
		)
	BEGIN
		Set	@ReturnString = 'Y'
		GOTO FINISH
	END

	else

	BEGIN
		-- 0	Not Setup
		if Not Exists (	SELECT	* 
				FROM	XDDDepositor D (nolock)
				WHERE	D.VendCust = 'C'
					and D.VendID = @CustID
					and D.BankTransit <> '' 	-- could be in XDDDepositor as Lockbox import
					and D.BankAcct <> '' 		-- could be in XDDDepositor as Lockbox import
			      )		
		BEGIN
			SET	@ReturnString = 'N'
			GOTO FINISH
		END

		-- Must Exist - then why not eligible?
		-- Inactive
		if Exists	(SELECT	*
				FROM	XDDDepositor D (nolock)
				WHERE	D.VendCust = 'C'
					and D.VendID = @CustID
					and D.BankTransit <> '' 	-- could be in XDDDepositor as Lockbox import
					and D.BankAcct <> '' 		-- could be in XDDDepositor as Lockbox import
					and D.Status <> 'Y'
				)
			SET	@ReturnString = @ReturnString + 'I'									

		-- Past Termination Date
		if Exists	(SELECT	*
				FROM	XDDDepositor D (nolock)
				WHERE	D.VendCust = 'C'
					and D.VendID = @CustID
					and D.BankTransit <> '' 	-- could be in XDDDepositor as Lockbox import
					and D.BankAcct <> '' 		-- could be in XDDDepositor as Lockbox import
	   				and (D.TermDate <> Convert(SmallDateTime, '01/01/1900') and D.TermDate < @EffDate)
				)
			SET	@ReturnString = @ReturnString + 'T'

		-- Not Prenoted
		if Exists 	(SELECT	* 
				FROM	XDDDepositor D (nolock) LEFT JOIN XDDFileFormat F (nolock)
   					ON D.FormatID = F.FormatID
				WHERE	D.VendCust = 'C'
					and D.VendID = @CustID
					and D.BankTransit <> '' 	-- could be in XDDDepositor as Lockbox import
					and D.BankAcct <> '' 		-- could be in XDDDepositor as Lockbox import
					and (F.PreNote = 1 and (D.PNStatus = 'N' or (D.PNStatus = 'P' and @EffDate < D.PNDate)))
				)
			SET	@ReturnString = @ReturnString + 'P'

		-- Format ID does not match
		if @FormatID <> ''
		BEGIN
			if Exists	(SELECT	*
					FROM	XDDDepositor D (nolock)
					WHERE	D.VendCust = 'C'
						and D.VendID = @CustID
						and D.FormatID <> @FormatID
					)
				SET	@ReturnString = @ReturnString + 'F'
		END

		-- Account Not Approved
--		if Exists 	(SELECT	* 
--				FROM	XDDDepositor D (nolock) LEFT JOIN XDDFileFormat F (nolock)
--   					ON D.FormatID = F.FormatID
--				WHERE	D.VendCust = 'C'
--					and D.VendID = @CustID
--					and D.BankTransit <> '' 	-- could be in XDDDepositor as Lockbox import
--					and D.BankAcct <> '' 		-- could be in XDDDepositor as Lockbox import
--					and (@AcctAppOption = 0 or (@AcctAppOption <> 0 and D.AcctAppStatus = 'A'))	-- Account Approved     
--				)
--			SET	@ReturnString = @ReturnString + 'A'

	END

FINISH:

	SELECT	@ReturnString, @CustFormatID
