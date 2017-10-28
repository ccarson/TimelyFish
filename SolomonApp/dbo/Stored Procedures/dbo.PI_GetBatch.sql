
Create Proc PI_GetBatch
	@p_PIID 		VarChar(10),
	@p_CpnyId 		VarChar(10),
	@p_AdjPerBatch 	Integer,
	@p_Descr 		VarChar(30),
	@p_Username 	VarChar(10),
	@P_PerClosed	VarChar(6)
as

	set nocount on

	Declare	@LastBatNbr		Integer,
			@BatNbr_Len		SmallInt,
			@BatNbr_Str		VarChar(10),
			@PwrLvl			Decimal(10, 0),
			@CurPerNbr 		VarChar(6),
			@NumOfAdj 		Integer,
			@NumOfBat 		Integer,
			@BatchNumber 	Integer,
			@GLPostOpt 		Char(1),
			@DecPlQty		SmallInt,
			@BaseDecPl		SmallInt,
			@FirstBatNbr	Integer

	/*	Used in the SQL Power function, keeps the function from getting an arithmatic over flow.	*/
	Set	@PwrLvl	= 10

	Select	@BatNbr_Len = Len(LTrim(LastBatNbr)),	/*	Determines Batch Number Mask Length	*/
			@CurPerNbr = CurrPerNbr,				/*	Current Period Number	*/
			@GLPostOpt = GLPostOpt					/*	General Ledger Post Option D - Detail, S - Summary	*/
	From INSetup
	
	Select	@DecPlQty = DecPlQty					/*	Quantity Decimal Position	*/
	From	vp_DecPl

/*	Determine the total number of adjustments to be created.	*/
	Select	@NumOfAdj = Count(*)
		From	PIDetail Join Inventory (NOLOCK)
		on PIDetail.InvtId = Inventory.InvtId
			 Left Join PIDetCost
				On PIDetail.PIID = PIDetCost.PIID
					And PIDetail.Number = PIDetCost.Number
	Where	PIDetail.PIID = @P_PIID
		And Round(PIDetail.BookQty, @DecPlQty) <> Round(PIDetail.PhysQty, @DecPlQty)
		And PIDetail.Status = 'E'	/*	Entered		*/

/*	Determine the number of batches and clear key variables.	*/
	Select	@NumOfBat = Case When @p_AdjPerBatch = 0 And @NumOfAdj <> 0
							Then 1
						When @p_AdjPerBatch = 0
							Then 0
						When @NumOfAdj <= @p_AdjPerBatch
							Then 1
						Else @NumOfAdj / @p_AdjPerBatch
				End,
		@BatchNumber = 0

/*	Are there more total adjustments than the per batch number?	*/
	If	@NumOfAdj > @p_AdjPerBatch
	Begin

/*	Are there any remaining adjustments won't evenly divide?	*/
		If (@NumOfAdj % @p_AdjPerBatch) > 0
			Set	@NumOfBat = @NumOfBat + 1
	End

	Begin Tran

	While @BatchNumber < @NumOfBat
	Begin
		/* Get Next Batch Number*/
		exec DMG_IN_Auto_BatNbr_NextNum @LastBatNbr Output

		if @BatchNumber = 0
			Set @FirstBatNbr = @LastBatNbr

		/*	Convert the Last Batch Number into a string with the length equal to defined mask and zero padded on the left.	*/
		Set	@BatNbr_Str = Right(Replicate('0', @BatNbr_Len) + Cast(@LastBatNbr As VarChar(10)), @BatNbr_Len)

		/*	Attempt to insert a record into the batch table with the new batch number.	*/
		Insert	Batch
			(
			AutoRev, AutoRevCopy, BatNbr, BatType, Descr,
			EditScrnNbr, GlPostOpt, JrnlType, Module, PerEnt,
			PerPost, Rlsed, Status, Crtd_DateTime, Crtd_Prog,
			Crtd_User, Lupd_DateTime, Lupd_Prog, Lupd_User, NbrCycle,
			CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDrtot,
			DrTot, CuryDepositAmt, Cycle, Acct, BalanceType,
			BankAcct, BankSub, BaseCuryID, ClearAmt, Cleared,
			CpnyID, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
			CuryRateType, DateClr, DateEnt, DepositAmt, LedgerID,
			NoteID, OrigBatNbr, origCpnyID, OrigScrnNbr, Sub,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
			S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
			S4Future11, S4Future12, User1, User2, User3,
			User4, User5, User6, User7, User8, VOBatNbrforPP
			)
		Values
			(
			0, 0, @BatNbr_Str, 'N', @p_Descr,
			'10397', @GLPostOpt, 'IN', 'IN', @CurPerNbr,
			@P_PerClosed, 0, 'V', GetDate(), '10397SQL',
			@p_Username, GetDate(), '10397SQL', @p_Username, 0,
			0, 0, 0, 0, 0,
			0, 0, 0, space(1), space(1),
			space(1), space(1), space(1), 0, 0,
			@P_CpnyId, '', space(1), space(1), 0,
			space(1), '', '', 0, space(1),
			0, space(1), space(1), space(1), space(1),
			space(1), space(1), 0, 0, 0,
			0, '', '', 0, 0,
			@P_PIID, space(1), space(1), space(1), 0,
			0, space(1), space(1), '', '', ''
			)
		set @BatchNumber = @BatchNumber + 1
	End
	Commit Tran

	Select @FirstBatNbr, @LastBatNbr
	Set nocount off
