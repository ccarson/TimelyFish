 Create	Proc DMG_10990_CmpChange_ItemCost
	@InvtID	VarChar(30),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As

/*
	This procedure will return a record set containing the differences calculated between
	ItemCost and it's comparison table.  Each variance will be returned as a row in the result set.
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

/*	Return variances in Bi-Monetary Total Cost when BMI is enabled.	*/
	Select	ItemCost.InvtID, ItemCost.SiteID, ItemCost.LayerType, ItemCost.SpecificCostID, ItemCost.RcptDate,
		ItemCost.RcptNbr,
		Field = Cast('BMITotCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemCost.BMITotCost, @BMIDecPl),
		CmpValue = Round(IN10990_ItemCost.BMITotCost, @BMIDecPl)
		From	ItemCost Join IN10990_ItemCost
			On ItemCost.InvtID = IN10990_ItemCost.InvtID
			And ItemCost.SiteID = IN10990_ItemCost.SiteID
			And ItemCost.LayerType = IN10990_ItemCost.LayerType
			And ItemCost.SpecificCostID = IN10990_ItemCost.SpecificCostID
			And ItemCost.RcptDate = IN10990_ItemCost.RcptDate
			And ItemCost.RcptNbr = IN10990_ItemCost.RcptNbr
		Where	IN10990_ItemCost.InvtID = @InvtID
			And IN10990_ItemCost.Changed = 1
			And Abs(Round(Round(ItemCost.BMITotCost, @BMIDecPl) - Round(IN10990_ItemCost.BMITotCost, @BMIDecPl), @BMIDecPl)) > @BMITotalVar
			And @BMIEnabled = 1
	Union
/*	Return variances in Quantity.	*/
	Select	ItemCost.InvtID, ItemCost.SiteID, ItemCost.LayerType, ItemCost.SpecificCostID, ItemCost.RcptDate,
		ItemCost.RcptNbr,
		Field = Cast('Qty' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemCost.Qty, @DecPlQty),
		CmpValue = Round(IN10990_ItemCost.Qty, @DecPlQty)
		From	ItemCost Join IN10990_ItemCost
			On ItemCost.InvtID = IN10990_ItemCost.InvtID
			And ItemCost.SiteID = IN10990_ItemCost.SiteID
			And ItemCost.LayerType = IN10990_ItemCost.LayerType
			And ItemCost.SpecificCostID = IN10990_ItemCost.SpecificCostID
			And ItemCost.RcptDate = IN10990_ItemCost.RcptDate
			And ItemCost.RcptNbr = IN10990_ItemCost.RcptNbr
		Where	IN10990_ItemCost.InvtID = @InvtID
			And IN10990_ItemCost.Changed = 1
			And Abs(Round(Round(ItemCost.Qty, @DecPlQty) - Round(IN10990_ItemCost.Qty, @DecPlQty), @DecPlQty)) > @QtyVar
	Union
/*	Return variances in Total Cost.	*/
	Select	ItemCost.InvtID, ItemCost.SiteID, ItemCost.LayerType, ItemCost.SpecificCostID, ItemCost.RcptDate,
		ItemCost.RcptNbr,
		Field = Cast('TotCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemCost.TotCost, @BaseDecPl),
		CmpValue = Round(IN10990_ItemCost.TotCost, @BaseDecPl)
		From	ItemCost Join IN10990_ItemCost
			On ItemCost.InvtID = IN10990_ItemCost.InvtID
			And ItemCost.SiteID = IN10990_ItemCost.SiteID
			And ItemCost.LayerType = IN10990_ItemCost.LayerType
			And ItemCost.SpecificCostID = IN10990_ItemCost.SpecificCostID
			And ItemCost.RcptDate = IN10990_ItemCost.RcptDate
			And ItemCost.RcptNbr = IN10990_ItemCost.RcptNbr
		Where	IN10990_ItemCost.InvtID = @InvtID
			And IN10990_ItemCost.Changed = 1
			And Abs(Round(Round(ItemCost.TotCost, @BaseDecPl) - Round(IN10990_ItemCost.TotCost, @BaseDecPl), @BaseDecPl)) > @TotalVar
	Union
/*	Return variances in Unit Cost.	*/
	Select	ItemCost.InvtID, ItemCost.SiteID, ItemCost.LayerType, ItemCost.SpecificCostID, ItemCost.RcptDate,
		ItemCost.RcptNbr,
		Field = Cast('UnitCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(ItemCost.UnitCost, @DecPlPrcCst),
		CmpValue = Round(IN10990_ItemCost.UnitCost, @DecPlPrcCst)
		From	ItemCost Join IN10990_ItemCost
			On ItemCost.InvtID = IN10990_ItemCost.InvtID
			And ItemCost.SiteID = IN10990_ItemCost.SiteID
			And ItemCost.LayerType = IN10990_ItemCost.LayerType
			And ItemCost.SpecificCostID = IN10990_ItemCost.SpecificCostID
			And ItemCost.RcptDate = IN10990_ItemCost.RcptDate
			And ItemCost.RcptNbr = IN10990_ItemCost.RcptNbr
		Where	IN10990_ItemCost.InvtID = @InvtID
			And IN10990_ItemCost.Changed = 1
			And Abs(Round(Round(ItemCost.UnitCost, @DecPlPrcCst) - Round(IN10990_ItemCost.UnitCost, @DecPlPrcCst), @DecPlPrcCst)) > @UnitVar
	Union
/*	Return variances in Bi-Monetary Total Cost when BMI is enabled.	*/
	Select	IN10990_ItemCost.InvtID, IN10990_ItemCost.SiteID, IN10990_ItemCost.LayerType,
		IN10990_ItemCost.SpecificCostID, IN10990_ItemCost.RcptDate, IN10990_ItemCost.RcptNbr,
		Field = Cast('BMITotCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = 0,
		CmpValue = Round(IN10990_ItemCost.BMITotCost, @BMIDecPl)
		From	IN10990_ItemCost Left Join ItemCost
			On IN10990_ItemCost.InvtID = ItemCost.InvtID
			And IN10990_ItemCost.SiteID = ItemCost.SiteID
			And IN10990_ItemCost.LayerType = ItemCost.LayerType
			And IN10990_ItemCost.SpecificCostID = ItemCost.SpecificCostID
			And IN10990_ItemCost.RcptDate = ItemCost.RcptDate
			And IN10990_ItemCost.RcptNbr = ItemCost.RcptNbr
		Where	ItemCost.InvtID Is Null
			And IN10990_ItemCost.InvtID = @InvtID
			And IN10990_ItemCost.Changed = 1
			And @BMIEnabled = 1
			And Round(IN10990_ItemCost.Qty, @DecPlQty) <> 0
	Union
/*	Return variances in Quantity.	*/
	Select	IN10990_ItemCost.InvtID, IN10990_ItemCost.SiteID, IN10990_ItemCost.LayerType,
		IN10990_ItemCost.SpecificCostID, IN10990_ItemCost.RcptDate, IN10990_ItemCost.RcptNbr,
		Field = Cast('Qty' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = 0,
		CmpValue = Round(IN10990_ItemCost.Qty, @DecPlQty)
		From	IN10990_ItemCost Left Join ItemCost
			On IN10990_ItemCost.InvtID = ItemCost.InvtID
			And IN10990_ItemCost.SiteID = ItemCost.SiteID
			And IN10990_ItemCost.LayerType = ItemCost.LayerType
			And IN10990_ItemCost.SpecificCostID = ItemCost.SpecificCostID
			And IN10990_ItemCost.RcptDate = ItemCost.RcptDate
			And IN10990_ItemCost.RcptNbr = ItemCost.RcptNbr
		Where	ItemCost.InvtID Is Null
			And IN10990_ItemCost.InvtID = @InvtID
			And IN10990_ItemCost.Changed = 1
			And Round(IN10990_ItemCost.Qty, @DecPlQty) <> 0
	Union
/*	Return variances in Total Cost.	*/
	Select	IN10990_ItemCost.InvtID, IN10990_ItemCost.SiteID, IN10990_ItemCost.LayerType,
		IN10990_ItemCost.SpecificCostID, IN10990_ItemCost.RcptDate, IN10990_ItemCost.RcptNbr,
		Field = Cast('TotCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = 0,
		CmpValue = Round(IN10990_ItemCost.TotCost, @BaseDecPl)
		From	IN10990_ItemCost Left Join ItemCost
			On IN10990_ItemCost.InvtID = ItemCost.InvtID
			And IN10990_ItemCost.SiteID = ItemCost.SiteID
			And IN10990_ItemCost.LayerType = ItemCost.LayerType
			And IN10990_ItemCost.SpecificCostID = ItemCost.SpecificCostID
			And IN10990_ItemCost.RcptDate = ItemCost.RcptDate
			And IN10990_ItemCost.RcptNbr = ItemCost.RcptNbr
		Where	ItemCost.InvtID Is Null
			And IN10990_ItemCost.InvtID = @InvtID
			And IN10990_ItemCost.Changed = 1
			And Round(IN10990_ItemCost.Qty, @DecPlQty) <> 0
	Union
/*	Return variances in Unit Cost.	*/
	Select	IN10990_ItemCost.InvtID, IN10990_ItemCost.SiteID, IN10990_ItemCost.LayerType,
		IN10990_ItemCost.SpecificCostID, IN10990_ItemCost.RcptDate, IN10990_ItemCost.RcptNbr,
		Field = Cast('UnitCost' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = 0,
		CmpValue = Round(IN10990_ItemCost.UnitCost, @DecPlPrcCst)
		From	IN10990_ItemCost Left Join ItemCost
			On IN10990_ItemCost.InvtID = ItemCost.InvtID
			And IN10990_ItemCost.SiteID = ItemCost.SiteID
			And IN10990_ItemCost.LayerType = ItemCost.LayerType
			And IN10990_ItemCost.SpecificCostID = ItemCost.SpecificCostID
			And IN10990_ItemCost.RcptDate = ItemCost.RcptDate
			And IN10990_ItemCost.RcptNbr = ItemCost.RcptNbr
		Where	ItemCost.InvtID Is Null
			And IN10990_ItemCost.InvtID = @InvtID
			And IN10990_ItemCost.Changed = 1
			And Round(IN10990_ItemCost.Qty, @DecPlQty) <> 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_CmpChange_ItemCost] TO [MSDSL]
    AS [dbo];

