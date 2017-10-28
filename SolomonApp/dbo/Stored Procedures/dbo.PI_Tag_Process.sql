 /*
 	@PI_ID 	 = PIID
	@PI_Date = Date
	@PI_SiteID = SiteID
	@FirstTagNo = FirstTagNumber
	@FirstLineNo = FirstLineNumber
	@PIQty_Equal_BookQty = Check for physical equal to book qty.
	@Tag_Item_Location = Check for Item Or Location
	@Sort_Order = Sort Order
	@Zero_Qty = Check for Zero qty
	@BlankTags = Number of Blank Tags
*/
Create Procedure PI_Tag_Process
	@PI_ID VarChar(10),
	@PI_Date SmallDateTime,
	@PI_SiteID VarChar(10),
	@FirstTagNo Int,
	@FirstLineNo Int,
	@PIQty_Equal_BookQty Int,
	@Tag_Item_Location VarChar(1),
	@Sort_Order VarChar(1),
	@Zero_Qty Int,
	@BlankTags SmallInt,
	@ExclINItems smallint
As

	Declare @BlankTag_Counter	SmallInt,
		@MatlOvhCalc		Char(1)

	Select	@MatlOvhCalc = MatlOvhCalc
		From	INSetup (NoLock)

	Declare	@CpnyID		VarChar(10)
		Select	@CpnyID = CpnyID
		From	Site (NoLock)
		Where	SiteID = @PI_SiteID

	Declare	@BaseDecPl 	SmallInt,
		@BMIDecPl  	SmallInt,
		@DecPlPrcCst  	SmallInt,
		@DecPlQty 	SmallInt

	Select	@BaseDecPl = BaseDecPl,
		@BMIDecPl = BMIDecPl,
		@DecPlPrcCst = DecPlPrcCst,
		@DecPlQty = DecPlQty
		From	vp_DecPl (NoLock)

Begin Transaction

-- Generate Tag Detail Records
--
Create Table #PIDetTemp1 (
	BookQty Float, UnitCost Float, InvtID VarChar(30), Descr VarChar(60), StkUnit VarChar(10), ValMthd VarChar(1),
	WhseLoc VarChar(10), LotSerTrack VarChar(2), SerAssign VarChar(1), LinkSpecID SmallInt, LotSerNbr VarChar(25), ClassID VarChar(6),
	InvtUser1 VarChar(30), InvtUser2 VarChar(30), ItemSiteUser1 VarChar(30), ItemSiteUser2 VarChar(30)
)-- Case: Not Lot/Serial; Generate tags per Location
--
Insert	#PIDetTemp1
Select	BookQty = Round(IsNull((l.QtyOnHand - l.QtyShipNotInv), 0), @DecPlQty),
	UnitCost =	Case	When 	i.ValMthd = 'A' /* Average Cost */
					Then s.AvgCost
				When 	i.ValMthd = 'T' /* Standard Cost */
					Then	Case @MatlOvhCalc
							When 'U' /* When Used */
								Then s.DirStdCst
							When 'R' /* When Received */
								Then s.StdCost
							Else s.DirStdCst
						End
				When 	i.ValMthd In ('L', 'F', 'S') /* LIFO, FIFO, Specific Cost ID*/
					Then s.LastCost
				Else	0 /* User Specified */
			End,
	i.InvtID, i.Descr, i.StkUnit, i.ValMthd,
	WhseLoc =	Case	When l.WhseLoc Is Not Null
					Then l.WhseLoc
				When Round(IsNull((l.QtyOnHand - l.QtyShipNotInv), 0), @DecPlQty) >= 0
					Then Bins.DfltPickBin
				Else	Bins.DfltPutAwayBin
			End,
	CASE i.SerAssign WHEN 'U' THEN 'NN' ELSE i.LotSerTrack END, i.SerAssign,
	i.LinkSpecID,
	LotSerNbr = Space(1), 	-- LotSerNbr (N/A here)
	i.ClassID,
	InvtUser1 = i.User1,
	InvtUser2 = i.User2,
	ItemSiteUser1 = s.User1,
	ItemSiteUser2 = s.User2
From	Inventory i Join ItemSite s
	On i.InvtID = s.InvtID
	Join vp_DfltSiteBins Bins (NoLock)
	On i.InvtID = Bins.InvtID
	And Bins.CpnyID = @CpnyID  /*  The CpnyID was found above by looking up the PI Site in the Site Table.  */
	Left Join Location l
	On (s.InvtID = l.InvtID And s.SiteID = l.SiteID)
Where	i.StkItem = 1
	And (i.TranStatusCode <> 'IN' or @ExclINItems = 0)
	--And i.LotSerTrack = 'NN'
	And (i.LotSerTrack = 'NN' OR (I.LotSerTrack In ('LI', 'SI') And I.SerAssign = 'U'))
	And s.SiteID = @PI_SiteID
	And ((@Tag_Item_Location = 'I' And s.Selected = 1 And s.CountStatus = 'P')
	Or (@Tag_Item_Location = 'L' And l.Selected = 1 And l.CountStatus = 'P'))
Order By s.InvtID, s.SiteID, l.WhseLoc

If @@Error <> 0 Goto ABORT

-- Case: Lot/Serial; Generate tags per Lot/Ser Number
--
Insert	#PIDetTemp1
Select	BookQty = Round(IsNull((m.QtyOnHand - m.QtyShipNotInv), 0), @DecPlQty),
	UnitCost =	Case	When 	i.ValMthd = 'A' /* Average Cost */
					Then s.AvgCost
				When 	i.ValMthd = 'T' /* Standard Cost */
					Then	Case @MatlOvhCalc
							When 'U' /* When Used */
								Then s.DirStdCst
							When 'R' /* When Received */
								Then s.StdCost
							Else s.DirStdCst
						End
				When 	i.ValMthd In ('L', 'F', 'S') /* LIFO, FIFO, Specific Cost ID*/
					Then s.LastCost
				Else	0 /* User Specified */
			End,
	i.InvtID, i.Descr, i.StkUnit, i.ValMthd,
	WhseLoc =	Case	When l.WhseLoc Is Not Null
					Then l.WhseLoc
				When Round(IsNull((m.QtyOnHand - m.QtyShipNotInv), 0), @DecPlQty) >= 0
					Then Bins.DfltPickBin
				Else	Bins.DfltPutAwayBin
			End,
	i.LotSerTrack, i.SerAssign,
	i.LinkSpecID,
	LotSerNbr = IsNull(m.LotSerNbr, Space(1)),
	i.ClassID,
	InvtUser1 = i.User1,
	InvtUser2 = i.User2,
	ItemSiteUser1 = s.User1,
	ItemSiteUser2 = s.User2
From	Inventory i Join ItemSite s
	On i.InvtID = s.InvtID
	Join vp_DfltSiteBins Bins (NoLock)
	On i.InvtID = Bins.InvtID
	And Bins.CpnyID = @CpnyID  /*  The CpnyID was found above by looking up the PI Site in the Site Table.  */
	Left Join Location l
	On s.InvtID = l.InvtID
	And s.SiteID = l.SiteID
	Left Join LotSerMst m
	On l.InvtID = m.InvtID
	And l.SiteID = m.SiteID
	And l.WhseLoc = m.WhseLoc
Where	i.StkItem = 1
	And (i.TranStatusCode <> 'IN' or @ExclINItems = 0)
	And i.LotSerTrack In ('LI', 'SI')
	And i.SerAssign = 'R'
	And s.SiteID = @PI_SiteID
	--And m.QtyOnHand - m.QtyShipNotInv <> 0
	And ((@Zero_Qty = 0 And m.QtyOnHand - m.QtyShipNotInv <> 0) Or (@Zero_Qty = 1))
	And ((@Tag_Item_Location = 'I' And s.Selected = 1 And s.CountStatus = 'P')
	Or (@Tag_Item_Location = 'L' And l.Selected = 1 And l.CountStatus = 'P'))
Order By s.InvtID, s.SiteID, l.WhseLoc, m.LotSerNbr

If @@Error <> 0 Goto ABORT

-- Generate sorted tag list
--
Create Table #PIDetTemp2 (
	BookQty Float, UnitCost Float, InvtID VarChar(30), Descr VarChar(60), StkUnit VarChar(10), ValMthd VarChar(1),
	WhseLoc VarChar(10), LotSerTrack VarChar(2), LinkSpecID SmallInt, LotSerNbr VarChar(25), TagCounter Int Identity(1, 1)
)Insert	#PIDetTemp2 (BookQty, UnitCost, InvtID, Descr, StkUnit, ValMthd, WhseLoc, LotSerTrack, LinkSpecID, LotSerNbr)
Select	t.BookQty, t.UnitCost, t.InvtID, t.Descr, t.StkUnit, t.ValMthd, t.WhseLoc, t.LotSerTrack, LinkSpecID, t.LotSerNbr
From	#PIDetTemp1 t
Where	((@Zero_Qty = 0 And t.BookQty <> 0) Or (@Zero_Qty = 1))
Order By Case @Sort_Order
		When 'L' Then t.WhseLoc
		When 'I' Then t.InvtID
		When 'D' Then t.Descr
		When 'P' Then t.ClassID + t.InvtID
		When 'U' Then t.InvtUser1
		When 'V' Then t.InvtUser2
		When 'W' Then t.ItemSiteUser1
		When 'X' Then t.ItemsiteUser2
		End

If @@Error <> 0 Goto ABORT

-- Generate blank tags requested
--
If @BlankTags > 0 And (((Select Count(*) From #PIDetTemp2) > 0) Or ((Select Count(*) From PIHeader Where PIID = @PI_ID) > 0))
Begin
	Select @BlankTag_Counter = 0
	While @BlankTag_Counter < @BlankTags
	Begin
		Insert #PIDetTemp2 (BookQty, UnitCost, InvtID, Descr, StkUnit, ValMthd, WhseLoc, LotSerTrack, LinkSpecID, LotSerNbr)
		Values (0, 0, Space(1), Space(1), Space(1), Space(1), Space(1), Space(1), 0, Space(1))

		If @@Error <> 0 Goto ABORT

		Select @BlankTag_Counter = @BlankTag_Counter + 1
	End
End

If @@Error <> 0 Goto ABORT

-- Generate real tag list from sorted list
--
Insert PIDetail	(BookQty, Crtd_DateTime, Crtd_Prog, Crtd_User, DateFreeze, ExtCostVariance, InvtID, ItemDesc,
		LineID, LineNbr, LineRef, LotOrSer, LotSerNbr, LUpd_DateTime, LUpd_Prog, LUpd_User, MsgNbr,
		NoteID, Number, PerClosed, PhysQty, PIID, PIType, SiteID, SpecificCostID, Status, TranDate,
		Unit, UnitCost, ValMthd, WhseLoc, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, User1,
		User2, User3, User4, User5, User6, User7, User8)
Select	t.BookQty,
	GetDate(),
	'10395',
	User_Name(),
	@PI_Date,
	ExtCostVariance = Case						-- ExtCostVariance
		When @PIQty_Equal_BookQty = 1 Then 0
		When @PIQty_Equal_BookQty = 0 Then Round((0 - t.BookQty) * t.UnitCost, @BaseDecPl)
		End,
	t.InvtID,
	t.Descr,
	t.TagCounter,						-- LineID
	(@FirstLineNo + t.TagCounter - 32769),			-- LineNbr
	Str(TagCounter, 5, 0),					-- LineRef
	SubString(t.LotSerTrack, 1, 1),				-- LotOrSer
	t.LotSerNbr,
	GetDate(),
	'10395',
	User_Name(),
	Space(1),						-- MsgNbr
	0,							-- NoteID
	((@FirstTagNo - 1) + t.TagCounter),			-- Number
	Space(1),						-- PerClosed
	PhyQty = Case
		When @PIQty_Equal_BookQty = 1 Then t.BookQty
		When @PIQty_Equal_BookQty = 0 Then 0
		End,
	@PI_ID,
	PIType = Case						-- Line Type:
		When Len(t.InvtID) > 0 Then 'N'			-- 'N' - Normal; 'U' - User Entered
		When Len(t.InvtID) = 0 Then 'B'			-- 'B' - Blank; 'Z' - Zero
		End,
	@PI_SiteID,
	Case LinkSpecID when 0 Then Space(1) Else LotSerNbr End,-- SpecificCostID, not using this anymore
	Status = Case						-- Line Status:
		When Len(t.InvtID) > 0 Then 'N'			-- 'N' - Not Entered; 'E' - Entered
		When Len(t.InvtID) = 0 Then 'X'			-- 'X' - Voided
		End,
	GetDate(),
	t.StkUnit,
	t.UnitCost,
	t.ValMthd,
	t.WhseLoc,
	Space(1), Space(1), 0, 0, 0, 0, GetDate(), GetDate(), 0, 0, Space(1), Space(1),		-- S4Future*
	Space(1), Space(1), 0, 0, Space(1), Space(1), GetDate(), GetDate()			-- User*
From	#PIDetTemp2 t
Where	TagCounter <= 65000		-- protect SAFGrid

If @@Error <> 0 Goto ABORT

Commit Transaction
Goto FINISH

ABORT:
RollBack Transaction

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PI_Tag_Process] TO [MSDSL]
    AS [dbo];

