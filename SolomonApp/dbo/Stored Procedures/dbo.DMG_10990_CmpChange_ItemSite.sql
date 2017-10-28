 Create	Proc DMG_10990_CmpChange_ItemSite
	@InvtID	VarChar(30),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As

/*
	This procedure will return a record set containing the differences calculated between
	ItemSite and it's comparison table.  Each variance will be returned as a row in the result set.
*/
	Set	NoCount	On

	Declare	@BMIEnabled	SmallInt,
		@BMITotalVar	Decimal(10, 5),
		@TotalVar	Decimal(10, 5),
		@QtyVar		Decimal(10, 5),
		@UnitVar	Decimal(10, 5)

/*	Fill the appropriate decimal precision variables.	*/

	Select	@BMITotalVar = Power(Cast(10 As Decimal(10,5)), - @BMIDecPl),
		@TotalVar = Power(Cast(10 As Decimal(10,5)), - @BaseDecPl),
		@QtyVar = Power(Cast(10 As Decimal(10,5)), - @DecPlQty),
		@UnitVar  = Power(Cast(10 As Decimal(10,5)), - @DecPlPrcCst)

/*	Fill variable used to determine if BMI fields get values or are automatically defaulted to zero.	*/
	Select	@BMIEnabled = BMIEnabled
		From	INSetup

/*	Return variances in Average Cost.	*/
	Select	ItemSite.InvtID, ItemSite.SiteID,
		Field = Cast('AvgCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemSite.AvgCost, @DecPlPrcCst),
		CmpValue = Round(IN10990_ItemSite.AvgCost, @DecPlPrcCst)
		From	ItemSite Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
		Where	IN10990_ItemSite.InvtID = @InvtID
			And IN10990_ItemSite.Changed = 1
			And IN10990_ItemSite.QtyOnHand <> 0
			And Abs(Round(Round(ItemSite.AvgCost, @DecPlPrcCst) - Round(IN10990_ItemSite.AvgCost, @DecPlPrcCst), @DecPlPrcCst)) > @UnitVar
	Union
/*	Return variances in Bi-Monetary Average Cost when BMI is enabled.	*/
	Select	ItemSite.InvtID, ItemSite.SiteID,
		Field = Cast('BMIAvgCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemSite.BMIAvgCost, @DecPlPrcCst),
		CmpValue = Round(IN10990_ItemSite.BMIAvgCost, @DecPlPrcCst)
		From	ItemSite Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
		Where	IN10990_ItemSite.InvtID = @InvtID
			And IN10990_ItemSite.Changed = 1
			And IN10990_ItemSite.QtyOnHand <> 0
			And Abs(Round(Round(ItemSite.BMIAvgCost, @DecPlPrcCst) - Round(IN10990_ItemSite.BMIAvgCost, @DecPlPrcCst), @DecPlPrcCst)) > @UnitVar
			And @BMIEnabled = 1
	Union
/*	Return variances in Bi-Monetary Total Cost when BMI is enabled.	*/
	Select	ItemSite.InvtID, ItemSite.SiteID,
		Field = Cast('BMITotCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemSite.BMITotCost, @BMIDecPl),
		CmpValue = Round(IN10990_ItemSite.BMITotCost, @BMIDecPl)
		From	ItemSite Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
		Where	IN10990_ItemSite.InvtID = @InvtID
			And IN10990_ItemSite.Changed = 1
			And Abs(Round(Round(ItemSite.BMITotCost, @BMIDecPl) - Round(IN10990_ItemSite.BMITotCost, @BMIDecPl), @BMIDecPl)) > @BMITotalVar
			And @BMIEnabled = 1
	Union
/*	Return variances in Quantity On Hand.	*/
	Select	ItemSite.InvtID, ItemSite.SiteID,
		Field = Cast('QtyOnHand' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemSite.QtyOnHand, @DecPlQty),
		CmpValue = Round(IN10990_ItemSite.QtyOnHand, @DecPlQty)
		From	ItemSite Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
		Where	IN10990_ItemSite.InvtID = @InvtID
			And IN10990_ItemSite.Changed = 1
			And Abs(Round(Round(ItemSite.QtyOnHand, @DecPlQty) - Round(IN10990_ItemSite.QtyOnHand, @DecPlQty), @DecPlQty)) > @QtyVar
	Union
/*	Return variances in Total Cost.	*/
	Select	ItemSite.InvtID, ItemSite.SiteID,
		Field = Cast('TotCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemSite.TotCost, @BaseDecPl),
		CmpValue = Round(IN10990_ItemSite.TotCost, @BaseDecPl)
		From	ItemSite Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
		Where	IN10990_ItemSite.InvtID = @InvtID
			And IN10990_ItemSite.Changed = 1
			And Abs(Round(Round(ItemSite.TotCost, @BaseDecPl) - Round(IN10990_ItemSite.TotCost, @BaseDecPl), @BaseDecPl)) > @TotalVar


