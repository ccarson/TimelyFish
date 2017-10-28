
CREATE PROCEDURE XDDWrkCheckSel_Build_Batch
   @AccessNbr		smallint,
   @GroupNbr		varchar( 1 ),
   @BatNbr		varchar( 10 ),
   @ChkPrtDate		smalldatetime,
   @ChkWF		varchar( 1 ),		-- "C"omputer check batch, "M"anual Check Batch
   @Crtd_User		varchar( 10 )
AS

   Declare @APResult 		int
   Declare @CpnyID		varchar( 10 )
   Declare @CuryEffDate		smalldatetime
   Declare @CuryDecPl		int
   Declare @CuryID		varchar( 4 )
   Declare @CuryMultDiv		varchar( 1 )
   Declare @CuryRate		float
   Declare @CuryRateType	varchar( 6 )
   Declare @PayDate		smalldatetime
   Declare @Preview		smallint   		
   Declare @UserId		varchar( 10 )

   -- Batch record has been created in another txn - With status "V"oid

   -- Create a WrkCheckSel from XDDWrkCheckSel - but only for this new batch

   -- Once created call:
   --  APCheckSel_Remove_Ineligible
   --      Removes records from WrkCheckSel which are currently on an unreleased
   --      manual check batch
   --  AP_Pay_Select calls 4 procs - cannot use since we don't want the first one:
   --    X APchecksel_setselected      Updates APDoc.Selected (don't use as it will deselect our original batch)
   
   --      APchecksel_calc_payment     Updates WrkCheckSel - Cury... Discounts (No records added/changed)
   --      APcheck_create_trans        Processes WrkCheckSel and Updates APCheck (already created?) and adds APCheckDet records
   --      APcheck_update_docs         Processes APCheck/APCheckDet and Updates APDoc.PmtAmt, etc

   SET NOCOUNT ON

   -- -------------------------------------
   -- Clear out Pmt Selection Working Table
   -- -------------------------------------
   DELETE	FROM WrkCheckSel
   WHERE	AccessNbr = @AccessNbr

   -- Computer Check Batch
   if @ChkWF = 'C'
   BEGIN
	   -- ---------------------------------------------------
	   -- Populate WrkCheckSel from XDDWrkCheckSel (by Group)
	   -- ---------------------------------------------------
	   INSERT INTO 	WrkCheckSel
	   (	AccessNbr,
		Acct,
		AdjFlag,
		ApplyRefNbr,
		BWAmt,
		CheckCuryId,
		CheckCuryRate,
		CheckCuryMultDiv,
		CpnyID, 	
		CheckRefNbr,	
		CuryBWAmt,
		CuryDecPl, 	
		CuryDiscBal, 	
		CuryDiscTkn, 	
		CuryDocBal, 	
		CuryEffDate, 	
		CuryId, 	
		CuryMultDiv, 	
		CuryPmtAmt, 	
		CuryRate, 	
		CuryRateType, 	
		DiscBal, 	
		DiscDate, 	
		DiscTkn, 	
		DocBal, 	
		DocDesc, 	
		DocType, 	
		DueDate, 	
		LineNbr,	
		MultiChk, 	
		PayDate, 	
		PmtAmt, 	
		RefNbr,
		ReqBkupWthld,
		S4Future01,     
		S4Future02,     
		S4Future03,     
		S4Future04,     
		S4Future05,     
		S4Future06,     
		S4Future07,     
		S4Future08,     
		S4Future09,     
		S4Future10,     
		S4Future11,     
		S4Future12,     
		Sub,
		User1,
		User2,
		User3,
		User4,
		User5,
		User6,
		User7,
		User8,
		VendId
	   )
	
	   SELECT

	   	AccessNbr,
		Acct,
		AdjFlag,
		ApplyRefNbr,
		BWAmt,
		CheckCuryId,
		CheckCuryRate,
		CheckCuryMultDiv,
		CpnyID, 	
		CheckRefNbr,	
		CuryBWAmt,
		CuryDecPl, 	
		case when Doctype = 'AD'
			then -CuryDiscBal
			else CuryDiscBal
			end, 	
		case when Doctype = 'AD'
			then -CuryDiscTkn
			else CuryDiscTkn
			end,
		CuryDocBal,		-- always leave positive
		CuryEffDate, 	
		CuryId, 	
		CuryMultDiv, 	
		CuryPmtAmt,
		CuryRate, 	
		CuryRateType, 	
		case when DocType = 'AD'
			then -DiscBal
			else DiscBal
			end, 	
		DiscDate, 	
		case when Doctype = 'AD'
			then -DiscTkn
			else DiscTkn
			end,
		case when Doctype = 'AD'
			then -DocBal
			else DocBal
			end, 	
		DocDesc, 	
		DocType, 	
		DueDate, 	
		LineNbr,	
		MultiChk, 	
		PayDate, 	
		PmtAmt,
		RefNbr, 	
		ReqBkupWthld,
		S4Future01,     
		S4Future02,     
		S4Future03,     
		S4Future04,     
		S4Future05,     
		S4Future06,     
		S4Future07,     
		S4Future08,     
		S4Future09,     
		S4Future10,     
		S4Future11,     
		S4Future12,     
		Sub,
		User1,
		User2,
		User3,
		User4,
		User5,
		User6,
		User7,
		User8,
		VendId

	   FROM		XDDWrkCheckSel (nolock)
	   WHERE	AccessNbr = @AccessNbr
	   		and EBGroup = @GroupNbr
	
	   -- -------------------------------------
	   -- Retrieve Vars from Batch record
	   -- -------------------------------------
	   SELECT	@CpnyID = CpnyID,
	   		@UserID = LUpd_User,
	   		@CuryID = CuryID,
	   		@CuryRateType = CuryRateType,
	   		@CuryEffDate = CuryEffDate,
	   		@CuryRate = CuryRate,
	   		@CuryMultDiv = CuryMultDiv
	   FROM		Batch (nolock)
	   WHERE	Module = 'AP'
	   		and BatNbr = @BatNbr
	   
	   SELECT	@CuryDecPl = DecPl
	   FROM		Currncy (nolock)
	   WHERE	CuryID = @CuryID
	
	   -- -------------------------------------
	   -- -------------------------------------
	   -- Run Normal AP Pmt Selection Routines
	   -- -------------------------------------
	   -- -------------------------------------
	
	   SET @Preview = 0
	
	   -- Remove records from WrkCheckSel which are currently on an unreleased manual check batch  
	   EXEC APCheckSel_Remove_Ineligible @AccessNbr, @CpnyID 
	
	   -- Process WrkCheckSel - Creating APCheck, APCheckDet records for this @BatNbr
	
	   -- NOTE: Can't use AP_PaySelect (as it calls APCheckSel_SetSelected which will Deselect those in our batch)
	   -- @PayDate is used to see if discounts apply (DiscDate < PayDate, then no discount)
	   --	But user may have overwritten the value, in Edit/Select Docs for Payment...
	   --	So use 0, so any discounts manually entered will always apply
	   SET @PayDate = 0

	   -- Updates WrkCheckSel with rates... was apply rate twice on checks
	   --EXEC APCheckSel_Calc_Payment @AccessNbr, @PayDate, @CuryId, @CuryMultDiv,  @CuryRate,
	   --	@CuryDecPl, @CuryEffDate, @CuryRateType, @Preview, @APResult OUTPUT
	   --if @APResult = 0 RETURN

	   EXEC APCheck_Create_Trans @AccessNbr, @ChkPrtDate, @CuryId, @CuryRateType, @CuryEffDate,  
			@CuryRate, @CuryMultDiv, @BatNbr, @Cpnyid, @Preview, @APResult OUTPUT  
	   if @APResult = 0 RETURN  
	    
	   EXEC APCheck_Update_Docs @AccessNbr, @BatNbr, @Preview, @APResult OUTPUT  
	   if @APResult = 0 RETURN  
   END
   
   else

   BEGIN
   -- Manual Check Batch
   
   	-- Process XDDWrkCheckSel and add APDoc/APTrans to Check Batch
	EXEC XDDManual_Check_Batch_Update @AccessNbr, @GroupNbr, @BatNbr, @Crtd_User
   
   END   
   
   -- -------------------------------------
   -- Update XDDWrkCheckSel w/ BatNbr
   -- -------------------------------------
   UPDATE	XDDWrkCheckSel
   SET		EBBatNbr = @BatNbr
   WHERE	AccessNbr = @AccessNbr
   		and EBGroup = @GroupNbr
   

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDWrkCheckSel_Build_Batch] TO [MSDSL]
    AS [dbo];

