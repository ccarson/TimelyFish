
CREATE PROCEDURE PI_Adjustments
	@p_PIID 		VarChar(10),
	@p_CpnyId 		VarChar(10),
	@p_SiteID 		VarChar(10),
	@p_DateFreez 	SmallDateTime,
	@p_AdjPerBatch 	Integer,
	@p_PITagType 	VarChar(1),
	@p_Descr 		VarChar(30),
	@p_Acct 		VarChar(10),
	@p_Sub 			VarChar(30),
	@p_TagNum 		VarChar(30),
	@p_Username 	VarChar(10),
	@P_PerClosed	VarChar(6),
	@p_FirstBatNbr  Integer,
	@p_LastBatNbr   Integer
As
	Set	NoCount On

	Declare	@SQlError		Integer,
			@BatNbr_Len		SmallInt,
			@BatNbr_Str		VarChar(10),
			@CurPerNbr 		VarChar(6),
			@FiscYr			VarChar(4),
			@BatCount 		Integer,
			@NumOfAdj 		Integer,
			@NumOfBat 		Integer,
			@BatchNumber 	Integer,
			@GLPostOpt 		Char(1),
			@MinRec 		Integer,
			@MaxRec 		Integer,
			@AdjAmount 		Float,
			@AdjQuantity 	Float,
			@INInvt_Acct	Char(10),
			@INInvt_Sub     Char(30),
			@DecPlQty		SmallInt,
			@BaseDecPl		SmallInt
			
	Select	@BatNbr_Len = Len(LTrim(LastBatNbr)),	/*	Determines Batch Number Mask Length	*/
			@CurPerNbr = CurrPerNbr,				/*	Current Period Number	*/
			@FiscYr	= Left(CurrPerNbr, 4),			/*	Current Fiscal Year	*/
			@GLPostOpt = GLPostOpt,					/*	General Ledger Post Option D - Detail, S - Summary	*/
			@INInvt_Acct = DfltInvtAcct,			/*	Default Inventory Account	*/
			@INInvt_Sub =  DfltInvtSub				/*	Default Inventory Sub Account	*/
	From INSetup (nolock)

	Select	@BaseDecPl = BaseDecPl,					/*	Base Currency Decimal Position	*/
			@DecPlQty = DecPlQty					/*	Quantity Decimal Position	*/
	From	vp_DecPl

/*	Create a temporary table that will return the list of new batches created.	*/
	Create	Table #BatchList
		(
		BatNbr	VarChar(10)
		)

/*	Concatonate the Physical Inventory ID and the Physical Inventory Description together.	*/
	Select @p_Descr = Left(RTrim(@p_PIID) + '-' + RTrim(@p_Descr), 30)

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

/*	Create Temporary Table to hold adjustments to be processed.	*/
	Create Table #Adj10397_1
		(
		AdjAmt 			Float,
		AdjQty			Float,
		AvgCost 		Float,
		InvtID 			VarChar(30),
		LineCount 		Integer Identity(1,1),
		LayerType		VarChar(10),
		LotOrSer 		Char(1),
		LotSerNbr 		VarChar(25),
		RcptNbr			VarChar(30),
		RcptDate		smalldatetime,
		SpecificCostID 	VarChar(25),
		TagNumber 		VarChar(10),
		Unit 			VarChar(10),
		WhseLoc 		VarChar(10),
		ValMthd         VarChar(1),
		SiteID          VarChar(10)
		)

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

/*	Insert valid adjustments from the Physical Inventory tables into the temporary table.	*/
	Insert #ADJ10397_1
	Select	AdjAmt = Round(Coalesce(PIDetCost.AdjQty, Round(PIDetail.PhysQty - PIDetail.BookQty, @DecPlQty)) * Coalesce(PIDetCost.S4Future03,PIDetail.UnitCost), @BaseDecPl),
		AdjQty = Coalesce(PIDetCost.AdjQty, Round(PIDetail.PhysQty - PIDetail.BookQty, @DecPlQty)),
		AvgCost =Coalesce(PIDetCost.S4Future03,PIDetail.UnitCost),
		PIDetail.InvtID,
		LayerType = Coalesce(PIDetCost.S4Future11, 'S'),
		PIDetail.LotOrSer, PIDetail.LotSerNbr,
		RcptNbr = Coalesce(PIDetCost.S4Future01, ''),
		RcptDate = Coalesce(PIDetCost.S4Future07,'1900-01-01'),
		SpecificCostID = Coalesce(PIDetCost.SpecCostID, ''),
		TagNumber = Cast(PIDetail.Number As VarChar(10)), PIDetail.Unit, PIDetail.WhseLoc,
		ValMthd = Inventory.ValMthd,
		SiteID = PIDetail.SiteID
	From	PIDetail Join Inventory (NOLOCK)
		on PIDetail.InvtId = Inventory.InvtId
			 Left Join PIDetCost
				On PIDetail.PIID = PIDetCost.PIID
					And PIDetail.Number = PIDetCost.Number
	Where	PIDetail.PIID = @P_PIID
		And Round(PIDetail.BookQty, @DecPlQty) <> Round(PIDetail.PhysQty, @DecPlQty)
		And PIDetail.Status = 'E'	/*	Entered		*/
	Order By PIDetail.InvtID

/* 	Find records where the sum of qtys for a cost layer will take itemcost.qty to 0. If so, the adjustment
		amount will be bumped up or down on the first detail line for that layer to take totcost to 0 as well.
		This ensures that qty and cost go 0 at the same time on the itemcost record.
*/
	 select ic.totcost,ic.Qty, sumadj=adj.adjamt, ic.InvtId, ic.SiteID, ic.LayerType, ic.SpecificCostID,lastline=adj.LineCount,
			  ic.RcptNbr, ic.RcptDate
		into #PI_Round_adjs
		from ItemCost ic 
			Join (select a.InvtId, a.LayerType,
					a.SpecificCostID, a.RcptNbr, a.RcptDate,
					AdjQty=sum(a.AdjQty), AdjAmt=sum(a.AdjAmt), LineCount=max(a.LineCount)
				from  #ADJ10397_1 a
				Group by a.InvtId,
						a.LayerType,
						a.SpecificCostID, a.RcptNbr, a.RcptDate) adj
				On ic.InvtId = adj.InvtId
					and	ic.LayerType = adj.LayerType
					and	ic.SpecificCostID = adj.SpecificCostID
					and	ic.RcptNbr = adj.RcptNbr
					and	ic.RcptDate = adj.RcptDate
		where 	ic.SiteID  = @p_SiteID
			and	ic.Qty + adj.AdjQty = 0
			and ic.totcost <> adj.AdjAmt
 /*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

/*	update AdjAmt if adjustments qty equals ItemCost qty, due to possible rounding errors	*/
/*	Similar logic is implemented in 10.400 for Adjustments. CalculatedCost.          	*/
	update	#ADJ10397_1
	set	AdjAmt = adjamt - (adj.totcost + adj.sumadj)
	from	#ADJ10397_1 a, #PI_Round_adjs adj
	where	a.InvtId = adj.InvtId
		and	a.LayerType = adj.LayerType
		and	a.SpecificCostID = adj.SpecificCostID
		and	a.RcptNbr = adj.RcptNbr
		and	a.RcptDate = adj.RcptDate
		and	a.LineCount   = adj.lastline

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

/*  	Now do the same rounding adjustment, this time by site instead of cost layer */
	select ISt.totcost,ISt.QtyOnHand, sumadj=adj.adjamt, ISt.InvtId, ISt.SiteID, lastline=adj.LineCount
	into #PI_Round_adjs2
	from ItemSite ISt 
		Join (select a.InvtId, a.SiteId,
				AdjQty=sum(a.AdjQty), AdjAmt=sum(a.AdjAmt),
				LineCount=max(a.LineCount)
			from  #ADJ10397_1 a
			Group by a.InvtId,
					a.SiteId) adj
		On ISt.InvtId = adj.InvtId
			and	ISt.SiteID = adj.SiteID
		where 	ISt.SiteID  = @p_SiteID
		   and  ISt.CpnyID = @P_CpnyId
			and	ISt.QtyOnHand + adj.AdjQty = 0
			and ISt.totcost <> adj.AdjAmt
 /*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

/*	update AdjAmt if adjustments qty equals ItemSite qty, due to possible rounding errors	*/
/*	Similar logic is implemented in 10.400 for Adjustments. CalculatedCost.          	*/
	update	#ADJ10397_1
	set	AdjAmt = adjamt - (adj.totcost + adj.sumadj)
	from	#ADJ10397_1 a, #PI_Round_adjs2 adj
	where	a.InvtId = adj.InvtId
		and	a.SiteID = adj.Siteid
		and a.LineCount = adj.lastline
		and a.ValMthd Not in('F', 'L', 'S', 'U')

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

	Set @NumOfBat = @p_LastBatNbr - @p_FirstBatNbr + 1
	Select @BatchNumber = 0, @MinRec = 0, @MaxRec = @p_AdjPerBatch


/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

	Begin Tran
/*	Loop once for each batch that should be created.	*/
	While @BatchNumber < @NumOfBat
	Begin
	      set @BatNbr_Str = Right(Replicate('0', @BatNbr_Len) + Cast(@p_FirstBatNbr As VarChar(10)), @BatNbr_Len)
			/*	Create the INTran records for the current batch.	*/
			Insert	INTran
				(
				Acct, BatNbr, CnvFact, CpnyID, Crtd_Prog,
				Crtd_User, DrCr, ExtCost,ExtRefNbr, FiscYr, InvtAcct,
				InvtID, InvtMult, InvtSub, JrnlType, LayerType, LineID,
				LineNbr, LineRef, LUpd_DateTime, LUpd_Prog, LUpd_User,
				PerEnt, PerPost, Qty, RefNbr,RcptNbr, RcptDate, SiteID,
				SpecificCostID, Sub, TranAmt, TranDate, TranDesc,
				TranType, UnitDesc, UnitMultDiv, UnitPrice, WhseLoc
				)
				Select	Acct = @p_Acct, BatNbr = @BatNbr_Str, CnvFact = 1, CpnyID = @p_CpnyID, Crtd_Prog = '10397',
						UserName = @p_UserName, DrCr = 'C', ExtCost = Adj.AdjAmt,ExtRefNbr = Adj.TagNumber, FiscYr = @FiscYr,
						InvtAcct =	Case When Len(LTrim(Coalesce(ItemSite.InvtAcct, ''))) > 0
										Then ItemSite.InvtAcct
									When Len(LTrim(Coalesce(Inventory.InvtAcct, ''))) > 0
										Then Inventory.InvtAcct
									Else @INInvt_Acct
								End,
					Adj.InvtID, InvtMult = 1,
					InvtSub = 	Case When Len(LTrim(Coalesce(ItemSite.InvtSub, ''))) > 0
									Then ItemSite.InvtSub
								When Len(LTrim(Coalesce(Inventory.InvtSub, ''))) > 0
									Then Inventory.InvtSub
								Else @INInvt_Sub
							End,
					JrnlType = 'IN', Adj.LayerType, LineID = Adj.LineCount,
					LineNbr = Adj.LineCount, LineRef = Right(Replicate('0', 5) + Cast(Adj.LineCount As VarChar(10)), 5),
					LUpd_DateTime = GetDate(), LUpd_Prog = '10397', LUpd_User = @p_UserName,
					PerEnt = @CurPerNbr, PerPost = @P_PerClosed, Qty = Adj.AdjQty, RefNbr = @p_PIID,Adj.RcptNbr, Adj.RcptDate, SiteID = @p_SiteID,
					Adj.SpecificCostID, Sub = @p_Sub, TranAmt = Adj.AdjAmt, TranDate = @p_DateFreez,
					TranDesc = Left(RTrim(@p_TagNum) + RTrim(Adj.TagNumber), 30),
					TranType = 'PI', UnitDesc = Adj.Unit, UnitMultDiv = 'M', UnitPrice = Adj.AvgCost, Adj.WhseLoc
				From	#Adj10397_1 Adj 
					Left Join ItemSite
						On Adj.InvtID = ItemSite.InvtID
							And ItemSite.SiteID = @P_SiteID
					Join Inventory
						On Adj.InvtID = Inventory.InvtID
				Where 	Adj.LineCount > @MinRec
					And Adj.LineCount <= @MaxRec
				And ISNULL(ItemSite.CpnyID, @P_CpnyId) = @P_CpnyId


			/*	Preserve SQL Error Number and Determine if an error occurred.	*/
			Set	@SQLError = @@Error
			If	@SQLError <> 0 Goto Abort

			update	L
			set	QtyAllocIN = round(L.QtyAllocIN - D.QtyAllocIN, @DecPlQty),
				QtyAvail = round(L.QtyAvail + D.QtyAllocIN, @DecPlQty)
			from	Location L
			inner	join
				(select INTran.InvtID, INTran.SiteID, INTran.WhseLoc,
					QtyAllocIN = round(sum(INTran.Qty), @DecPlQty)
				from	INTran, LocTable
				where	INTran.BatNbr = @BatNbr_Str
					and	INTran.Qty < 0
					and	INTran.SiteID = LocTable.SiteID
					and	INTran.WhseLoc = LocTable.WhseLoc
					and	LocTable.InclQtyAvail = 1
				group by INTran.InvtID, INTran.SiteID, INTran.WhseLoc) D
			on	L.InvtID = D.InvtID
				and	L.SiteID = D.SiteID
				and	L.WhseLoc = D.WhseLoc

			/*	Preserve SQL Error Number and Determine if an error occurred.	*/
			Set	@SQLError = @@Error
			If	@SQLError <> 0 Goto Abort

			/*	Calculate the total Amount and Quantity adjustment for the current batch.	*/
			Select	@AdjAmount = Round(Sum(Adj.AdjAmt), @BaseDecPl),
				@AdjQuantity = Round(Sum(Adj.AdjQty), @DecPlQty)
			From	#Adj10397_1 Adj
			Where 	Adj.LineCount > @MinRec
				And Adj.LineCount <= @MaxRec

			/*	Preserve SQL Error Number and Determine if an error occurred.	*/
			Set	@SQLError = @@Error
			If	@SQLError <> 0 Goto Abort

			/*	Update the batch record with the total Amount and Quantity to be adjusted.	*/

			--Change from void batch to regular batch
			Update	Batch
				Set CrTot =  @AdjAmount,
					CuryCrTot = @AdjAmount,
					CuryDrTot = @AdjAmount,
					DrTot = @AdjQuantity,
					CtrlTot = @AdjAmount,
					CuryCtrlTot = @AdjAmount,
					Status = 'B',
					Descr = @p_Descr,
					S4Future11 = space(1)
				Where	BatNbr = @BatNbr_Str
					And Module = 'IN'

			/*	Preserve SQL Error Number and Determine if an error occurred.	*/
			Set	@SQLError = @@Error
			If	@SQLError <> 0 Goto Abort

			/*	Create the LotSerT records for the current batch.	*/
			Insert	LotSerT
				(
				BatNbr, CpnyID, Crtd_Prog, Crtd_User, ExpDate,
				INTranLineID, INTranLineRef, InvtID, InvtMult, LineNbr,
				LotSerNbr, LotSerRef, LUpd_DateTime, LUpd_Prog, LUpd_User,
				Qty, RefNbr, SiteID, TranDate, TranSrc,
				TranType, UnitCost, WhseLoc
				)
			Select	BatNbr = @BatNbr_Str, CpnyID = @p_CpnyID, Crtd_Prog = '10397', Crtd_User = @p_UserName,
				ExpDate =	Case When Inventory.LotSerIssMthd = 'E'
								Then DateAdd(Day, Inventory.ShelfLife, GetDate())
							Else ''
						End,
				INTranLineID = Adj.LineCount,
				INTranLineRef = Right(Replicate('0', 5) + Cast(Adj.LineCount As VarChar(10)), 5),
				Adj.InvtID, InvtMult = 1, LineNbr = Adj.LineCount,
				Adj.LotSerNbr, LotSerRef = '00001', LUpd_DateTime = GetDate(), LUpd_Prog = '10397',
				LUpd_User = @p_UserName, Qty = Adj.AdjQty, RefNbr = @p_PIID, SiteID = @p_SiteID,
				TranDate = @p_DateFreez, TranSrc = 'IN', TranType = 'PI', UnitCost = Adj.AvgCost, Adj.WhseLoc
			From #Adj10397_1 Adj Join Inventory
				On Adj.InvtID = Inventory.InvtID
			Where	Adj.LotOrSer In ('L', 'S')
				And Adj.LineCount > @MinRec
				And Adj.LineCount <= @MaxRec

			/*	Preserve SQL Error Number and Determine if an error occurred.	*/
			Set	@SQLError = @@Error
			If	@SQLError <> 0 Goto Abort

			update	M
			set	QtyAllocIN = round(M.QtyAllocIN - D.QtyAllocIN, @DecPlQty),
				QtyAvail = round(M.QtyAvail + D.QtyAllocIN, @DecPlQty)
			from	LotSerMst M
				inner join Inventory
					on	Inventory.InvtID = M.InvtID 
						and Inventory.LotSerTrack in ('LI', 'SI') 
						and Inventory.SerAssign = 'R'
				inner join
					(select LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr,
						QtyAllocIN = round(sum(LotSerT.Qty), @DecPlQty)
					from	LotSerT, LocTable
					where	LotSerT.BatNbr = @BatNbr_Str
						and	LotSerT.Qty < 0
						and	LotSerT.SiteID = LocTable.SiteID
						and	LotSerT.WhseLoc = LocTable.WhseLoc
						and	LocTable.InclQtyAvail = 1
					group by LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr) D
				on	M.InvtID = D.InvtID
					and	M.SiteID = D.SiteID
					and	M.WhseLoc = D.WhseLoc
					and	M.LotSerNbr = D.LotSerNbr

			/*	Preserve SQL Error Number and Determine if an error occurred.	*/
			Set	@SQLError = @@Error
			If	@SQLError <> 0 Goto Abort

			Insert	Into #BatchList (BatNbr) Values (@BatNbr_Str)

			/*	Increament the Batch Number Counter and update adjustment positional variables.	*/
			Select	@BatchNumber = @BatchNumber + 1,
				@MinRec = @MinRec + @p_AdjPerBatch,
				@MaxRec = @MaxRec +  @p_AdjPerBatch,
				@p_FirstBatNbr = @p_FirstBatNbr + 1
		End

		/*	Execute the Physical Reconcile Close procedure.	*/
		Exec PI_ReconcileClose @p_PIID, @p_SiteID, @p_DateFreez, @p_PITagType
		
		Commit Tran

	Select	*
		From #BatchList

Goto FINISH

ABORT:
	RollBack Transaction
FINISH:


