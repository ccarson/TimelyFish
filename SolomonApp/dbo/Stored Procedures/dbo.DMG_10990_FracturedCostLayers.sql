 CREATE PROCEDURE DMG_10990_FracturedCostLayers @InvtID VarChar (30) As
/*
	This procedure will return a record set containing a list of items
	with fractured cost layers (the existence of either negavitve cost
	layers with positive quantity on hand or positive cost layers with
	negative quantity on hand).  Each occurance of invalid data will be
	returned as a row in the result set.
*/
Set	NoCount On

Declare @BaseDecPl     	Int,
	@BMIDecPl      	Int,
	@DecPlPrcCst  	Int,
	@DecPlQty       Int

Select	@BaseDecPl = BaseDecPl,
	@BMIDecPl = BMIDecPl,
	@DecPlPrcCst = DecPlPrcCst,
	@DecPlQty = DecPlQty
	From vp_DecPl (NoLock)

Select	DISTINCT MsgNbr = Cast(16363 As SmallInt), Parm0 = Cast(ItemCost.InvtID As VarChar(30)),
		Parm1 = Cast(ItemCost.SiteID As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
	From    ItemCost (NoLock) Inner Join ItemSite (NoLock)
		On ItemCost.InvtID = @InvtID
		And ItemCost.InvtID = ItemSite.InvtID
		And ItemCost.SiteID = ItemSite.SiteID
	Where   (Round(ItemCost.Qty, @DecPlQty) < 0
		And Round(ItemSite.QtyOnHand, @DecPlQty) > 0)
		Or (Round(ItemCost.Qty, @DecPlQty) > 0
		And Round(ItemSite.QtyOnHand, @DecPlQty) < 0)


