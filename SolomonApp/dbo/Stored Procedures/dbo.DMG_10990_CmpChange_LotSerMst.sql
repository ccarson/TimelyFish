 Create	Proc DMG_10990_CmpChange_LotSerMst
	@InvtID	VarChar(30),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As

/*
	This procedure will return a record set containing the differences calculated between
	LotSerMst and it's comparison table.  Each variance will be returned as a row in the result set.
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

/*	Return variances in Quantity On Hand.	*/
	Select	LotSerMst.InvtID, LotSerMst.SiteID, LotSerMst.WhseLoc, LotSerMst.LotSerNbr,
		Field = Cast('QtyOnHand' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(LotSerMst.QtyOnHand, @DecPlQty),
		CmpValue = Round(IN10990_LotSerMst.QtyOnHand, @DecPlQty)
		From	LotSerMst Join IN10990_LotSerMst
			On LotSerMst.InvtID = IN10990_LotSerMst.InvtID
			And LotSerMst.SiteID = IN10990_LotSerMst.SiteID
			And LotSerMst.WhseLoc = IN10990_LotSerMst.WhseLoc
			And LotSerMst.LotSerNbr = IN10990_LotSerMst.LotSerNbr
		Where	IN10990_LotSerMst.InvtID = @InvtID
			And IN10990_LotSerMst.Changed = 1
			And Abs(Round(Round(LotSerMst.QtyOnHand, @DecPlQty) - Round(IN10990_LotSerMst.QtyOnHand, @DecPlQty), @DecPlQty)) > @QtyVar


