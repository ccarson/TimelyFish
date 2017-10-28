 Create	Procedure ADG_10530_Process
	@UserAddress		VarChar(21),
	@CpnyID 		VarChar(10),
	@Module 		VarChar(10),
	@ProgName 		VarChar(8),
	@UserName 		VarChar(10),
	@AllItems 		Char(1),
	@SelectionOption 	Char(1),
	@AdjustTrans 		Char(1),
	@RevalEffDate 		SmallDateTime,
        @siteid1               VarChar(10)
As
	Set	NoCount On

/* Setup */
	Declare @BatNbr        		VarChar(10),
		@BatNbrLen      	Int,
		@Counter		Int,
		@InvtID			VarChar(30),
		@SiteID			VarChar(10),
		@LastBatNbr		VarChar(10),
		@NextBatNbr		VarChar(10),
		@Batch_Created  	VarChar(1),
		@Process_Flag   	VarChar(1),
		@FiscYr         	VarChar(4),
		@PerNbr         	VarChar(6),
		@MatlOvhCalc    	VarChar(1),
		@DfltInvtAcct   	VarChar(10),
		@DfltInvtSub    	VarChar(24),
		@StdCstRevalAcct	VarChar(10),
		@StdCstRevalSub 	VarChar(24),
		@CtrlTot         	Float,
		@CrTot           	Float,
		@DrTot           	Float,
		@RecordCount     	Int,
		@ErrorFlag      	VarChar(1),
		@BMIEnabled      	VarChar(1),
		@Error			Integer,
		@BaseDecPl		SmallInt,
		@BMIDecPl		SmallInt,
		@DecPlPrcCst		SmallInt,
		@DecPlQty		SmallInt,
		@BatchCounter		SmallInt
		Select	@BatNbr         	= '',
		@BatNbrLen      	= 0,
		@Counter		= 0,
		@InvtID			= '',
		@SiteID			= '',
		@LastBatNbr		= '',
		@Batch_Created  	= '0',
		@Process_Flag   	= '0',
		@FiscYr         	= '',
		@PerNbr         	= '',
		@MatlOvhCalc    	= '',
		@DfltInvtAcct   	= '',
		@DfltInvtSub    	= '',
		@StdCstRevalAcct	= '',
		@StdCstRevalSub 	= '',
		@CtrlTot        	= 0,
		@CrTot          	= 0,
		@DrTot          	= 0,
		@RecordCount    	= 0,
		@ErrorFlag      	= '',
		@BMIEnabled  		= '',
		@Error			= 0,
		@BaseDecPl		= 0,
		@BMIDecPl		= 0,
		@DecPlPrcCst		= 0,
		@DecPlQty		= 0,
		@BatchCounter		= 1

	Select	@DfltInvtAcct = DfltInvtAcct,
		@DfltInvtSub = DfltInvtSub,
		@PerNbr = PerNbr,
		@FiscYr = SubString(PerNbr, 1, 4),
		@LastBatNbr = LastBatNbr,
		@BatNbrLen = DataLength(RTrim(LastBatNbr)),
		@MatlOvhCalc = MatlOvhCalc,
		@StdCstRevalAcct = StdCstRevalAcct,
		@StdCstRevalSub = StdCstRevalSub,
		@BMIEnabled = BMIEnabled
		From	INSetup (NoLock)

	Select	@BaseDecPl = BaseDecPl,
		@BMIDecPl = BMIDecPl,
		@DecPlPrcCst = DecPlPrcCst,
		@DecPlQty = DecPlQty
		From	vp_DecPl (NoLock)


/*	Since the IN10530_Return table does not have a CpnyID field, we will use
	ErrorInvtID for now.  This field is not populated by any of the 10530 routines
*/
	Delete	From	IN10530_Return
		Where	ComputerName = @UserAddress
			Or DateAdd(Day,2,Crtd_DateTime) < GetDate()

/* Begin Creating Missing ItemSite Records */
	Begin	Transaction

		Create	Table #MissingItemSite
			(Counter	Int Identity(1,1),
			InvtID		VarChar(30),
			SiteID		VarChar(10))
			Insert	Into #MissingItemSite
			(InvtID, SiteID)
		Select	INTran.InvtID, INTran.SiteID
			From	INTran (NoLock) Inner Loop Join Inventory (NoLock)
				On INTran.InvtID = Inventory.InvtID
			Where	Inventory.ValMthd = 'T'	/* Standard Cost */
				And  Not Exists (Select ItemSite.InvtID From ItemSite (NoLock)
					Where INTran.InvtID = ItemSite.InvtID
				And INTran.SiteID = ItemSite.SiteID)
				And INTran.S4Future05 = 0
				And INTran.Rlsed = 0
			Group By INTran.InvtID, INTran.SiteID
		Select	@RecordCount = 1, @Counter = 0

		While	(@RecordCount <> 0)
		Begin
			Select	Top 1
				@Counter = Counter,
				@InvtID = InvtID,
				@SiteID = SiteID
				From	#MissingItemSite
				Where	Counter > @Counter
				Order By Counter
			Set	@RecordCount = @@RowCount
			If	(@RecordCount <> 0)
			Begin
				Exec	DMG_Insert_ItemSite @InvtID, @SiteID, @CpnyID, '10530SQL', @UserName
				Set	@Error = @@Error
				If (@Error <> 0)
				Begin
					Goto	Abort
				End
				Else
				Begin
					Exec	ADG_Insert_IN10530_Return @SiteID, 0, @UserAddress, '', @InvtID, '', ''
					Set	@Error = @@Error
					If (@Error <> 0)
					Begin
						Goto	Abort
					End
				End
			End
		End

		Drop	Table #MissingItemSite

	Commit Transaction
/* End Creating Missing ItemSite Records */

	Begin Transaction

/* Product Class Standard Cost Update */
		If (@SelectionOption = 'P')
	        Begin
			Exec pp_10530_ProductClass @UserAddress, @ProgName, @UserName, @AllItems, @Process_Flag, @ErrorFlag
			Set	@Error = @@Error
			If (@Error <> 0 Or @ErrorFlag = 'Y')
			Begin
				Goto	Abort
			End

			Commit Transaction
	/*	Since the IN10530_Return table does not have a CpnyID field, we will use
	ErrorInvtID for now.  This field is not populated by any of the 10530 routines
*/
			Insert Into IN10530_Return
					(BatNbr, Batch_Created, ComputerName, Crtd_DateTime, ErrorFlag,
					ErrorInvtID, ErrorMessage, Process_Flag)
				Values	(@BatNbr, @Batch_Created, @UserAddress, GetDate(), '',
					@CpnyID, '', @Process_Flag)

			Goto Finish
	        End

/* Begin Building Set of ItemSite records that are to be Update and/or Recosted */

		Create	Table #ItemSite
			(BMIDirStdCst	Float,
			BMIPDirStdCst	Float,
			BMIPStdCst	Float,
			BMIRevalCost	Float,
			BMIStdCost	Float,
			BMINewTotCost	Float,
			BMITotCost	Float,
			Counter		Int Identity(1,1),
			CpnyID		VarChar(10),
			DirStdCst	Float,
			InvtAcct	VarChar(10),
			InvtID		VarChar(30),
			InvtSub		VarChar(24),
			NewTotCost	Float,
			PDirStdCst	Float,
			PStdCostDate	SmallDateTime,
			PStdCst		Float,
			QtyOnHand	Float,
			RevalCost	Float,
			SiteID		VarChar(10),
			StdCost		Float,
			TotCost		Float,
			StkUnit		VarChar(6),
			WhseLoc		VarChar(10))
			Insert	Into #ItemSite
			(BMIDirStdCst, BMIPDirStdCst, BMIPStdCst, BMIRevalCost, BMIStdCost, BMINewTotCost,
			BMITotCost, CpnyID, DirStdCst, InvtAcct, InvtID,
			InvtSub, PDirStdCst, PStdCostDate, PStdCst, RevalCost,
			QtyOnHand, SiteID, StdCost, TotCost, NewTotCost, StkUnit, WhseLoc)
		Select	BMIDirStdCst =	Case	When	@BMIEnabled = '1'
							Then	ItemSite.BMIDirStdCst
						Else	0
					End,
			BMIPDirStdCst =	Case	When	@BMIEnabled = '1'
							Then	ItemSite.BMIPDirStdCst
						Else	0
					End,
			BMIPStdCst =	Case	When	@BMIEnabled = '1'
							Then	ItemSite.BMIPStdCst
						Else	0
					End,
			0, BMIStdCost =	Case	When	@BMIEnabled = '1'
							Then	ItemSite.BMIStdCost
						Else	0
					End,
			ItemSite.BMITotCost,
			BMINewTotCost =	Case	When	@BMIEnabled = '1'
							Then	Case	When	@SelectionOption = 'I' /* Apply Pending Standard Cost Changes */
										Then	Case	When	@MatlOvhCalc = 'R'
													Then	Round(ItemSite.BMIPStdCst * ItemSite.QtyOnHand, @BMIDecPl)
												Else	Round(ItemSite.BMIPDirStdCst * ItemSite.QtyOnHand, @BMIDecPl)
											End
									Else	/* Revaluation of Inventory */
										Case	When	@MatlOvhCalc = 'R'
												Then	Round(ItemSite.BMIStdCost * ItemSite.QtyOnHand, @BMIDecPl)
											Else	Round(ItemSite.BMIDirStdCst * ItemSite.QtyOnHand, @BMIDecPl)
										End
								End
						Else	0
					End,
			ItemSite.CpnyID, ItemSite.DirStdCst,
			InvtAcct =	Case	When	RTrim(ItemSite.InvtAcct) <> ''
							Then	ItemSite.InvtAcct
						When	RTrim(Inventory.InvtAcct) <> ''
							Then	Inventory.InvtAcct
						When	Coalesce(ProductClass.DfltInvtAcct, '') <> ''
							Then	ProductClass.DfltInvtAcct
						Else	@DfltInvtAcct
					End,
			ItemSite.InvtID,
			InvtSub	=	Case	When	RTrim(ItemSite.InvtSub) <> ''
							Then	ItemSite.InvtSub
						When	RTrim(Inventory.InvtSub) <> ''
							Then	Inventory.InvtSub
						When	Coalesce(ProductClass.DfltInvtSub, '') <> ''
							Then	ProductClass.DfltInvtSub
						Else	@DfltInvtSub
					End,
			ItemSite.PDirStdCst, ItemSite.PStdCostDate, ItemSite.PStdCst, 0,
			ItemSite.QtyOnHand, ItemSite.SiteID, ItemSite.StdCost,
			ItemSite.TotCost,
			NewTotCost =	Case	When	@SelectionOption = 'I' /* Apply Pending Standard Cost Changes */
							Then	Case	When	@MatlOvhCalc = 'R'
										Then	Round(ItemSite.PStdCst * ItemSite.QtyOnHand, @BaseDecPl)
									Else	Round(ItemSite.PDirStdCst * ItemSite.QtyOnHand, @BaseDecPl)
								End
						Else	/* Revaluation of Inventory */
							Case	When	@MatlOvhCalc = 'R'
									Then	Round(ItemSite.StdCost * ItemSite.QtyOnHand, @BaseDecPl)
								Else	Round(ItemSite.DirStdCst * ItemSite.QtyOnHand, @BaseDecPl)
							End
					End,
			Inventory.StkUnit,
			WhseLoc = Coalesce((Select Top 1 WhseLoc From Location Where InvtID = ItemSite.InvtID And SiteID = ItemSite.SiteID And WhseLoc <> ''), '')
			From	ItemSite (NoLock) Inner Join Inventory
				On ItemSite.InvtID = Inventory.InvtID
				Inner Join Site
				On ItemSite.SiteID = Site.SiteID
                                Left Join ProductClass
				On Inventory.ClassID = ProductClass.ClassID
				Left Join IN10530_Wrk INWork	/* Work Table populated by screen selection */
				On ItemSite.InvtID = INWork.InvtID
				And INWork.ComputerName = @UserAddress
			Where	Inventory.ValMthd = 'T'	/* Standard Cost */
				And (	Case	When	@AllItems = '0'
							Then	INWork.InvtID
						Else	ItemSite.InvtID
					End) Is Not Null
				And (@SelectionOption = 'R' Or (
					ItemSite.PStdCostDate <= GetDate()
					And ItemSite.PStdCostDate <> ''
					And Round(ItemSite.PStdCst, @DecPlPrcCst) <> Round(ItemSite.StdCost, @DecPlPrcCst)
					)
				)
                                And ItemSite.SiteId Like @SiteId1
				And Site.CpnyID = @CpnyID
				Order By ItemSite.InvtID, ItemSite.SiteID
		/* End Building Set of ItemSite records that are to be Update and/or Recosted */
			Create	Table #INTran
			(BatNbr		VarChar (10),
			BMITranAmt	Float,
			CpnyID		VarChar (10),
			DrCr		VarChar (1),
			INTran_ID	Int Identity(1,1),
			InvtAcct	VarChar(10),
			InvtID		VarChar(30),
			InvtSub		VarChar(24),
			InvtMult	SmallInt,
			LineID		Int,
			RecordID	Int,
			S4Future04	Float,
			SiteID		VarChar (10),
			TranAmt		Float,
			UnitDesc	VarChar(6),
			WhseLoc		VarChar (10))

		Set	@Error = @@Error
		If (@Error <> 0)
		Begin
			Goto	Abort
		End

		Create	Table #INTran_Sum
			(InvtID		VarChar(30),
			SiteID		VarChar(10),
			BMIRevalCost	Float,
			RevalCost	Float)
			Set	@Error = @@Error
		If (@Error <> 0)
		Begin
			Goto	Abort
		End

		If (@AdjustTrans <> '0')
		Begin	/* Create Revaluation Adjustment Transactions */

			Insert 	#INTran
				(BatNbr, BMITranAmt, CpnyID, DrCr, InvtAcct,
				InvtID, InvtSub, InvtMult, LineID, RecordID,
				S4Future04, SiteID, TranAmt, UnitDesc, WhseLoc)
			Select	'',
				BMITranAmt =	Case	When 	@MatlOvhCalc = 'R'  /* When Received */
	                    					Then	Round(Round(#ItemSite.BMIPStdCst - #ItemSite.BMIStdCost, @DecPlPrcCst) *
									Case	When	INTran.CnvFact In (0, 1)
											Then	Round(INTran.Qty, @DecPlQty)
										When	INTran.UnitMultDiv = 'D'
											Then	Round(INTran.Qty / INTran.CnvFact, @DecPlQty)
										Else	Round(INTran.Qty * INTran.CnvFact, @DecPlQty)
									End, @BMIDecPl)
							Else /* Material Overhead Method is When Used or None. */
								Round(Round(#ItemSite.BMIPDirStdCst - #ItemSite.BMIDirStdCst, @DecPlPrcCst) *
								Case	When	INTran.CnvFact In (0, 1)
										Then	Round(INTran.Qty, @DecPlQty)
									When	INTran.UnitMultDiv = 'D'
										Then	Round(INTran.Qty / INTran.CnvFact, @DecPlQty)
									Else	Round(INTran.Qty * INTran.CnvFact, @DecPlQty)
								End, @BMIDecPl)
						End,	/* End of BMITranAmt */
				INTran.CpnyID, DrCr = '', #ItemSite.InvtAcct, INTran.InvtID, #ItemSite.InvtSub,
				INTran.InvtMult, LineID = 0, INTran.RecordID,
				S4Future04 = 	Case	When	@MatlOvhCalc = 'R'  /* When Received */
								Then	Round(#ItemSite.PStdCst, @DecPlPrcCst)
							Else	  /* When Used or None */
								Round(#ItemSite.PDirStdCst ,@DecPlPrcCst)
						End,
				INTran.SiteID,
				TranAmt = 	Case	When 	@MatlOvhCalc = 'R'  /* When Received */
	                    					Then	Round(Round(#ItemSite.PStdCst - #ItemSite.StdCost, @DecPlPrcCst) *
									Case	When	INTran.CnvFact In (0, 1)
											Then	Round(INTran.Qty, @DecPlQty)
										When	INTran.UnitMultDiv = 'D'
											Then	Round(INTran.Qty / INTran.CnvFact, @DecPlQty)
										Else	Round(INTran.Qty * INTran.CnvFact, @DecPlQty)
									End, @BaseDecPl)
							Else /* Material Overhead Method is When Used or None. */
								Round(Round(#ItemSite.PDirStdCst - #ItemSite.DirStdCst, @DecPlPrcCst) *
								Case	When	INTran.CnvFact In (0, 1)
										Then	Round(INTran.Qty, @DecPlQty)
									When	INTran.UnitMultDiv = 'D'
										Then	Round(INTran.Qty / INTran.CnvFact, @DecPlQty)
									Else	Round(INTran.Qty * INTran.CnvFact, @DecPlQty)
								End, @BaseDecPl)
						End,	/* End of TranAmt */
				UnitDesc = #ItemSite.StkUnit, INTran.WhseLoc
				From	INTran (NoLock) Inner Join #ItemSite
					On INTran.InvtID = #ItemSite.InvtID
					And INTran.SiteID = #ItemSite.SiteID
					And INTran.CpnyID = #ItemSite.CpnyID
				Where	INTran.CpnyID = @CpnyID
					And INTran.Rlsed = 1			/* Only recost Released Transactions */
					And INTran.S4Future05 = 0		/* Don't recost Retired Transactions */
					And INTran.LayerType = 'S'		/* Standard Layer Type */
					And Round(INTran.Qty, @DecPlQty) <> 0	/* Only Transactions with quantity */
					And INTran.TranType In ('AB', 'CT', 'CG')
					And INTran.TranDate >= @RevalEffDate

			Set	@Error = @@Error
			If (@Error <> 0)
			Begin
				Goto	Abort
			End

/* Sum the costs from the temp table #INTran into #INTran_Sum */
			Insert	#INTran_Sum
				(BMIRevalCost, InvtID, SiteID, RevalCost)
				Select	BMIRevalCost = Round(Sum(Round(BMITranAmt * InvtMult, @BMIDecPl)), @BMIDecPl),
					InvtID, SiteID,
					RevalCost = Round(Sum(Round(TranAmt * InvtMult, @BaseDecPl)), @BaseDecPl)
					From	#INTran
					Group By InvtID, SiteID
				Set	@Error = @@Error
			If (@Error <> 0)
			Begin
				Goto	Abort
			End

/*
	Move the summed values from temp table #INTran_Sum into the temp table #ItemSite.
	This will allow for a balancing transaction to be created in the event that not all
	previously released transactions are re-costed.
*/
			Update	#ItemSite
				Set	#ItemSite.BMIRevalCost = #INTran_Sum.BMIRevalCost,
					#ItemSite.RevalCost = #INTran_Sum.RevalCost
				From	#ItemSite Inner Join #INTran_Sum
					On #ItemSite.InvtID = #INTran_Sum.InvtID
					And #ItemSite.SiteID = #INTran_Sum.SiteID
			Set	@Error = @@Error
			If (@Error <> 0)
			Begin
				Goto	Abort
			End

		End	/* End Create Revaluation Adjustment Transactions */

/* Generate the balancing transaction into the temp table #INTran. */
		Insert 	#INTran
			(BatNbr, BMITranAmt, CpnyID, DrCr, InvtAcct,
			InvtID, InvtSub, InvtMult, LineID, RecordID, S4Future04,
			SiteID, TranAmt, UnitDesc, WhseLoc)
		Select	'',
			BMITranAmt = Round(BMINewTotCost - Round(BMITotCost + BMIRevalCost, @BMIDecPl), @BMIDecPl),
			CpnyID, DrCr = '', InvtAcct, InvtID, InvtSub, InvtMult = 1, LineID = 0, RecordID = 0,
			S4Future04 = 	Case	When	@MatlOvhCalc = 'R'  /* When Received */
							Then	Round(#ItemSite.PStdCst, @DecPlPrcCst)
						Else	  /* When Used or None */
							Round(#ItemSite.PDirStdCst ,@DecPlPrcCst)
					End,
			SiteID,
			TranAmt = Round(NewTotCost - Round(TotCost + RevalCost, @BaseDecPl), @BaseDecPl),
			StkUnit, WhseLoc
			From	#ItemSite

		Delete	From #INTran
			Where	Round(TranAmt, @BaseDecPl) = 0

		Set	@Error = @@Error
		If (@Error <> 0)
		Begin
			Goto	Abort
		End

		Update	#INTran
			Set	DrCr =	Case	When	Round(TranAmt * InvtMult, @BaseDecPl) < 0
							Then	'C'
						Else	'D'
					End

		Set	@Error = @@Error
		If (@Error <> 0)
		Begin
			Goto	Abort
		End

		Select	@RecordCount = Count(*) From #INTran Where BatNbr = ''

		While	(@RecordCount > 0)
		Begin
			Select @LastBatNbr = LastBatNbr From INSetup (UPDLOCK)
			Exec	Create_New_Batch @LastBatNbr, @Module, @BatNbr Output
			Set	@Error = @@Error
			If (@Error <> 0)
			Begin
				Goto	Abort
			End

			Set	@LastBatNbr = @BatNbr

/* Update Batch Record */
			Update	Batch
				Set	BatType = 'N',
					CpnyID = @CpnyID,
					Crtd_DateTime = GetDate(), Crtd_Prog = @ProgName, Crtd_User = @UserName,
					Descr = 'Inventory ReEvaluation',
					EditScrnNbr = '10530',
					JrnlType = @Module,
					LUpd_DateTime = GetDate(), LUpd_Prog = @ProgName, LUpd_User = @UserName,
					PerEnt = @PerNbr,
					PerPost = @PerNbr,
					Status = 'V'
				From	Batch
				Where	BatNbr = @LastBatNbr
					And Module = @Module

			Set	@Error = @@Error
			If (@Error <> 0)
			Begin
				Goto	Abort
			End
			Select @Batch_Created = '1'

			Exec	ADG_Insert_IN10530_Return @LastBatNbr, @Batch_Created, @UserAddress, '', @CpnyID, '', ''
			Set	@Error = @@Error
			If (@Error <> 0)
			Begin
				Goto	Abort
			End

			Create	Table #Batch
				(BatNbr		VarChar(10),
				Counter		Int Identity(1,1),
				INTran_ID	Int)

			Insert Into #Batch
				(BatNbr, INTran_ID)
			Select	Top 32767
				@LastBatNbr, INTran_ID
				From	#INTran
				Where	BatNbr = ''
				Order By InvtID, SiteID

			Update	#INTran
				Set	BatNbr = #Batch.BatNbr,
					LineID = #Batch.Counter
				From	#INTran Inner Join #Batch
					On #INTran.INTran_ID = #Batch.INTran_ID

			Drop	Table	#Batch

			Update	INBatch
				Set	BatNbr = '', LineID = 0
				From	#INTran InBatch Inner Join #INTran OutBatch
					On InBatch.InvtID = OutBatch.InvtID
					And InBatch.SiteID = OutBatch.SiteID
				Where	InBatch.BatNbr <> ''
					And OutBatch.BatNbr = ''

			Select	@RecordCount = Count(*) From #INTran Where BatNbr = ''
		End

		If (@AdjustTrans <> '0')
		Begin	/* Insert Revaluation Adjustment Transactions into INTran */

			Insert	Into INTran
				(Acct, AcctDist, ARLineId, ARLineRef, BatNbr,
				BMICuryID, BMIEffDate, BMIExtCost, BMIMultDiv, BMIRate,
				BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct, KitID,
				CnvFact, COGSAcct, COGSsub, CostType, CpnyID,
				Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt,
				ExtCost, ExtRefNbr, FiscYr, Id, InsuffQty,
				InvtAcct, InvtID, InvtMult, InvtSub, JrnlType,
				LayerType, LineId, LineNbr, LineRef, LotserCntr,
				LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OvrhdAmt,
				OvrhdFlag, PC_Flag, PC_ID, PC_Status, PerEnt,
				PerPost, ProjectID, Qty, QtyUnCosted, RcptDate,
				RcptNbr, ReasonCd, RefNbr, Rlsed, S4Future01,
				S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
				S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
				S4Future12, ShortQty, SiteID, SlsperId, SpecificCostID,
				Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt,
				TranDate, TranDesc, TranType, UnitDesc, UnitMultDiv,
				UnitPrice, User1, User2, User3, User4,
				User5, User6, User7, User8, WhseLoc)
			Select	INTran.InvtAcct,
				INTran.AcctDist, INTran.ARLineId, INTran.ARLineRef, #INTran.BatNbr,
				INTran.BMICuryID, INTran.BMIEffDate, BMIExtCost = 0, INTran.BMIMultDiv, INTran.BMIRate,
				INTran.BMIRtTp, #INTran.BMITranAmt, INTran.BMIUnitPrice, INTran.CmmnPct, INTran.KitID,
				CnvFact = 1, COGSAcct = Space(1), COGSSub = Space(1), CostType = '', #INTran.CpnyID,
				GetDate(), @ProgName, @UserName, #INTran.DrCr, INTran.Excpt,
				ExtCost = 0, INTran.ExtRefNbr, @FiscYr, INTran.Id, INTran.InsuffQty,
				Case INTran.TranType When 'CG' Then INTran.COGSAcct Else INTran.Acct End,
				INTran.InvtID, #INTran.InvtMult,
				Case INTran.TranType When 'CG' Then INTran.COGSSub Else INTran.Sub End,
				'IN', INTran.LayerType, #INTran.LineID, LineNbr = (-32768 + #INTran.LineID),
				LineRef = Right('00000' + Cast(#INTran.LineID As VarChar(10)),5), 0,
				GetDate(), @ProgName, @UserName, INTran.NoteID, 0,
				0, INTran.PC_Flag, INTran.PC_ID, INTran.PC_Status, @PerNbr,
				@PerNbr, INTran.ProjectID, 0, 0, INTran.RcptDate,
				INTran.RcptNbr, INTran.ReasonCd, RefNbr = '10530UPD', 0, S4Future01 = INTran.BatNbr,
				S4Future02 = INTran.RefNbr, INTran.S4Future03, #INTran.S4Future04, INTran.S4Future05, INTran.S4Future06,
				INTran.S4Future07, INTran.S4Future08, S4Future09 = 0, S4Future10 = 0, S4Future11 = INTran.LineRef,
				INTran.S4Future12, ShortQty = 0, INTran.SiteID, INTran.SlsperId, INTran.SpecificCostID,
				INTran.InvtSub,
				INTran.TaskID, INTran.ToSiteID, INTran.ToWhseLoc, #INTran.TranAmt,
				INTran.TranDate, INTran.TranDesc, 'AC', #INTran.UnitDesc, UnitMultDiv = 'M',
				INTran.UnitPrice, INTran.User1, INTran.User2, INTran.User3, INTran.User4,
				INTran.User5, INTran.User6, INTran.User7, INTran.User8, #INTran.WhseLoc
				From	INTran Inner Join #INTran
					On INTran.RecordID = #INTran.RecordID
				Where	#INTran.RecordID <> 0

		End	/* End of INTran Insert */

/* Insert Balancing or Revaluation Transactions */
		Insert	Into INTran
			(Acct, BatNbr, BMITranAmt, BMIMultDiv, CpnyID, Crtd_DateTime,
			Crtd_Prog, Crtd_User, DrCr, FiscYr, InvtAcct,
			InvtID, InvtSub, JrnlType, LayerType, LineID,
			LineNbr, LineRef, LUpd_DateTime, LUpd_Prog, LUpd_User,
			PerEnt, PerPost, RefNbr, SiteID, Sub,
			TranAmt, TranDate, TranDesc, TranType, UnitDesc,
			CnvFact, InvtMult, S4Future04, UnitMultDiv, WhseLoc)
		Select	InvtAcct, BatNbr, BMITranAmt, BMIMultDiv = 'M', CpnyID, GetDate(),
			@ProgName, @UserName, DrCr, @FiscYr, @StdCstRevalAcct,
			InvtID, @StdCstRevalSub, 'IN', 'S', LineID, (-32768 + LineID),
			LineRef = Right('00000' + Cast(LineID As VarChar(10)),5),
			GetDate(), @ProgName, @UserName, @PerNbr, @PerNbr,
			RefNbr = '10530UPD', SiteID, InvtSub, TranAmt,
			TranDate =	Case	When	@AdjustTrans <> '0'
							Then	@RevalEffDate
						Else	GetDate()
					End,
                  	InvtID, TranType = 'AC', UnitDesc, CnvFact = 1, InvtMult = 1,
			S4Future04, UnitMultDiv = 'M', WhseLoc
			From	#INTran
				Where	RecordID = 0

		If	(@SelectionOption = 'I')
		Begin
			Update	Inventory
				Set	LastStdCost = StdCost,
					PStdCostDate = '01/01/1900',
					StdCostDate = GetDate(),
					DirStdCost = PDirStdCost,
					FOvhStdCost = PFOvhStdCost,
					StdCost = PStdCost,
					VOvhStdCost = PVOvhStdCost,
					PDirStdCost = 0,
					PFOvhStdCost = 0,
					PStdCost = 0,
					PVOvhStdCost = 0,
					BMIDirStdCost =	Case	When	BMIPStdCost <> 0
									Then	BMIPDirStdCost
								Else 	BMIDirStdCost
							End,
					BMIFOvhStdCost =	Case	When	BMIPStdCost <> 0
										Then	BMIPFOvhStdCost
									Else 	BMIFOvhStdCost
								End,
					BMIVOvhStdCost =	Case 	When 	BMIPStdCost <> 0
										Then 	BMIPVOvhStdCost
									Else 	BMIVOvhStdCost
								End,
					BMIStdCost = 	Case 	When 	BMIPStdCost <> 0
									Then 	BMIPStdCost
								Else 	BMIStdCost
							End,
					BMIPDirStdCost = 0,
					BMIPFOvhStdCost = 0,
					BMIPStdCost = 0,
					BMIPVOvhStdCost = 0,
					LUpd_DateTime = GetDate(), LUpd_Prog = @ProgName, LUpd_User = @UserName
				From	Inventory Left Join IN10530_Wrk INWork	/* Work Table populated by screen selection */
					On Inventory.InvtID = INWork.InvtID
					And INWork.ComputerName = @UserAddress
				Where	Inventory.ValMthd = 'T'	/* Standard Cost */
					And Inventory.PStdCostDate <= GetDate()
					And Inventory.PStdCostDate <> ''
					And (	Case	When	@AllItems = '0'
								Then	INWork.InvtID
							Else	Inventory.InvtID
						End) Is Not Null
			Set	@Error = @@Error
			If	(@@RowCount <> 0)
			Begin
				Select	@Process_Flag = '1'
			End
			If (@Error <> 0)
			Begin
				Goto	Abort
			End

			Update	ItemSite
				Set	LastStdCost = ItemSite.StdCost,
					PStdCostDate = '01/01/1900',
					StdCostDate = GetDate(),
					DirStdCst = ItemSite.PDirStdCst,
					FOvhStdCst = ItemSite.PFOvhStdCst,
					StdCost = ItemSite.PStdCst,
					VOvhStdCst = ItemSite.PVOvhStdCst,
					PDirStdCst = 0,
					PFOvhStdCst = 0,
					PStdCst = 0,
					PVOvhStdCst = 0,
					BMIDirStdCst =	Case	When	ItemSite.BMIPStdCst <> 0
									Then	ItemSite.BMIPDirStdCst
								Else 	ItemSite.BMIDirStdCst
							End,
					BMIFOvhStdCst =	Case	When	ItemSite.BMIPStdCst <> 0
										Then	ItemSite.BMIPFOvhStdCst
									Else 	ItemSite.BMIFOvhStdCst
								End,
					BMIVOvhStdCst =	Case 	When 	ItemSite.BMIPStdCst <> 0
										Then 	ItemSite.BMIPVOvhStdCst
									Else 	ItemSite.BMIVOvhStdCst
								End,
					BMIStdCost = 	Case 	When 	ItemSite.BMIPStdCst <> 0
									Then 	ItemSite.BMIPStdCst
								Else 	ItemSite.BMIStdCost
							End,
					BMIPDirStdCst = 0,
					BMIPFOvhStdCst = 0,
					BMIPStdCst = 0,
					BMIPVOvhStdCst = 0,
					LUpd_DateTime = GetDate(), LUpd_Prog = @ProgName, LUpd_User = @UserName
				From	ItemSite Inner Join Inventory
					On ItemSite.InvtID = Inventory.InvtID
					Inner Join Site
					On ItemSite.SiteID = Site.SiteID
                                        And ItemSite.SiteId Like @SiteId1
					and Site.CpnyID = @CpnyID
					Left Join IN10530_Wrk INWork	/* Work Table populated by screen selection */
					On ItemSite.InvtID = INWork.InvtID
					And INWork.ComputerName = @UserAddress
				Where	Inventory.ValMthd = 'T'	/* Standard Cost */
					And ItemSite.PStdCostDate <= GetDate()
					And ItemSite.PStdCostDate <> ''
					And (	Case	When	@AllItems = '0'
								Then	INWork.InvtID
							Else	ItemSite.InvtID
						End) Is Not Null
			Set	@Error = @@Error
			If	(@@RowCount <> 0)
			Begin
				Select	@Process_Flag = '1'
			End
			If (@Error <> 0)
			Begin
				Goto	Abort
			End
		End

		Update	Batch
			Set	Status = 'B'
			From	Batch Inner Join IN10530_Return INReturn
				On Batch.BatNbr = INReturn.BatNbr
				And Batch.CpnyID = INReturn.ErrorInvtID /* ErrorInvtID stores the company ID */
			Where	Batch.Module = @Module
				And Batch.JrnlType = @Module
				And INReturn.ComputerName = @UserAddress
		Set	@Error = @@Error
		If (@Error <> 0)
		Begin
			Goto	Abort
		End

		Update	INSetup
			Set	LastBatNbr = @LastBatNbr
		Set	@Error = @@Error
		If (@Error <> 0)
		Begin
			Goto	Abort
		End

	Print	'Inventory Revaluation Complete'
	Commit 	Transaction

	Goto	Finish

ABORT:
	Rollback Transaction

	Insert Into IN10530_Return
			(BatNbr, Batch_Created, ComputerName, Crtd_DateTime, ErrorFlag,
			ErrorInvtID, ErrorMessage, Process_Flag)
		Values	(@BatNbr, @Batch_Created, @UserAddress, GetDate(), '',
			@CpnyID, '', @Process_Flag)
Finish:
-- Purge Work Records

	Delete	From	IN10530_Wrk
		Where	ComputerName = @UserAddress
	                Or DateAdd(Day, 1, Crtd_DateTime) < GetDate()


