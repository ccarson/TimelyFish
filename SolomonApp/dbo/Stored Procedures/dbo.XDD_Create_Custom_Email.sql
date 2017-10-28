
create procedure XDD_Create_Custom_Email
	@EBFileNbr	varchar( 6 ),		-- Key for XDDFile_Wrk table
	@FileType	varchar( 1 ),		-- E-AP-EFT, R-AR-EFT, W-Wire XFer, X-Wire Xfer/AREFT, P-Pos Pay
	@VendCustID	varchar( 15 ),		-- AP, then VendID, AR, then CustID
	@VendAcct	varchar( 10 )
As

	declare @AP_EMCpnyName		varchar( 30 )
	declare @AR_EMCpnyName		varchar( 30 )
	declare @Attachment		bit
	declare @ChkAcct		varchar( 10 )
	declare @ChkDocDate		smalldatetime
	declare @ChkDocType		varchar( 2 )
	declare @ChkInvAmt		float
	declare @ChkCuryAmt		float
	declare @ChkCuryDiscAmt		float
	declare @ChkCpnyID		varchar( 10 )
	declare @ChkRefNbr		varchar( 10 )
	declare @ChkSub			varchar( 24 )
	declare @CuryAmt		float
	declare @CuryDiscAmt		float
	declare @ColSpace		varchar( 10 )
	declare @ColWidth		smallint
	declare @DataChar		varchar( 50 )
	declare @DataDate		smalldatetime
	declare @DataFloat		float
	declare @DepBankAcct		varchar( 30 )
	declare @DepBankTransit		varchar( 30 )
	declare @DepTranOption		varchar( 1 )
	declare @DepTranUseCo		smallint
	declare @DocCnt			smallint
	declare	@EMailNote		varchar( 30 )
	declare @EMAttachFromSetup	smallint
	declare @EMAttachFF 		varchar( 1 )	-- File Format
	declare @EMAttachNbrDocs 	smallint	-- Nbr of Docs before attachment
	declare	@EMUser1 		varchar( 30 )
	declare	@EMUser2 		varchar( 30 )
	declare	@EMUser3 		varchar( 30 )
	declare	@EMUser4 		varchar( 30 )
	declare	@EMUser5 		varchar( 30 )
	declare	@EMUser6 		varchar( 30 )
	declare	@EMUser7 		varchar( 30 )
	declare	@EMUser8 		varchar( 30 )
	declare @EntryClass		varchar( 4 )
	declare @FileFormat		varchar( 1 )
	declare @FirstRec		bit
	declare @FirstChkInv		bit
	declare @FixedLen		smallint
	declare @FormatID		varchar( 15 )
	declare @i			tinyint
	declare @Indent3		varchar( 3 )
	declare @Indent5		varchar( 5 )
	declare @Indent7		varchar( 7 )
	declare @IndentHTranDetails	varchar( 30 )
	declare @InvcAmt		float
	declare @InvcNbr		varchar( 15 )
	declare @LastEffDate		smalldatetime
	declare @LineFull		varchar( 510 )
	declare @Module			varchar( 2 )
	declare @MsgLayout		varchar( 1 )
	declare @NbrDocs		smallint
	declare @RefNbr			varchar( 10 )
	declare @SetupTranOption	varchar( 1 )
	declare	@SetupEMUser1 		varchar( 30 )
	declare	@SetupEMUser2 		varchar( 30 )
	declare	@SetupEMUser3 		varchar( 30 )
	declare	@SetupEMUser4 		varchar( 30 )
	declare	@SetupEMUser5 		varchar( 30 )
	declare	@SetupEMUser6 		varchar( 30 )
	declare	@SetupEMUser7 		varchar( 30 )
	declare	@SetupEMUser8 		varchar( 30 )
	declare	@SetupTUser1 		varchar( 30 )
	declare	@SetupTUser2 		varchar( 30 )
	declare	@SetupTUser3 		varchar( 30 )
	declare	@SetupTUser4 		varchar( 30 )
	declare	@SetupTUser5 		varchar( 30 )
	declare	@SetupTUser6 		varchar( 30 )
	declare	@SetupTUser7 		varchar( 30 )
	declare	@SetupTUser8 		varchar( 30 )
	declare	@TranOption		varchar( 1 )
	declare @Tab			varchar( 1 )
	declare	@TranUser1 		varchar( 30 )
	declare	@TranUser2 		varchar( 30 )
	declare	@TranUser3 		varchar( 30 )
	declare	@TranUser4 		varchar( 30 )
	declare	@TranUser5 		varchar( 30 )
	declare	@TranUser6 		varchar( 30 )
	declare	@TranUser7 		varchar( 30 )
	declare	@TranUser8 		varchar( 30 )
	declare @VchCuryAmt		float
	declare @VchCuryDiscAmt		float
	declare @VchDocType		varchar( 2 )
	declare @VchInvcDate		smalldatetime
	declare @VchInvcNbr		varchar( 15 )
	declare @VchRefNbr		varchar( 10 )
	declare @VchUser1		varchar( 30 )
	declare @VchUser2		varchar( 30 )
	declare @VchUser3		float	
	declare @VchUser4		float	
	declare @VchUser5		varchar( 10 )	
	declare @VchUser6		varchar( 10 )
	declare @VchUser7		smalldatetime	
	declare @VchUser8		smalldatetime
	declare @VendCust		varchar( 1 )
	declare @VendCustName		varchar( 30 )
	declare @WBenBankName		varchar( 35 )
	declare @WBenBankSwift		varchar( 35 )
	declare @WBenBankAcct		varchar( 35 )
	
	declare @dummy			bit

	-- Custom Email Meesage
	--	Either in the body of the mail
	--  OR  As an attachment
	
	-- How it is determined whether the message will be in the email or added as an attachment
	-- NbrDocs	Number of documents to trigger an attachment
	--		0 - no attachment, custom message goes inside email
	--		1-n if a vendor has more than n documents, then add an attachment
	--			less than n, then custom message goes in the email
	--		So if NbrDocs = 1, then all documents go in an attachment

	-- IF an attachment:	
	-- FileFormat	C-csv, T-tab, F-fixed field
	--		ONLY used if NbrDocs >= n

	-- ---------------------------------------------------------------------
	-- Set Constants
	-- ---------------------------------------------------------------------
	-- Set tab character
	SET @Tab = Char(9)
	
	-- For Horizontal layout, set column width = 14 characters & space between columns = 2
	SET @ColWidth = 14
	SET @ColSpace = Space(2)

	-- Set up standard indentations (spaces)
	SET	@Indent3 = Space(3)
	SET	@Indent5 = Space(5)
	SET	@Indent7 = Space(7)
	SET	@IndentHTranDetails = Space(@ColWidth) + @ColSpace
	
	-- Set Module
	if @FileType IN ('R', 'X')
		SET @Module = 'AR'
	else
		SET @Module = 'AP'

	-- ---------------------------------------------------------------------
	-- Get Vendor/Customer Banking Entry settings
	-- ---------------------------------------------------------------------
	-- Get values from XDDDepositor
	if @Module = 'AR' 
		SET @VendCust = 'C'
	else
		SET @VendCust = 'V'
			
	SELECT		@EMAttachFromSetup = EMAttachFromSetup,
			@EMAttachFF = EMAttachFF,
			@EMAttachNbrDocs = EMAttachNbrDocs,
			@DepTranUseCo = EMAPTranUseCo,
			@DepTranOption = EMAPTran
	FROM		XDDDepositor (nolock)
	WHERE		VendCust = @VendCust
			and VendID = @VendCustID
			and VendAcct = @VendAcct

	-- ---------------------------------------------------------------------
	-- Get eBanking Setup settings
	-- ---------------------------------------------------------------------
	-- Use either Setup values or XDDDepositor values - based on XDDDepositor.EMAttachFromSetup
	SELECT  @FileFormat = case when @EMAttachFromSetup = 1
			then case when @Module = 'AR' 
				then AREMAttachFF
				else APEMAttachFF
				end
			else @EMAttachFF
			end,	
			@NbrDocs = case when @EMAttachFromSetup = 1
			then case when @Module = 'AR' 
				then AREMAttachNbrDocs
				else APEMAttachNbrDocs
				end
			else @EMAttachNbrDocs
			end	
	FROM	XDDSetupEx (nolock)

	-- Vertical/Horizontal layout
	SELECT	@MsgLayout = case when @Module = 'AR'
				then AREMStubLayout
				else EMStubLayout
				end,
		@SetupTranOption = case when @Module = 'AR'
				then AREMARTran
				else EMAPTran
				end,
		@SetupTUser1 = case when @Module = 'AR'
				then AREMTUser1
				else EMTUser1
				end,
		@SetupTUser2 = case when @Module = 'AR'
				then AREMTUser2
				else EMTUser2
				end,		
		@SetupTUser3 = case when @Module = 'AR'
				then AREMTUser3
				else EMTUser3
				end,		
		@SetupTUser4 = case when @Module = 'AR'
				then AREMTUser4
				else EMTUser4
				end,		
		@SetupTUser5 = case when @Module = 'AR'
				then AREMTUser5
				else EMTUser5
				end,		
		@SetupTUser6 = case when @Module = 'AR'
				then AREMTUser6
				else EMTUser6
				end,		
		@SetupTUser7 = case when @Module = 'AR'
				then AREMTUser7
				else EMTUser7
				end,		
		@SetupTUser8 = case when @Module = 'AR'
				then AREMTUser8
				else EMTUser8
				end,
		@SetupEMUser1 = case when @Module = 'AR'
				then AREMUser1
				else EMUser1
				end,		
		@SetupEMUser2 = case when @Module = 'AR'
				then AREMUser2
				else EMUser2
				end,		
		@SetupEMUser3 = case when @Module = 'AR'
				then AREMUser3
				else EMUser3
				end,		
		@SetupEMUser4 = case when @Module = 'AR'
				then AREMUser4
				else EMUser4
				end,		
		@SetupEMUser5 = case when @Module = 'AR'
				then AREMUser5
				else EMUser5
				end,		
		@SetupEMUser6 = case when @Module = 'AR'
				then AREMUser6
				else EMUser6
				end,		
		@SetupEMUser7 = case when @Module = 'AR'
				then AREMUser7
				else EMUser7
				end,		
		@SetupEMUser8 = case when @Module = 'AR'
				then AREMUser8
				else EMUser8
				end	
	FROM	XDDSetup (nolock)

	-- Determine Document Count in this file	
	SELECT		@DocCnt = Count(Distinct ChkRefNbr)
	FROM        	XDDFile_Wrk (nolock)
	WHERE		EBFileNbr = @EBFileNbr
			and FileType = @FileType
			and VendID = @VendCustID
			and VendAcct = @VendAcct

	-- Determine if we're creating an attachment or in body of email
	-- If the Vendor/Customer Nbr of Documents (Checks/Invoices)
	--	>= the Vendor/Customer setting, then create an attachment
	--	But special case, when NbrDocs = 0, then always no attachment

	if @DocCnt >= @NbrDocs and @NbrDocs <> 0
		SET 	@Attachment = 1
	else
		SET		@Attachment = 0	


	-- ---------------------------------------------------------------------
	-- Create Temp Table to write rsults to - Max: 510 line width
	-- ---------------------------------------------------------------------

	-- #TempTable holds lines of the message or output file
	CREATE TABLE #TempTable
	(	LineOut			char ( 255 )	NOT NULL,
		LineOutPlus		char ( 255 )	NOT NULL
	)

	-- ---------------------------------------------------------------------
	-- Navigate thru XDDFile_Wrk for this Vendor/Customer
	-- ---------------------------------------------------------------------
	-- Cursor through each record in the eBanking Working Table
	--	XDDFile_Wrk:
	--		Keyed on EBFileNbr & FileType
	--		Has one record for each voucher (AP) or invoice (AR)
	--		VendID has VendID when AP and CustID when AR

	if @Module = 'AP' 

		DECLARE         Wrk_Cursor CURSOR LOCAL FAST_FORWARD
		FOR
		SELECT 		W.ChkRefNbr,
				W.ChkCuryAmt,
				W.ChkCpnyID,
				W.ChkAcct,
				W.ChkSub, 
				W.ChkDocDate,
				W.ChkCuryDiscAmt,
				W.ChkDocType,
				B.AREMCpnyName,
				B.EMCpnyName,
				W.VendName,
				F.LastEffDate,
				W.DepBankTransit,
				W.DepBankAcct,
				D.WBenBankName,
				D.WBenBankSwift,
				D.WBenBankAcct,
				W.VchRefNbr,
				W.VchDocType,
				W.VchInvcDate,
				W.VchInvcNbr,
				W.VchCuryAmt,
				W.VchCuryDiscAmt,
				W.FormatID,
				W.DepEntryClass,
				W.VchUser1,
				W.VchUser2,
				W.VchUser3,
				W.VchUser4,	
				W.VchUser5,
				W.VchUser6,
				W.VchUser7,
				W.VchUser8
		FROM            XDDFile_Wrk W (nolock) LEFT OUTER JOIN XDDBank B (nolock)
				ON W.ChkCpnyID = B.CpnyID and W.ChkAcct = B.Acct and W.ChkSub = B.Sub LEFT OUTER JOIN XDDDepositor D (nolock)
				ON W.VendCust = D.VendCust and W.VendID = D.VendID and W.VendAcct = D.VendAcct LEFT OUTER JOIN XDDFileFormat F (nolock)
				ON W.FormatID = F.FormatID
		WHERE		W.EBFileNbr = @EBFileNbr
				and W.FileType = @FileType
				and W.VendID = @VendCustID
				and W.VendAcct = @VendAcct
	
		ORDER BY	ChkRefNbr, VchRefNbr

	else

		DECLARE         Wrk_Cursor CURSOR LOCAL FAST_FORWARD
		FOR
		SELECT 		W.ChkRefNbr,
				W.ChkCuryAmt,
				W.ChkCpnyID,
				W.ChkAcct,
				W.ChkSub, 
				W.ChkDocDate,
				W.ChkCuryDiscAmt,
				W.ChkDocType,
				B.AREMCpnyName,
				B.EMCpnyName,
				W.VendName,
				F.LastEffDate,
				W.DepBankTransit,
				W.DepBankAcct,
				D.WBenBankName,
				D.WBenBankSwift,
				D.WBenBankAcct,
				W.VchRefNbr,
				W.VchDocType,
				W.VchInvcDate,
				W.VchInvcNbr,
				W.VchCuryAmt,
				W.VchCuryDiscAmt,
				W.FormatID,
				W.DepEntryClass,
				W.VchUser1,
				W.VchUser2,
				W.VchUser3,
				W.VchUser4,	
				W.VchUser5,
				W.VchUser6,
				W.VchUser7,
				W.VchUser8
		FROM            XDDFile_Wrk W (nolock) LEFT OUTER JOIN XDDBank B (nolock)
				ON W.ChkCpnyID = B.CpnyID and W.ChkAcct = B.Acct and W.ChkSub = B.Sub LEFT OUTER JOIN XDDDepositor D (nolock)
				ON W.VendCust = D.VendCust and W.VendID = D.VendID and W.VendAcct = D.VendAcct LEFT OUTER JOIN XDDFileFormat F (nolock)
				ON W.FormatID = F.FormatID
		WHERE		W.EBFileNbr = @EBFileNbr
				and W.FileType = @FileType
				and W.VendID = @VendCustID
				and W.VendAcct = @VendAcct

		-- for A/R VchRefNbr = Payment Number, ChkRefNbr = Invoice Number
		ORDER BY	VchRefNbr, ChkRefNbr
	

	if (@@error <> 0) GOTO ABORT

	OPEN Wrk_Cursor

	Fetch Next From Wrk_Cursor into
	@ChkRefNbr,
	@ChkCuryAmt,
	@ChkCpnyID,
	@ChkAcct,
	@ChkSub, 
	@ChkDocDate,
	@ChkCuryDiscAmt,
	@ChkDocType,
	@AR_EMCpnyName,
	@AP_EMCpnyName,
	@VendCustName,
	@LastEffDate,
	@DepBankTransit,
	@DepBankAcct,
	@WBenBankName,
	@WBenBankSwift,
	@WBenBankAcct,
	@VchRefNbr,
	@VchDocType,
	@VchInvcDate,
	@VchInvcNbr,
	@VchCuryAmt,
	@VchCuryDiscAmt,
	@FormatID,
	@EntryClass,
	@VchUser1,
	@VchUser2,
	@VchUser3,
	@VchUser4,
	@VchUser5,
	@VchUser6,
	@VchUser7,
	@VchUser8
			
	SET @FirstRec = 1

/* Uncomment if needing custom top message
-- Custom Top Message (if adding here, then uncheck using Std Top Msg in Vendor/Customer Banking Entry)
    SET @LineFull = 'First Line of custom top msg'
    EXEC XDDEmail_Insert @LineFull

    SET @LineFull = 'Second line of custom top msg'
    EXEC XDDEmail_Insert @LineFull

    SET @LineFull = 'etc., etc.'
    EXEC XDDEmail_Insert @LineFull
*/
	
	-- Loop thru all checkes/invoices for a vendor/customer
	While (@@Fetch_Status = 0)
	BEGIN

		-- --------------------------------------------------
		-- Get XDDBank values for Cpny/Acct/Sub
		--	Key is based on records found in XDDFile_Wrk
		-- --------------------------------------------------
		-- These might be used, or XDDSetup might be used
		SELECT	@MsgLayout = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @MsgLayout
					else AREMStubLayout
					end
				else case when EMFromSetup = 1
					then @MsgLayout
					else EMStubLayout
					end
				end,
			@TranOption = case when @DepTranUseCo = 1		-- from XDDDepositor
				then case when @Module = 'AR'
					then case when AREMFromSetup = 1
						then @SetupTranOption
						else AREMARTran 
						end 	
					else case when EMFromSetup = 1
						then @SetupTranOption
						else EMAPTran 
						end 
					end	
				else @DepTranOption
				end,
			@TranUser1 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupTUser1
					else AREMTUser1
					end
				else case when EMFromSetup = 1
					then @SetupTUser1
					else EMTUser1
					end
				end,
			@TranUser2 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupTUser2
					else AREMTUser2
					end
				else case when EMFromSetup = 1
					then @SetupTUser2
					else EMTUser2
					end
				end,
			@TranUser3 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupTUser3
					else AREMTUser3
					end
				else case when EMFromSetup = 1
					then @SetupTUser3
					else EMTUser3
					end
				end,
			@TranUser4 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupTUser4
					else AREMTUser4
					end
				else case when EMFromSetup = 1
					then @SetupTUser4
					else EMTUser4
					end
				end,
			@TranUser5 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupTUser5
					else AREMTUser5
					end
				else case when EMFromSetup = 1
					then @SetupTUser5
					else EMTUser5
					end
				end,
			@TranUser6 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupTUser6
					else AREMTUser6
					end
				else case when EMFromSetup = 1
					then @SetupTUser6
					else EMTUser6
					end
				end,
			@TranUser7 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupTUser7
					else AREMTUser7
					end
				else case when EMFromSetup = 1
					then @SetupTUser7
					else EMTUser7
					end
				end,
			@TranUser8 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupTUser8
					else AREMTUser8
					end
				else case when EMFromSetup = 1
					then @SetupTUser8
					else EMTUser8
					end
				end,
			@EMUser1 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupEMUser1
					else AREMUser1
					end
				else case when EMFromSetup = 1
					then @SetupEMUser1
					else EMUser1
					end
				end,
			@EMUser2 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupEMUser2
					else AREMUser2
					end
				else case when EMFromSetup = 1
					then @SetupEMUser2
					else EMUser2
					end
				end,
			@EMUser3 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupEMUser3
					else AREMUser3
					end
				else case when EMFromSetup = 1
					then @SetupEMUser3
					else EMUser3
					end
				end,
			@EMUser4 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupEMUser4
					else AREMUser4
					end
				else case when EMFromSetup = 1
					then @SetupEMUser4
					else EMUser4
					end
				end,
			@EMUser5 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupEMUser5
					else AREMUser5
					end
				else case when EMFromSetup = 1
					then @SetupEMUser5
					else EMUser5
					end
				end,
			@EMUser6 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupEMUser6
					else AREMUser6
					end
				else case when EMFromSetup = 1
					then @SetupEMUser6
					else EMUser6
					end
				end,
			@EMUser7 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupEMUser7
					else AREMUser7
					end
				else case when EMFromSetup = 1
					then @SetupEMUser7
					else EMUser7
					end
				end,
			@EMUser8 = case when @Module = 'AR'
				then case when AREMFromSetup = 1
					then @SetupEMUser8
					else AREMUser8
					end
				else case when EMFromSetup = 1
					then @SetupEMUser8
					else EMUser8
					end
				end
		FROM	XDDBank (nolock)
		WHERE	CpnyID = @ChkCpnyID
			and Acct = @ChkAcct
			and Sub = @ChkSub
			
		-- ---------------------------------------------------------
		-- Header information for a Vendor/Customer (once per)
		-- ---------------------------------------------------------
		-- Company Name
		-- Vendor/Customer Name (ID)
		-- Payment Date
		if @FirstRec = 1
		BEGIN

		-- NOTE: when creating an attachment you might not want to use these fields
		
			-- -------------------------------------------------
			-- ALWAYS PRINTED FIELDS
			-- -------------------------------------------------
			if @Module = 'AR'
			BEGIN
				-- Company Name
				SET @LineFull = @AR_EMCpnyName
				EXEC XDDEmail_Insert @LineFull

				-- Customer Name/ID
				SET @LineFull = 'Customer: ' + rtrim(@VendCustName) + ' (' + @VendCustID + ')'
				EXEC XDDEmail_Insert @LineFull

				-- Payment Date
				SET @LineFull = 'Payment Date: ' + convert(varchar, @LastEffDate, 101)
				EXEC XDDEmail_Insert @LineFull

			END
			
			else
			
			BEGIN
				-- Company Name
				SET @LineFull = @AP_EMCpnyName
				EXEC XDDEmail_Insert @LineFull

				-- Vendor Name/ID
				SET @LineFull = 'Vendor: ' + rtrim(@VendCustName) + ' (' + @VendCustID + ')'
				EXEC XDDEmail_Insert @LineFull

				-- Deposit Date
				SET @LineFull = 'Deposit Date: ' + convert(varchar, @LastEffDate, 101)
				EXEC XDDEmail_Insert @LineFull
			END
    
		        -- -------------------------------------------------
		        -- OPTIONAL FIELDS
		        -- -------------------------------------------------
			-- Fields below - uncomment if needed/wanted
			
-- May not want to have this (Transit/Routing) in the email/attachment - for security reasons
--	Uncomment, if needed 
			-- Transit/Routing
--			SET @LineFull = 'Transit/Routing Number: ' + @DepBankTransit + '/' + @DepBankAcct
--			EXEC XDDEmail_Insert @LineFull

			-- Wire Transfer
--			if @FileType = 'W'
--			BEGIN
				-- Beneficiary Bank Name
--				SET @LineFull = 'Beneficiary Bank: ' + @WBenBankName
--				EXEC XDDEmail_Insert @LineFull

				-- Beneficiary Bank SWIFT
--				SET @LineFull = 'Beneficiary Bank: ' + @WBenBankSWIFT
--				EXEC XDDEmail_Insert @LineFull

				-- Beneficiary Bank Acct
--				SET @LineFull = 'Beneficiary Bank: ' + @WBenBankAcct
--				EXEC XDDEmail_Insert @LineFull

--			END
		
			SET @FirstRec = 0
		END

		-- ---------------------------------------------------------
		-- Single Document Loop (AP-EFT - Check, AR-EFT - Invoice)
		-- ---------------------------------------------------------

		-- for A/R VchRefNbr = Payment Number, ChkRefNbr = Invoice Number
		if @Module = 'AR'
		BEGIN
			SET @InvcNbr = @ChkRefNbr
			SET @ChkRefNbr = @VchRefNbr
		END
		
		SET @RefNbr = @ChkRefNbr		
		SET @FirstChkInv = 1

		-- Loop thru all checkes/invoices for a vendor/customer
		While (@@Fetch_Status = 0 and rtrim(@ChkRefNbr) = @RefNbr)
		BEGIN
			-- -----------------------------------------------
			-- Our Payment Number: ......
			-- -----------------------------------------------
			if @Module = 'AR'
			BEGIN
				-- --------------------
				-- AR-EFT
				-- --------------------

				-- --------------------
				--	Vertical
				-- --------------------
				--    If Doc/Record = Invoice
				--    Our Payment Number: EFT..., Amount: ChkAmt
				--      InvcNbr: xxxxx
				--        InvcDate: mm/dd/yy
				--        InvcAmt: 99999
				--        Amount Paid: 99999
				--        If Details
				--          Description: 99999
				--        Disc Taken: 99999
				--        User1: xxxxx
				--      InvcNbr: xxxxx
				--        ...

				-- --------------------
				--	Horizontal
				-- --------------------
				--    If Doc/Record = Invoice
				--    Our Payment Number: EFT...., Amount: ChkAmt
				--    Invc Nbr    Invc Date   Invc Amt    Amt Paid    Disc Taken  Userfields
				--    xxxxx       mm/dd/yy    99999999    EFT Amt     Disc Amt
				--    xxxxx       mm/dd/yy    99999999    EFT Amt     Disc Amt
				--    If Details
				--              Description             Tran Amt
				--    Tran1
				--    Tran2
				
				if @FirstChkInv = 1
				BEGIN

					EXEC XDDEmail_Insert ''

					-- Accumulate Voucher Amts - for the full payment amount
					-- This differs from A/P
					SELECT	@ChkInvAmt = sum(case when ChkDocType = 'CM'
								then -RecordSumAmt
								else RecordSumAmt
								end)
					FROM	XDDFile_Wrk (nolock)
					WHERE	EBFileNbr = @EBFileNbr
						and FileType = @FileType
						and VendID = @VendCustID
						and VendAcct = @VendAcct
						and rtrim(VchRefNbr) = @RefNbr		-- VchRefNbr has Payment Number
						and RecordSummary <> 'X'

					-- VchRefNbr is our internal payment application number (since this is done via EFT)
					--	It is created during the Keep process
					-- If Comma delimited, doen't include comma

					SET @LineFull = 'Our Payment Number: ' + rtrim(@VchRefNbr) + ', Amount: ' + convert(varchar,cast(@ChkInvAmt as Money), 1)
					-- If Comma delimited attachment, Remove any commas
					if @Attachment = 1 and @FileFormat = 'C'
						SET @LineFull = Replace(@LineFull, ',', '') 

					EXEC XDDEmail_Insert @LineFull

					if @MsgLayout = 'H'
					BEGIN
						--               ....5....0....5....2....5....3....5....4....5....5....6....5....7....5
						-- All fields 14 long, 2 char spacing between columns
						--		 ....5....0.... 
						--		                 ....5....0....
						--		                                 ....5....0....
						--		                                                 ....5....0....
						--		                                                                 ....5....0....
						SET @LineFull = 'Invoice Number  Invoice Date    Invoice Amount      Amout Paid  Discount Taken  '
					END

				END
			
			END	-- AR-EFT
			
			else
			
			BEGIN
				-- --------------------
				-- AP-EFT / Wire
				-- --------------------

				-- --------------------
				--	Vertical
				-- --------------------
				--    Our Payment Number: ChkNbr, Amount: ChkAmt (only if by Check)
				--      InvcNbr: xxxxx
				--        RefNbr: V1
				--        InvcDate: mm/dd/yy
				--        InvcAmt: 99999
				--        Amount Paid: 99999
				--        If Details
				--          Description: 99999, User1: xxxx, User2: xxxx
				--        Disc Taken: 99999
				--        User1: xxxxx
				--      InvcNbr: xxxxx
				--        RefNbr: V2
				--        ...

				-- --------------------
				--	Horizontal
				-- --------------------
				--    If Doc/Record = Voucher or Check
				--     Our Payment Number: ChkNbr, Amount: ChkAmt (only if by Check)
				--     Invc Nbr  RefNbr      Invc Date   Invc Amt    Amt Paid    Disc Taken  Userfields
				--     V1        xxxxx       mm/dd/yy    99999999
				--     If Details
				--               Description             Tran Amt
				--     V2
				--     V3

				
				if @FirstChkInv = 1
				BEGIN

					EXEC XDDEmail_Insert ''

					-- Accumulate Voucher Amts - for the full payment amount
					SELECT	@ChkInvAmt = sum(case when VchDocType = 'AD'
								then -VchCuryAmt
								else VchCuryAmt
								end)
					FROM	XDDFile_Wrk (nolock)
					WHERE	EBFileNbr = @EBFileNbr
						and FileType = @FileType
						and VendID = @VendCustID
						and VendAcct = @VendAcct
						and rtrim(ChkRefNbr) = @RefNbr

					SET @LineFull = 'Our Payment Number: ' + rtrim(@ChkRefNbr) + ', Amount: ' + convert(varchar,cast(@ChkInvAmt as Money), 1)
					-- If Comma delimited attachment, Remove any commas
					if @Attachment = 1 and @FileFormat = 'C'
						SET @LineFull = Replace(@LineFull, ',', '') 

					EXEC XDDEmail_Insert @LineFull

					if @MsgLayout = 'H'
					BEGIN
						--               ....5....0....5....2....5....3....5....4....5....5....6....5....7....5
						-- All fields 14 long, 2 char spacing between columns
						--		 ....5....0.... 
						--		                 ....5....0....
						--		                                 ....5....0....
						--		                                                 ....5....0....
						--		                                                                 ....5....0....
						--		                                                                                 ....5....0....
						SET @LineFull = 'Invoice Number  Reference Nbr   Invoice Date    Invoice Amount      Amout Paid  Discount Taken  '
					END

				END
			END 	-- AP/AR EFT

			-- -----------------------------------------------
			-- Headings for the Check/Invoice		
			-- -----------------------------------------------
			if @FirstChkInv = 1
			BEGIN		
				if @Attachment = 0 and @MsgLayout = 'H'
				BEGIN
					if rtrim(@EMUser1) <> '' and rtrim(@VchUser1) <> ''
						SET @LineFull = @LineFull + left(@EMUser1 + Space(@ColWidth), @ColWidth) + @ColSpace
					if rtrim(@EMUser2) <> '' and rtrim(@VchUser2) <> ''
						SET @LineFull = @LineFull + left(@EMUser2 + Space(@ColWidth), @ColWidth) + @ColSpace
					if rtrim(@EMUser3) <> '' and rtrim(@VchUser3) <> ''
						SET @LineFull = @LineFull + left(@EMUser3 + Space(@ColWidth), @ColWidth) + @ColSpace
					if rtrim(@EMUser4) <> '' and rtrim(@VchUser4) <> ''
						SET @LineFull = @LineFull + left(@EMUser4 + Space(@ColWidth), @ColWidth) + @ColSpace
					if rtrim(@EMUser5) <> '' and rtrim(@VchUser5) <> ''
						SET @LineFull = @LineFull + left(@EMUser5 + Space(@ColWidth), @ColWidth) + @ColSpace
					if rtrim(@EMUser6) <> '' and rtrim(@VchUser6) <> ''
						SET @LineFull = @LineFull + left(@EMUser6 + Space(@ColWidth), @ColWidth) + @ColSpace
					if rtrim(@EMUser7) <> '' and rtrim(@VchUser7) <> ''
						SET @LineFull = @LineFull + left(@EMUser7 + Space(@ColWidth), @ColWidth) + @ColSpace
					if rtrim(@EMUser8) <> '' and rtrim(@VchUser8) <> ''
						SET @LineFull = @LineFull + left(@EMUser8 + Space(@ColWidth), @ColWidth) + @ColSpace

					SET @LineFull = rtrim(@LineFull)
					EXEC XDDEmail_Insert @LineFull
				END

				-- Headings for Attachment - set for each new Chk/Inv Number
				if @Attachment = 1
				BEGIN
					-- AR-EFT
					-- 'Invoice Number  Invoice Date    Invoice Amount      Amout Paid  Discount Taken  '
					-- AP-EFT
					-- 'Invoice Number  Reference Nbr   Invoice Date    Invoice Amount      Amout Paid  Discount Taken  '

					SET @LineFull = ''
					SET @i = 1
					SET @FixedLen = 16
					While (@i <= 14)
					BEGIN
						
						SET @DataChar = ''
						if @i = 1			                 SET @DataChar = 'Invoice Number'
						if @i = 2 and @Module = 'AP'	     SET @DataChar = 'Reference Nbr'
						if @i = 3 			                 SET @DataChar = 'Invoice Date'
						if @i = 4 			                 SET @DataChar = 'Invoice Amount'
						if @i = 5 			                 SET @DataChar = 'Amount Paid'
						if @i = 6 			                 SET @DataChar = 'Discount Taken'
						if @i = 7  and rtrim(@EMUser1) <> '' SET @DataChar = @EMUser1	
						if @i = 8  and rtrim(@EMUser2) <> '' SET @DataChar = @EMUser2	
						if @i = 9  and rtrim(@EMUser3) <> '' SET @DataChar = @EMUser3	
						if @i = 10 and rtrim(@EMUser4) <> '' SET @DataChar = @EMUser4	
						if @i = 11 and rtrim(@EMUser5) <> '' SET @DataChar = @EMUser5	
						if @i = 12 and rtrim(@EMUser6) <> '' SET @DataChar = @EMUser6	
						if @i = 13 and rtrim(@EMUser7) <> '' SET @DataChar = @EMUser7	
						if @i = 14 and rtrim(@EMUser8) <> '' SET @DataChar = @EMUser8	
						
						if @DataChar <> ''
						BEGIN
							if @FileFormat = 'C'
								SET @LineFull = @LineFull + ltrim(@DataChar) + ','
							if @FileFormat = 'T'
								SET @LineFull = @LineFull + ltrim(@DataChar) + @Tab
							if @FileFormat = 'F'
								SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen)
						END
						SET @i = @i + 1
					END					

					-- If Comma or Tab delimited, remove last comma/tab
					if (@FileFormat = 'C' or @FileFormat = 'T')
						SET @LineFull = left(@LineFull, len(@LineFull) - 1)

					EXEC XDDEmail_Insert @LineFull
				
				END	-- Attachment
				
				SET @FirstChkInv = 0
			END
			
			SET @LineFull = ''

			-- -----------------------------------------------
			-- -----------------------------------------------
			--
			-- DETAILS FOR A CHECK or an INVOICE
			--	
			-- -----------------------------------------------
			-- -----------------------------------------------

			-- ----------------------------------------------
			-- Invoice Number						
			-- ----------------------------------------------
			if @Module = 'AR'
				SET @DataChar = rtrim(@InvcNbr)		-- comes from xddfile_wrk.ChkRefNbr for A/R
			else
				SET @DataChar = rtrim(@VchInvcNbr)

			if @Attachment = 0
			BEGIN
				if @MsgLayout = 'V'
				BEGIN
					-- Blank line before every invoice
					EXEC XDDEmail_Insert ' '
					SET @LineFull = @Indent3 + 'Invoice Number: ' + rtrim(@DataChar)
					EXEC XDDEmail_Insert @LineFull
				END
				else
				BEGIN
					SET @LineFull = @LineFull +  + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
				END
			END
			else
			BEGIN
				if @FileFormat = 'C'
				BEGIN
					-- If Comma delimited attachment, first remove any commas
					SET @DataChar = Replace(@DataChar, ',', '') 
					SET @LineFull = @LineFull + @DataChar + ','
				END
				if @FileFormat = 'T'
					SET @LineFull = @LineFull + @DataChar + @Tab
				if @FileFormat = 'F'
				BEGIN
					SET @FixedLen = 14
					SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
				END
			END	

			-- ----------------------------------------------
			-- Reference Number
			-- ----------------------------------------------
			-- Reference Number only in AP
			if @Module = 'AP'
			BEGIN
				SET @DataChar = rtrim(@VchRefNbr)

				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + 'Reference Number: ' + rtrim(@DataChar)
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
					BEGIN
						-- If Comma delimited attachment, first remove any commas
						SET @DataChar = Replace(@DataChar, ',', '') 
						SET @LineFull = @LineFull + @DataChar + ','
					END
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
					END
				END	
			END
					

			-- ----------------------------------------------
			-- Invoice Date
			-- ----------------------------------------------
			if @Module = 'AR'
				SET @DataChar = convert(varchar, @ChkDocDate, 101)
			else
				SET @DataChar = convert(varchar, @VchInvcDate, 101)
			if @Attachment = 0
			BEGIN
				if @MsgLayout = 'V'
				BEGIN
					SET @LineFull = @Indent5 + 'Invoice Date: ' + rtrim(@DataChar)
					EXEC XDDEmail_Insert @LineFull
				END
				else
				BEGIN
					SET @LineFull = @LineFull + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
				END
			END
			else
			BEGIN
				if @FileFormat = 'C'
					SET @LineFull = @LineFull + @DataChar + ','
				if @FileFormat = 'T'
					SET @LineFull = @LineFull + @DataChar + @Tab
				if @FileFormat = 'F'
				BEGIN
					SET @FixedLen = 14
					SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
				END
			END	


			-- ----------------------------------------------
			-- Invoice Amount
			-- ----------------------------------------------
			if @Module = 'AR'
			BEGIN
				-- For AR - the ChkCury... fields are used for invoice info
				SET @CuryAmt = @ChkCuryAmt
				SET @CuryDiscAmt = @ChkCuryDiscAmt
			END
			else
			BEGIN		
				-- For AP - the VchCury... fields are used for voucher inof
				SET @CuryAmt = @VchCuryAmt
				SET @CuryDiscAmt = @VchCuryDiscAmt
			END

			SET @InvcAmt = @CuryAmt + @CuryDiscAmt
			if (@Module = 'AP' and @VchDocType = 'AD') or (@Module = 'AR' and @ChkDocType = 'CM')
				SET @InvcAmt = -@InvcAmt

			SET @DataChar = convert(varchar, cast(@InvcAmt as Money), 1)
			if @Attachment = 0
			BEGIN
				if @MsgLayout = 'V'
				BEGIN
					SET @LineFull = @Indent5 + 'Invoice Amount: ' + rtrim(@DataChar)
					EXEC XDDEmail_Insert @LineFull
				END
				else
				BEGIN
					SET @LineFull = @LineFull + right(Space(@ColWidth) + @DataChar, @ColWidth) + @ColSpace
				END
			END
			else
			BEGIN
				if @FileFormat = 'C'
				BEGIN
					-- If Comma delimited attachment, first remove any commas
					SET @DataChar = Replace(@DataChar, ',', '') 
					SET @LineFull = @LineFull + @DataChar + ','
				END	
				if @FileFormat = 'T'
					SET @LineFull = @LineFull + @DataChar + @Tab
				if @FileFormat = 'F'
				BEGIN
					SET @FixedLen = 14
					SET @LineFull = @LineFull + right(Space(@FixedLen) + @DataChar, @FixedLen) + @ColSpace
				END
			END	

			-- ----------------------------------------------
			-- Amount Paid
			-- ----------------------------------------------
			-- Get Email Notation i.e. (EFT), (Wire), etc.
			SET	@EMailNote = ''
			SELECT	@EMailNote = EmailNote
			FROM	XDDTxnType (nolock)
			WHERE	FormatID = @FormatID
				and EntryClass = @EntryClass
				
			if rtrim(@EMailNote) <> ''
				SET @EMailNote = ' (' + rtrim(@EMailNote) + ')'

			if (@Module = 'AP' and @VchDocType = 'AD') or (@Module = 'AR' and @ChkDocType = 'CM')
				SET @CuryAmt = -@CuryAmt

			SET @DataChar = convert(varchar, cast(@CuryAmt as Money), 1)
			if @Attachment = 0
			BEGIN
				if @MsgLayout = 'V'
				BEGIN
					SET @LineFull = @Indent5 + 'Amount Paid: ' + rtrim(@DataChar) + @EMailNote
					EXEC XDDEmail_Insert @LineFull
				END
				else
				BEGIN
					SET @LineFull = @LineFull + right(Space(@ColWidth) + @DataChar, @ColWidth) + @ColSpace
				END
			END
			else
			BEGIN
				if @FileFormat = 'C'
				BEGIN
					-- If Comma delimited attachment, first remove any commas
					SET @DataChar = Replace(@DataChar, ',', '') 
					SET @LineFull = @LineFull + @DataChar + ','
				END
				if @FileFormat = 'T'
					SET @LineFull = @LineFull + @DataChar + @Tab
				if @FileFormat = 'F'
				BEGIN
					SET @FixedLen = 14
					SET @LineFull = @LineFull + right(Space(@FixedLen) + @DataChar, @FixedLen) + @ColSpace
				END
			END	

			-- ----------------------------------------------
			-- Transaction Details 
			-- ----------------------------------------------
			-- If Horizontal Layout, this comes below
			if @Attachment = 0 and @MsgLayout = 'V' and @TranOption <> 'N'
				EXEC XDDDispTranDetails @Module, @MsgLayout, @TranOption, @ChkRefNbr, @VchRefNbr, @Indent7,
					@TranUser1, @TranUser2, @TranUser3, @TranUser4, 
					@TranUser5, @TranUser6, @TranUser7, @TranUser8 

			-- ----------------------------------------------
			-- Discount Taken
			-- ----------------------------------------------
			if (@Module = 'AP' and @VchDocType = 'AD') or (@Module = 'AR' and @ChkDocType = 'CM')
				SET @CuryDiscAmt = -@CuryDiscAmt

			SET @DataChar = convert(varchar, cast(@CuryDiscAmt as Money), 1)
			if @Attachment = 0
			BEGIN
				if @MsgLayout = 'V'
				BEGIN
					SET @LineFull = @Indent5 + 'Discount Taken: ' + rtrim(@DataChar) + @EMailNote
					EXEC XDDEmail_Insert @LineFull
				END
				else
				BEGIN
					SET @LineFull = @LineFull + right(Space(@ColWidth) + @DataChar, @ColWidth) + @ColSpace
				END
			END
			else
			BEGIN
				if @FileFormat = 'C'
				BEGIN
					-- If Comma delimited attachment, first remove any commas
					SET @DataChar = Replace(@DataChar, ',', '') 
					SET @LineFull = @LineFull + @DataChar + ','
				END
				if @FileFormat = 'T'
					SET @LineFull = @LineFull + @DataChar + @Tab
				if @FileFormat = 'F'
				BEGIN
					SET @FixedLen = 14
					SET @LineFull = @LineFull + right(Space(@FixedLen) + @DataChar, @FixedLen) + @ColSpace
				END
			END	
		
			-- ----------------------------------------------
			-- User 1 (char)
			-- ----------------------------------------------
			if rtrim(@EMUser1) <> '' and rtrim(@VchUser1) <> ''
			BEGIN
				SET @DataChar = rtrim(@VchUser1)
				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + rtrim(@EMUser1) + ': ' + rtrim(@DataChar)
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull +  + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
					BEGIN
						-- If Comma delimited attachment, first remove any commas
						SET @DataChar = Replace(@DataChar, ',', '') 
						SET @LineFull = @LineFull + @DataChar + ','
					END
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
					END
				END	
			END
			
			-- ----------------------------------------------
			-- User 2 (char)
			-- ----------------------------------------------
			if rtrim(@EMUser2) <> '' and rtrim(@VchUser2) <> ''
			BEGIN
				SET @DataChar = rtrim(@VchUser2)
				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + rtrim(@EMUser2) + ': ' + rtrim(@DataChar)
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull +  + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
					BEGIN
						-- If Comma delimited attachment, first remove any commas
						SET @DataChar = Replace(@DataChar, ',', '') 
						SET @LineFull = @LineFull + @DataChar + ','
					END
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
					END
				END	
			END									

			-- ----------------------------------------------
			-- User 3 (float)
			-- ----------------------------------------------
			if rtrim(@EMUser3) <> '' and @VchUser3 <> 0
			BEGIN
				SET @DataChar = convert(varchar, cast(@VchUser3 as Money), 1)
				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + rtrim(@EMUser3) + ': ' + rtrim(@DataChar) + @EMailNote
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull + right(Space(@ColWidth) + @DataChar, @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
					BEGIN
						-- If Comma delimited attachment, first remove any commas
						SET @DataChar = Replace(@DataChar, ',', '') 
						SET @LineFull = @LineFull + @DataChar + ','
					END
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + right(Space(@FixedLen) + @DataChar, @FixedLen) + @ColSpace
					END
				END	
			END									

			-- ----------------------------------------------
			-- User 4 (float)
			-- ----------------------------------------------
			if rtrim(@EMUser4) <> '' and @VchUser4 <> 0
			BEGIN
				SET @DataChar = convert(varchar, cast(@VchUser4 as Money), 1)
				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + rtrim(@EMUser4) + ': ' + rtrim(@DataChar) + @EMailNote
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull + right(Space(@ColWidth) + @DataChar, @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
					BEGIN
						-- If Comma delimited attachment, first remove any commas
						SET @DataChar = Replace(@DataChar, ',', '') 
						SET @LineFull = @LineFull + @DataChar + ','
					END
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + right(Space(@FixedLen) + @DataChar, @FixedLen) + @ColSpace
					END
				END	
			END									

			-- ----------------------------------------------
			-- User 5 (char)
			-- ----------------------------------------------
			if rtrim(@EMUser5) <> '' and rtrim(@VchUser5) <> ''
			BEGIN
				SET @DataChar = rtrim(@VchUser5)
				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + rtrim(@EMUser5) + ': ' + rtrim(@DataChar)
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull +  + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
					BEGIN
						-- If Comma delimited attachment, first remove any commas
						SET @DataChar = Replace(@DataChar, ',', '') 
						SET @LineFull = @LineFull + @DataChar + ','
					END
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
					END
				END	
			END									

			-- ----------------------------------------------
			-- User 6 (char)
			-- ----------------------------------------------
			if rtrim(@EMUser6) <> '' and rtrim(@VchUser6) <> ''
			BEGIN
				SET @DataChar = rtrim(@VchUser6)
				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + rtrim(@EMUser6) + ': ' + rtrim(@DataChar)
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull +  + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
					BEGIN
						-- If Comma delimited attachment, first remove any commas
						SET @DataChar = Replace(@DataChar, ',', '') 
						SET @LineFull = @LineFull + @DataChar + ','
					END
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
					END
				END	
			END									

			-- ----------------------------------------------
			-- User 7 (date)
			-- ----------------------------------------------
			if rtrim(@EMUser7) <> '' and @VchUser7 <> 0
			BEGIN
				SET @DataChar = convert(varchar, @VchUser7, 101)
				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + rtrim(@EMUser7) + ': ' + rtrim(@DataChar)
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
					BEGIN
						-- If Comma delimited attachment, first remove any commas
						SET @DataChar = Replace(@DataChar, ',', '') 
						SET @LineFull = @LineFull + @DataChar + ','
					END
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
					END
				END	
			END									

			-- ----------------------------------------------
			-- User 8 (date)
			-- ----------------------------------------------
			if rtrim(@EMUser8) <> '' and @VchUser8 <> 0
			BEGIN
				SET @DataChar = convert(varchar, @VchUser8, 101)
				if @Attachment = 0
				BEGIN
					if @MsgLayout = 'V'
					BEGIN
						SET @LineFull = @Indent5 + rtrim(@EMUser8) + ': ' + rtrim(@DataChar)
						EXEC XDDEmail_Insert @LineFull
					END
					else
					BEGIN
						SET @LineFull = @LineFull + left(@DataChar + Space(@ColWidth), @ColWidth) + @ColSpace
					END
				END
				else
				BEGIN
					if @FileFormat = 'C'
						SET @LineFull = @LineFull + @DataChar + ','
					if @FileFormat = 'T'
						SET @LineFull = @LineFull + @DataChar + @Tab
					if @FileFormat = 'F'
					BEGIN
						SET @FixedLen = 14
						SET @LineFull = @LineFull + left(@DataChar + Space(@FixedLen), @FixedLen) + @ColSpace
					END
				END	
			END									

			-- If Attachment file or Horizontal layout
			--	Write out data line
			if @Attachment = 1 or @MsgLayout = 'H'
			BEGIN
				-- If Comma or Tab delimited, remove last comma/tab
				if @Attachment = 1 and (@FileFormat = 'C' or @FileFormat = 'T')
					SET @LineFull = left(@LineFull, len(@LineFull) - 1)

				-- Write out Horizontal Line or Attachment line				
				EXEC XDDEmail_Insert @LineFull
			
			END

			-- ----------------------------------------------
			-- Transaction Details
			-- ----------------------------------------------
			-- If Horizontal Layout and Tran Details, then writeout detail lines
			if @Attachment = 0 and @MsgLayout = 'H' and @TranOption <> 'N'
				EXEC XDDDispTranDetails @Module, @MsgLayout, @TranOption, @ChkRefNbr, @VchRefNbr, @IndentHTranDetails,
					@TranUser1, @TranUser2, @TranUser3, @TranUser4, 
					@TranUser5, @TranUser6, @TranUser7, @TranUser8 
			
			Fetch Next From Wrk_Cursor into
			@ChkRefNbr,
			@ChkCuryAmt,
			@ChkCpnyID,
			@ChkAcct,
			@ChkSub, 
			@ChkDocDate,
			@ChkCuryDiscAmt,
			@ChkDocType,
			@AR_EMCpnyName,
			@AP_EMCpnyName,
			@VendCustName,
			@LastEffDate,
			@DepBankTransit,
			@DepBankAcct,
			@WBenBankName,
			@WBenBankSwift,
			@WBenBankAcct,
			@VchRefNbr,
			@VchDocType,
			@VchInvcDate,
			@VchInvcNbr,
			@VchCuryAmt,
			@VchCuryDiscAmt,
			@FormatID,
			@EntryClass,
			@VchUser1,
			@VchUser2,
			@VchUser3,
			@VchUser4,
			@VchUser5,
			@VchUser6,
			@VchUser7,
			@VchUser8

			-- for A/R VchRefNbr = Payment Number, ChkRefNbr = Invoice Number
			if @Module = 'AR'
			BEGIN
				SET @InvcNbr = @ChkRefNbr
				SET @ChkRefNbr = @VchRefNbr
			END

		END	-- Check/Invoice Loop

	END	-- All records for this Acct/Sub/VendID-CustID

/* Uncomment if needing custom bottom message
-- Custom Bottom Message (if adding here, then uncheck using Std Bottom Msg in Vendor/Customer Banking Entry)
    SET @LineFull = 'First Line of custom bottom msg'
    EXEC XDDEmail_Insert @LineFull

    SET @LineFull = 'Second line of custom bottom msg'
    EXEC XDDEmail_Insert @LineFull

    SET @LineFull = 'etc., etc.'
    EXEC XDDEmail_Insert @LineFull
*/


ABORT:

	Close Wrk_Cursor
	DeAllocate Wrk_Cursor

	-- Add extra line, so will always have some data
	if not exists(Select * from #TempTable)
	BEGIN
		SET @LineFull = 'No EFT or Wire data found'
		EXEC XDDEmail_Insert @LineFull
	END
	
	SELECT LineOut, LineOutPlus from #TempTable


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDD_Create_Custom_Email] TO [MSDSL]
    AS [dbo];

