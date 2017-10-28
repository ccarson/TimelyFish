
CREATE PROCEDURE XDDTxnTypeDep_APDoc_Update
   @FormatID		varchar( 15 ),
   @UpdateType		varchar( 1 ),		-- "A"ll (XDDTxnType & APDoc.eStatus), "T"xntype only
   @UserID		varchar( 10 ),
   @Prog		varchar( 8 )

AS

	declare		@EStatus		varchar( 1 )
	declare		@EntryClass		varchar( 4 )
	declare		@EntryClassCanChg	smallint
	declare 	@DefaultCust		smallint
	declare 	@DefaultVend		smallint
	declare		@Selected		varchar( 1 )
	declare 	@TTEntryClass		varchar( 4 )
	declare		@TTDSelect		smallint
	declare 	@TxnCustUse		smallint
	declare 	@TxnVendUse		smallint
	declare		@VendCust		varchar( 1 )
	declare		@VendID			varchar( 15 )
	declare		@VendAcct		varchar( 10 )

	-- Cycle thru all XDDDepositors that have this FormatID
	-- For each one, refresh their XDDTxnTypeDep
	--	Remove if no longer selected in DD.301
	--		If was EntryClass, replace EntryClass with default value
	--	Add if wasn't there - leave selected
	--	Be sure they have an SL-CHECK record (eStatus = '')
		
	-- If XDDSetup.SKFuture01 = 'UPGRADE_V8'
	-- 	then update APDoc.eStatus for all OpenDoc vouchers (for eBanking vendors)


	if @UpdateType = 'A' or @UpdateType = 'T'			
	BEGIN
		-- Get all XDDDepositor vendors
		-- Now includes both Vendors and Customers (not doing any Customer updates right now)
		DECLARE         Upd_Cursor CURSOR LOCAL FAST_FORWARD
		FOR
		SELECT 		VendCust, VendID, VendAcct, EntryClass, EntryClassCanChg	
		FROM            XDDDepositor (nolock)
		WHERE		FormatID = @FormatID
				and VendCust = 'V'	-- Now restrict to Vendors only...
		ORDER BY	VendID
	
		if (@@error <> 0) GOTO ABORTUPD
	
		-- Cycle through All XDDepositors for this format
		OPEN Upd_Cursor
	
		Fetch Next From Upd_Cursor into
		@VendCust,
		@VendID,
		@VendAcct,
		@EntryClass,
		@EntryClassCanChg
		
		While (@@Fetch_Status = 0)
		BEGIN

			-- If Can Change is checked, then newly added Txn Types are un-selected
			if @EntryClassCanChg = 1
				SET	@TTDSelect = 0
			else
				SET	@TTDSelect = 1
		
			-- Be sure there is an SLCheck entry
			if not exists(Select * from XDDTxnTypeDep (nolock) 
					WHERE 	VendCust = 'V'
						and VendID = @VendID
						and VendAcct = @VendAcct 
						and eStatus = ' ')
			BEGIN			
				-- Doesn't yet exist - add it, 
				--	Selected - based on @EntryClassCanChange
				INSERT INTO XDDTxnTypeDep
				(Crtd_DateTime, Crtd_Prog, Crtd_User, eStatus,
	 			LUpd_DateTime, LUpd_Prog, LUpd_User, Selected,
	 			VendCust, VendID, VendAcct)
	 			VALUES
	 			(GetDate(), @Prog, @UserID, ' ',
	 			 GetDate(), @Prog, @UserID, @TTDSelect,
	 			 'V', @VendID, @VendAcct)
			END
			
		
			-- For each XDDDepositor Add/Remove the currently selected XDDTxnTypes
			DECLARE         TT_Cursor CURSOR LOCAL FAST_FORWARD
			FOR
			SELECT 		Selected, EntryClass, EStatus, TxnVendUse, TxnCustUse, DefaultVend, DefaultCust
			FROM            XDDTxnType (nolock)
			WHERE		FormatID = @FormatID
	
			if (@@error <> 0) GOTO ABORTTT
	
			-- Cycle through all XDDTxnTypes - will check both selected and de-selected
			-- The application has already verified that we can delete the XDDTxnTypeDep records
			OPEN TT_Cursor
	
			Fetch Next From TT_Cursor into
			@Selected,
			@TTEntryClass,
			@EStatus,
			@TxnVendUse,
			@TxnCustUse,
			@DefaultVend,
			@DefaultCust
	
				
			While (@@Fetch_Status = 0)
			BEGIN
	
				-- TxnType is selected (and it is used for Vendors)
				-- be sure it is in the XDDTxnTypeDep table
				if @Selected = 'Y'
				BEGIN
					-- need to update XDDTxnTypeDep if Vendors use this EStatus
					if @TxnVendUse = 1 and @VendCust = 'V'
						if not exists(Select * from XDDTxnTypeDep (nolock) 
								WHERE 	VendCust = 'V'
									and VendID = @VendID
									and VendAcct = @VendAcct 
									and eStatus = @EStatus)
						BEGIN			
							-- Doesn't yet exist - add it, 
							--	Selected - based on @EntryClassCanChange
							INSERT INTO XDDTxnTypeDep
							(Crtd_DateTime, Crtd_Prog, Crtd_User, eStatus,
				 			LUpd_DateTime, LUpd_Prog, LUpd_User, Selected,
				 			VendCust, VendID, VendAcct)
				 			VALUES
				 			(GetDate(), @Prog, @UserID, @EStatus,
				 			 GetDate(), @Prog, @UserID, @TTDSelect,
				 			 'V', @VendID, @VendAcct)
						END
				END	

				else
	
				BEGIN
					-- TxnType is un-selected
					-- Added logic to be sure we're not deleting
					-- 	an Entryclass that is the default Entryclass
					if @TxnVendUse = 1 and @VendCust = 'V'
						DELETE 	FROM XDDTxnTypeDep
						WHERE	VendCust = 'V'
							and VendID = @VendID
							and VendAcct = @VendAcct
							and EStatus = @EStatus
				END

				Fetch Next From TT_Cursor into
				@Selected,
				@TTEntryClass,
				@EStatus,
				@TxnVendUse,
				@TxnCustUse,
				@DefaultVend,
				@DefaultCust
	
			END	-- Loop thru XDDTxnType records (for each XDDDepositor)

ABORTTT:
			Close TT_Cursor
			Deallocate TT_Cursor
	
			Fetch Next From Upd_Cursor into
			@VendCust,
			@VendID,
			@VendAcct,
			@EntryClass,
			@EntryClassCanChg
	
		END	-- Loop thru XDDDepositors
	
	END	-- UpdateType A or T


ABORTUPD:
	Close Upd_Cursor
	Deallocate Upd_Cursor
	
	-- If "A"ll update, then update existing vouchers with the correct eStatus and eConfirm
	if @UpdateType = 'A'
	BEGIN

		if (SELECT rtrim(SKFuture01) FROM XDDFileFormat (nolock) WHERE FormatID = @FormatID) = 'UPGRADE_V8'
		BEGIN
		
			-- Update regular vouchers
			UPDATE 	APDoc
			
			SET	eStatus = T.eStatus,				-- Set to XDDTxnType.eStatus field
				eConfirm = D.VendAcct			-- Set to default Account

			FROM APDoc A, XDDDepositor D, XDDTxnType T
			WHERE 	A.VendID = D.VendID 				-- only VBE vendors
				and D.VendCust = 'V'
				and D.VendAcctDflt = 1				-- get default account record
				and D.status = 'Y'							-- Active
				and (D.termdate > getdate() or D.termdate = '01/01/1900')		-- Not terminated
				and (D.pnstatus = 'A' or (D.pnstatus = 'P' and D.pndate <= getdate()) ) -- Pre-note approved
				and D.FormatID = T.FormatID and D.EntryClass = T.EntryClass
				and A.Doctype IN ('VO', 'AD', 'AC')
				and A.OpenDoc = 1					-- only open documents
				and A.Selected = 0					-- not selected batches
				and A.eStatus = ''					-- if another process has updated them already
				and D.FormatID = @FormatID

			-- Update Distributed Liablity Vouchers (VM) and Recurring Vouchers (RC)
			UPDATE	APDoc
			SET	eStatus = coalesce((SELECT case when D.EntryClass = 'SLCK'
								then ''
								else TT.eStatus
								end
							FROM	XDDDepositor D (nolock) LEFT OUTER JOIN XDDTxnType TT (nolock)
								ON D.FormatID = TT.FormatID and D.EntryClass = TT.EntryClass
							WHERE	D.VendID = APDoc.VendID
								and D.VendCust = 'V'	-- Vendor record
			   					and D.Status = 'Y'	-- Active
		   						and ( (D.TermDate = Convert(SmallDateTime, '01/01/1900')) or 	-- Not terminated
		   				      	      	      (D.TermDate <> Convert(SmallDateTime, '01/01/1900') and D.TermDate >= GetDate())
		   				    	    	    )
						   ), ''),
				eConfirm = coalesce((SELECT D.VendAcct
							FROM	XDDDepositor D (nolock) LEFT OUTER JOIN XDDTxnType TT (nolock)
								ON D.FormatID = TT.FormatID and D.EntryClass = TT.EntryClass
							WHERE	D.VendID = APDoc.VendID
								and D.VendAcctDflt = 1	-- default account
								and D.VendCust = 'V'	-- Vendor record
			   					and D.Status = 'Y'	-- Active
		   						and ( (D.TermDate = Convert(SmallDateTime, '01/01/1900')) or 	-- Not terminated
		   				      	      	      (D.TermDate <> Convert(SmallDateTime, '01/01/1900') and D.TermDate >= GetDate())
		   				    	    	    )
						   ), '')
				
			WHERE 	doctype IN ('RC', 'VM')
				and vendID IN (Select VendID from XDDDepositor (nolock) where FormatID = @FormatID and VendCust = 'V')
				
			-- Now set flag - UPGRADE_V8 has been done
			UPDATE	XDDFileFormat
			SET	SKFuture01 = ''
			WHERE	FormatID = @FormatID
			
			-- Now check if all selected Formats have been upgraded
			if not exists(SELECT * from XDDFileFormat (nolock)
					WHERE 	Selected = 'Y'
						and SKFuture01 = 'UPGRADE_V8')
				UPDATE	XDDSetup
				SET	SKFuture01 = ''
		END
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTxnTypeDep_APDoc_Update] TO [MSDSL]
    AS [dbo];

