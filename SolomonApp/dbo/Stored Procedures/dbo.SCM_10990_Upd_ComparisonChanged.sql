 Create	Procedure SCM_10990_Upd_ComparisonChanged
	@BatNbr			varchar (10),
	@CpnyID			varchar (10),
	@InvtID			varchar (30),
	@LayerType		varchar (1),
	@LineRef		varchar (5),
	@RcptDate		smalldatetime,
	@RcptNbr		varchar (15),
	@RefNbr			varchar (15),
	@SiteID			varchar (10),
	@SpecificCostID		varchar (25),
	@WhseLoc		varchar (10)
As

/* This procedure will clear the Changed flag in the Inventory Comparison tables
   IN10990_Location, IN10990_ItemCost, IN10990_ItemSite for INTran records without
    corresponding LotSerT transactions						*/

/* Location */
Update IN10990_Location
	Set Changed = 0
	Where 	InvtID = @InvtID and
		SiteID = @SiteID and
		WhseLoc = @WhseLoc

/* LotSerMst - Since we don't have the LotSerNbr, need to
   reset the flag for all the InvtID/SiteID/WhseLoc combinations*/
Update IN10990_LotSerMst
	Set Changed = 0
	Where	IN10990_LotSerMst.InvtID = @InvtID
		And IN10990_LotSerMst.SiteID = @SiteID
		And IN10990_LotSerMst.WhseLoc = @WhseLoc

/* ItemCost */
Update IN10990_ItemCost
	Set Changed = 0
	Where 	InvtID = @InvtID and
		SiteID = @SiteID and
		LayerType = @LayerType and
		SpecificCostID = @SpecificCostID and
		RcptNbr = @RcptNbr and
		RcptDate = @RcptDate

/* ItemSite */
Update IN10990_ItemSite
	Set Changed = 0
	Where 	InvtID = @InvtID and
		SiteID = @SiteID


