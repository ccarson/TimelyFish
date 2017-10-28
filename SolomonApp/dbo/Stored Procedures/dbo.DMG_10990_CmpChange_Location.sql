 Create	Proc DMG_10990_CmpChange_Location
	@InvtID	VarChar(30),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As

/*
	This procedure will return a record set containing the differences calculated between
	Location and it's comparison table.  Each variance will be returned as a row in the result set.
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
	Select	Location.InvtID, Location.SiteID, Location.WhseLoc,
		Field = Cast('QtyOnHand' As VarChar(15)),
		MsgNbr = Cast(16301 As SmallInt),
		OrigValue = Round(Location.QtyOnHand, @DecPlQty),
		CmpValue = Round(IN10990_Location.QtyOnHand, @DecPlQty)
		From	Location Join IN10990_Location
			On Location.InvtID = IN10990_Location.InvtID
			And Location.SiteID = IN10990_Location.SiteID
			And Location.WhseLoc = IN10990_Location.WhseLoc
		Where	IN10990_Location.InvtID = @InvtID
			And IN10990_Location.Changed = 1
			And Abs(Round(Round(Location.QtyOnHand, @DecPlQty) - Round(IN10990_Location.QtyOnHand, @DecPlQty), @DecPlQty)) > @QtyVar


