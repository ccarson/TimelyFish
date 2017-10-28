
CREATE TRIGGER XDD_APDoc_Voucher ON APDoc
FOR INSERT

AS

	declare @Crtd_DateTime		smalldatetime
	declare @Crtd_Prog		varchar( 8 )
	declare @Crtd_User		varchar( 10 )
	declare @CurrDate		smalldatetime
	declare @DocType		varchar( 2 )
	declare @EFTWire		bit
	declare @EntryClass		varchar( 4 )
	declare @eConfirm		varchar( 18 )
	declare @eConfirmDflt		varchar( 18 )
	declare @eStatus		varchar( 1 )
	declare @MasterDocNbr		varchar( 10 )
	declare @RecordID		int
	declare @RefNbr			varchar( 10 )
	declare @RowCnt			int
	declare @S4Future11		varchar( 10 )
	declare @S4Future12		varchar( 10 )
	declare @VendID			varchar( 15 )
	
	-- must go before Set NoCount
	SET @RowCnt = @@RowCount
	
	-- Prevent the trigger from returning data 
	SET NOCOUNT ON

	-- Get default VendAcct
	if (Select TOP 1 MultiVendAcctUse FROM XDDSetupEx (nolock)) = convert(smallint, 1)
		SET @eConfirmDflt = (Select TOP 1 MultiVendAcct FROM XDDSetupEx (nolock))
	else
		SET @eConfirmDflt = ''

	if @RowCnt = 1
	BEGIN
	-- Single Row Updated

		-- Get values from the inserted APDoc record
		SELECT		@Crtd_DateTime = Crtd_DateTime,
				@Crtd_Prog = Crtd_Prog,
				@Crtd_User = Crtd_User,
				@DocType = DocType,
				@MasterDocNbr = MasterDocNbr,
				@RecordID = RecordID,
				@RefNbr = RefNbr,
				@S4Future11 = S4Future11,	-- VM
				@S4Future12 = S4Future12,	-- Master Doc RefNbr
				@VendID = VendID
		FROM 		INSERTED
		
		-- First check if Voucher (VO) was created outside of AP (Crtd_Prog = 03xxx)
		SET @EFTWire = 0
		if left(@Crtd_Prog, 2) <> '03'
		BEGIN
			-- Check if APEFT and/or Wire Transfer Plus are being used in eBanking
			-- Check if this Vendor is an EFT/Wire Vendor
			if exists(SELECT * FROM XDDSetup (nolock) WHERE ModAPEFT = 'Y' or ModWire = 'Y')
				if exists(SELECT * from XDDDepositor (nolock) WHERE VendCust = 'V' and VendID = @VendID)
					SET @EFTWire = 1
		END
	
		-- Only proceed if EFT/Wire 
		--   and 1) Voucher (VO) was created outside of AP (Crtd_Prog = 03xxx) and VO or VT
		--       2) Voucher (VO) is a from a Distributed Liability Voucher
		IF @EFTWire = 1
		BEGIN
		
			-- Default to no value - SL Check
			SET @eConfirm = @eConfirmDflt
			SET @eStatus = '' 

			if @DocType IN ('VO', 'AD', 'AC', 'VT') 
				and @S4Future11 <> 'VM'
			BEGIN
				
				-- Find the default EntryClass for this Vendor
				--	Then lookup the eStatus that matches that EntryClass for the Vendor's Format
				SELECT		@eConfirm = D.VendAcct,			-- default Account
						@eStatus = case when D.EntryClass = 'SLCK'	-- default EntryClass
							then ''
							else TT.eStatus
							end
				FROM		XDDDepositor D (nolock) LEFT OUTER JOIN XDDTxnType TT (nolock)
						ON D.FormatID = TT.FormatID and D.EntryClass = TT.EntryClass
				WHERE		D.VendID = @VendID
						and D.VendAcctDflt = 1	-- default account record
						and D.VendCust = 'V'	-- Vendor record
				   		and D.Status = 'Y'	-- Active
			   			and ( (D.TermDate = Convert(SmallDateTime, '01/01/1900')) or 	-- Not terminated
			   			      (D.TermDate <> Convert(SmallDateTime, '01/01/1900') and D.TermDate >= GetDate())
			   		    	     )
			
				-- Trigger only updates if a non-blank @eStatus
				IF @eStatus <> ''
					UPDATE	APDoc
					SET	eStatus = @eStatus,
						eConfirm = @eConfirm,
						LUpd_DateTime = @Crtd_DateTime,
						LUpd_Prog = @Crtd_Prog,
						LUpd_User = @Crtd_User
					WHERE	RecordID = @RecordID
			END
	
			if rtrim(@S4Future11) = 'VM' and rtrim(@DocType) = 'VO'
			BEGIN
				
				-- Get the eStatus from the 'VM' master document
				SELECT	@eStatus = eStatus,
					@eConfirm = eConfirm
				FROM	APDoc (nolock)
				WHERE	RefNbr = @S4Future12
					and DocType = 'VM'
					and VendId = @VendID
					
				-- Update voucher created from this MasterDoc
				UPDATE	APDoc
				SET	eStatus = @eStatus,
					eConfirm = @eConfirm,
					LUpd_DateTime = @Crtd_DateTime,
					LUpd_Prog = @Crtd_Prog,
					LUpd_User = @Crtd_User
				WHERE	RecordID = @RecordID
			
			END

		END -- Only proceed if EFT/Wire 
		
	END	-- Single Row Updated

	else
	
	BEGIN
	-- Multiple rows updated
		DECLARE         Upd_Cursor CURSOR FORWARD_ONLY LOCAL
		FOR
		SELECT		Crtd_DateTime,
				Crtd_Prog,
				Crtd_User,
				DocType,
				MasterDocNbr,
				RecordID,
				RefNbr,
				S4Future11,
				S4Future12,
				VendID
		FROM		INSERTED

		if (@@error <> 0) GOTO ABORT
			
		OPEN Upd_Cursor
		Fetch Next From Upd_Cursor into
		@Crtd_DateTime,
		@Crtd_Prog,
		@Crtd_User,
		@DocType,
		@MasterDocNbr,
		@RecordID,
		@RefNbr,
		@S4Future11,	-- VM - Master doc
		@S4Future12,	-- VM - RefNbr
		@VendID

		-- First check if Voucher (VO) was created outside of AP (Crtd_Prog = 03xxx)
		-- Assume if multiple records are being updated, then all from same soruce
		if left(@Crtd_Prog, 2) <> '03'
		BEGIN	

		-- Only process if records not created by 03xxx program
		
			While (@@Fetch_Status = 0)
			BEGIN
	
				SET @EFTWire = 0
				-- Check if APEFT and/or Wire Transfer Plus are being used in eBanking
				-- Check if this Vendor is an EFT/Wire Vendor
				if exists(SELECT * FROM XDDSetup (nolock) WHERE ModAPEFT = 'Y' or ModWire = 'Y')
					if exists(SELECT * from XDDDepositor (nolock) WHERE VendCust = 'V' and VendID = @VendID)
						SET @EFTWire = 1

				-- Only process if AP-EFT/Wire Vendor
				IF @EFTWire = 1
				BEGIN	
					-- Default to no value - SL Check
					SET @eConfirm = @eConfirmDflt
					SET @eStatus = '' 
			
					if left(@Crtd_Prog, 2) <> '03' 
						and @DocType IN ('VO', 'AD', 'AC', 'VT')
						and @S4Future11 <> 'VM'
					BEGIN
						
						-- Find the default EntryClass for this Vendor
						--	Then lookup the eStatus that matches that EntryClass for the Vendor's Format
						SELECT		@eConfirm = D.VendAcct,			-- default Account
								@eStatus = case when D.EntryClass = 'SLCK'
									then ''
									else TT.eStatus
									end
						FROM		XDDDepositor D (nolock) LEFT OUTER JOIN XDDTxnType TT (nolock)
								ON D.FormatID = TT.FormatID and D.EntryClass = TT.EntryClass
						WHERE		D.VendID = @VendID
								and D.VendAcctDflt = 1	-- default account record
								and D.VendCust = 'V'	-- Vendor record
						   		and D.Status = 'Y'	-- Active
					   			and ( (D.TermDate = Convert(SmallDateTime, '01/01/1900')) or 	-- Not terminated
					   			      (D.TermDate <> Convert(SmallDateTime, '01/01/1900') and D.TermDate >= GetDate())
					   		    	     )
					
						-- Trigger only updates if a non-blank @eStatus
						IF @eStatus <> ''
							UPDATE	APDoc
							SET	eStatus = @eStatus,
								eConfirm = @eConfirm,
								LUpd_DateTime = @Crtd_DateTime,
								LUpd_Prog = @Crtd_Prog,
								LUpd_User = @Crtd_User
							WHERE	RecordID = @RecordID
					END
			
					if rtrim(@S4Future11) = 'VM' and rtrim(@DocType) = 'VO'
					BEGIN
						
						-- Get the eStatus from the 'VM' master document
						SELECT	@eStatus = eStatus,
							@eConfirm = eConfirm
						FROM	APDoc (nolock)
						WHERE	RefNbr = @S4Future12
							and DocType = 'VM'
							and VendId = @VendID
							
						-- Update voucher created from this MasterDoc
						UPDATE	APDoc
						SET	eStatus = @eStatus,
							eConfirm = @eConfirm,
							LUpd_DateTime = @Crtd_DateTime,
							LUpd_Prog = @Crtd_Prog,
							LUpd_User = @Crtd_User
						WHERE	RecordID = @RecordID
					
					END
				END
				Fetch Next From Upd_Cursor into
				@Crtd_DateTime,
				@Crtd_Prog,
				@Crtd_User,
				@DocType,
				@MasterDocNbr,
				@RecordID,
				@RefNbr,
				@S4Future11,
				@S4Future12,
				@VendID
				
			END	-- Fetch Next Loop	
		END	-- Only process if records not created by 03xxx program
		Close Upd_Cursor
		Deallocate Upd_Cursor
ABORT:

	END	-- Multiple rows updated

