 CREATE PROCEDURE SCM_Plan_QtyAvail
	@ComputerName   VarChar(21),
	@InvtID		VarChar(30),	-- Needed for OM/IN Integrity Check (CPS ON)
	@SiteID		VarChar(10),	-- Needed for OM/IN Integrity Check (CPS ON)
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@QtyAvail	Float,						/* From planning engine */
	@DecPlQty	SmallInt
AS
	SET NOCOUNT ON

	-- Declare And Initialize all necessary variables.
	Declare	@CPSOnOff		SmallInt,
		@InclQtyAlloc		SmallInt,
/*		@InclQtyAllocWO		SmallInt,	Not Currently Used	*/
		@InclQtyCustOrd		SmallInt,
		@InclQtyInTransit	SmallInt,
		@InclQtyOnBO		SmallInt,
		@InclQtyOnPO		SmallInt,
		@InclQtyOnWO		SmallInt,
		@InclWOFirmDemand	SmallInt,
		@InclWOFirmSupply	SmallInt,
		@InclWORlsedDemand	SmallInt,
		@InclWORlsedSupply	SmallInt,
		@OptWOFirmRlsedDemand	char (1)

	SELECT	@CPSOnOff = CPSOnOff,
		@InclQtyAlloc = InclAllocQty,
/*		@InclQtyAllocWO = InclQtyAllocWO,	Not Currently Used	*/
		@InclQtyCustOrd = InclQtyCustOrd,
		@InclQtyInTransit = InclQtyInTransit,
		@InclQtyOnBO = InclQtyOnBO,
		@InclQtyOnPO = InclQtyOnPO,
		@InclQtyOnWO = InclQtyOnWO,
		@InclWOFirmDemand = InclWOFirmDemand,
		@InclWOFirmSupply = InclWOFirmSupply,
		@InclWORlsedDemand = InclWORlsedDemand,
		@InclWORlsedSupply = InclWORlsedSupply
	FROM	INSetup (NOLOCK)

	select	@OptWOFirmRlsedDemand = Left(S4Future11,1)
	from	WOSetup (NOLOCK)

	IF @CPSOnOff = 1
		/* CPS On */
		UPDATE	ItemSite
		SET	QtyAvail = Round(@QtyAvail, @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User

		WHERE 	InvtID = @InvtID
		  AND	SiteID = @SiteID

	ELSE
		/* CPS Off */
		UPDATE	ItemSite
		SET	QtyAvail = Round(QtyOnHand - QtyNotAvail - QtyShipNotInv - QtyAllocBM - QtyAllocIN - QtyAllocPORet - QtyAllocSD - QtyAllocProjIN + PrjINQtyShipNotInv + PrjINQtyAllocIN + PrjINQtyAllocPORet
				+ (	Case	When 	@InclQtyInTransit = 1
						Then QtyInTransit + QtyOnTransferOrders
						Else	0
						End)
				+ (	Case	When 	@InclQtyOnPO = 1
						Then QtyOnPO
						Else 	0
						End)
				+ (	Case	When 	@InclQtyOnWO = 1
						Then QtyOnKitAssyOrders
						Else 	0
						End)
				+ (	Case	When	@InclWOFirmSupply = 1
						Then	QtyWOFirmSupply
						Else	0
						End)
				+ (	Case	When	@InclWORlsedSupply = 1
						Then	QtyWORlsedSupply
						Else	0
						End)
				- (	Case	When	@InclWOFirmDemand = 1
						Then	QtyWOFirmDemand
						Else	0
						End)
				- (	Case	When	@InclWORlsedDemand = 1
						Then	QtyWORlsedDemand
						Else	0
						End)
				- (	Case	When	@InclQtyCustOrd = 1
						Then QtyCustOrd - PrjINQtyCustOrd
						Else 0
						End)
				- (	Case	When 	@InclQtyOnBO = 1 And @InclQtyCustOrd = 0
						Then QtyOnBO
						Else 	0
						End)
				- (	Case	When @InclQtyAlloc = 1 And @InclQtyCustOrd = 0
						Then QtyAlloc - PrjINQtyAlloc
						Else 0
						End) , @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User

		FROM	ItemSite ISite

		JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = ISite.InvtID
		  AND 	INU.SiteID = ISite.SiteID

	update	Location
	set	QtyAvail = round(Location.QtyOnHand
		- Location.QtyAlloc
		- Location.QtyAllocBM
		- Location.QtyAllocIN
		- Location.QtyAllocPORet
		- Location.QtyAllocSD
		- Location.QtyAllocSO
		- Location.QtyShipNotInv
		- Location.QtyAllocProjIN
		+ Location.PrjINQtyAlloc
		+ Location.PrjINQtyShipNotInv
		+ Location.PrjINQtyAllocSO
		+ Location.PrjINQtyAllocIN
		+ Location.PrjINQtyAllocPORet
		- case when @OptWOFirmRlsedDemand in ('F','R') then Location.QtyWORlsedDemand else 0 End
		- case when @OptWOFirmRlsedDemand = 'F' then Location.S4Future03 else 0 end,
		@DecPlQty),
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	from	Location
	JOIN	INUpdateQty_Wrk INU (NOLOCK)
		ON 	INU.InvtID = Location.InvtID
		AND 	INU.SiteID = Location.SiteID
		AND	INU.ComputerName + '' LIKE @ComputerName
	where	exists (select * from LocTable where LocTable.SiteID = Location.SiteID and LocTable.WhseLoc = Location.WhseLoc
	  and	InclQtyAvail = 1)

	update	LotSerMst
	set	QtyAvail = round(LotSerMst.QtyOnHand
		- LotSerMst.QtyAlloc
		- LotSerMst.QtyAllocBM
		- LotSerMst.QtyAllocIN
		- LotSerMst.QtyAllocPORet
		- LotSerMst.QtyAllocSD
		- LotSerMst.QtyAllocSO
		- LotSerMst.QtyShipNotInv
		- LotSerMst.QtyAllocProjIN
		+ LotSerMst.PrjINQtyAlloc
		+ LotSerMst.PrjINQtyAllocSO
		+ LotSerMst.PrjINQtyShipNotInv
		+ LotSerMst.PrjINQtyAllocIN
		+ LotSerMst.PrjINQtyAllocPORet
		- case when @OptWOFirmRlsedDemand in ('F','R') then LotSerMst.QtyWORlsedDemand else 0 End,
		@DecPlQty),
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	from	LotSerMst
	JOIN	INUpdateQty_Wrk INU (NOLOCK)
		ON 	INU.InvtID = LotSerMst.InvtID
		AND 	INU.SiteID = LotSerMst.SiteID
		AND	INU.ComputerName + '' LIKE @ComputerName
	where	exists (select * from LocTable where LocTable.SiteID = LotSerMst.SiteID and LocTable.WhseLoc = LotSerMst.WhseLoc
	  and	InclQtyAvail = 1)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_QtyAvail] TO [MSDSL]
    AS [dbo];

