 CREATE PROC Integrity_QtyRecalc

	@ProgID	CHAR(8),
	@UserID	CHAR(10)
AS
	declare	@BODate		smalldatetime

-- declare @progid char(8), @userid char(10)   select @progid = '1099000', @userid = 'SYSADMIN'

SET NOCOUNT ON

-- Fetch variables from INSetup.
DECLARE @DecPlQty 		FLOAT,
	@InclQtyOnPO 		SMALLINT,
	@InclQtyInTransit 	SMALLINT,
	@InclQtyOnWO 		SMALLINT,
	@InclQtyCustOrd 	SMALLINT,
	@InclQtyOnBO 		SMALLINT,
	@InclQtyAlloc 		SMALLINT

-- Load them up.
	SELECT 	@DecPlQty = DecPlQty,
		@InclQtyOnPO = InclQtyOnPO,
		@InclQtyInTransit = InclQtyInTransit,
		@InclQtyOnWO = InclQtyOnWO,
		@InclQtyCustOrd = InclQtyCustOrd,
		@InclQtyOnBO = InclQtyOnBO,
		@InclQtyAlloc = InclAllocQty
	FROM 	INSetup (NOLOCK)

	-- Zero the quantity buckets for all the ItemSite records for the specified company.
	UPDATE	ItemSite
	SET	AllocQty 		= 0,	-- Quantity on packing slips (obsolete field)
		QtyAlloc 		= 0,	-- Quantity on packing slips
		QtyAvail 		= 0,	-- Quantity available
		QtyCustOrd 		= 0,	-- Quantity on all open sales orders
		QtyInTransit 		= 0,	-- In-transit supply
		QtyNotAvail 		= 0,	-- Quantity in locations where sales are not valid
		QtyOnBO			= 0,	-- Quantity on back orders (late sales orders)
		QtyOnDP			= 0,	-- Quantity on drop ship purchase orders
		QtyOnKitAssyOrders	= 0,	-- Quantity on kit assembly sales orders
		QtyOnPO			= 0, 	-- Quantity on purchase orders
		QtyOnTransferOrders	= 0,	-- Supply from transfer sales orders
		QtyShipNotInv		= 0	-- Quantity on updated shippers that haven't been journalled and released yet
--		QtyWOFirmDemand		= 0,	-- future
--		QtyWOFirmSupply		= 0,	-- future
--		QtyWORlsedDemand	= 0,	-- future
--		QtyWORlsedSupply	= 0,	-- future

	-- Zero the quantity buckets for all the Location records for the specified company.
	UPDATE	Location
	SET	QtyAlloc 		= 0,	-- Quantity on packing slips
		QtyShipNotInv		= 0	-- Quantity on updated shippers that haven't been journalled and released yet
		-- Zero the quantity buckets for all the LotSerMst records for the specified company.
	UPDATE	LotSerMst
	SET	QtyAlloc 		= 0,	-- Quantity on packing slips
		QtyShipNotInv		= 0	-- Quantity on updated shippers that haven't been journalled and released yet

	-- Zero the quantity buckets for all the ItemSite records for the specified company.
	UPDATE	ItemCost
	SET	S4Future03		= 0	-- (QtyShipNotInv) Quantity on updated shippers that haven't been journalled and released yet

-- Recalculate each of the stored quantity types that could be affecting quantity available.

	-------------------------------------------------------------
	-- Quantity on purchase orders and quantity on drop shipments
	-------------------------------------------------------------

	-- Recalculate QtyOnPO
	UPDATE 	ItemSite
	SET 	QtyOnPO = COALESCE(
			    ROUND(
			       (SELECT SUM(CASE WHEN d.QtyOrd > d.QtyRcvd
					      THEN CASE WHEN d.CnvFact = 0
                               				THEN ROUND(d.QtyOrd - d.QtyRcvd, @DecPlQty)
							ELSE CASE WHEN d.UnitMultDiv = 'D'
								  THEN ROUND(ROUND(d.QtyOrd - d.QtyRcvd, @DecPlQty) / d.CnvFact, @DecPlQty)
								  ELSE ROUND(ROUND(d.QtyOrd - d.QtyRcvd, @DecPlQty) * d.CnvFact, @DecPlQty)
								  END
							END
					      ELSE 0
					      END)		-- end of SUM(
				FROM PurOrdDet d
				   JOIN PurchOrd p  ON d.PONbr  = p.PONbr
				   JOIN Inventory i ON d.InvtID = i.InvtID
				WHERE	d.InvtID = ItemSite.InvtID
				    AND d.SiteID = ItemSite.SiteID
				    AND	d.PurchaseType <> 'GD'	-- no drop ship lines
				    AND d.OpenLine = 1		-- only open lines
				    AND p.Status IN ('O','P')	-- status = Open or Printed
				    AND p.POType IN ('OR','DP')	-- type = Regular Order or Drop Ship
				    AND i.Stkitem = 1),		-- stock items only -- end of SELECT(
			    @DecPlQty),				-- end of ROUND(
			  0)					-- end of COALESCE(

	-----------------------------------------------------------------------------------

	-- Recalculate QtyOnDP (Drop shipments)
	UPDATE 	ItemSite
	SET 	QtyOnDP = COALESCE(
			    ROUND(
			       (SELECT SUM(CASE WHEN d.QtyOrd > d.QtyRcvd
					      THEN CASE WHEN d.CnvFact = 0
                               				THEN ROUND(d.QtyOrd - d.QtyRcvd, @DecPlQty)
							ELSE CASE WHEN d.UnitMultDiv = 'D'
								  THEN ROUND(ROUND(d.QtyOrd - d.QtyRcvd, @DecPlQty) / d.CnvFact, @DecPlQty)
								  ELSE ROUND(ROUND(d.QtyOrd - d.QtyRcvd, @DecPlQty) * d.CnvFact, @DecPlQty)
								  END
							END
					      ELSE 0
					      END)		-- end of SUM(
				FROM PurOrdDet d
				   JOIN PurchOrd p  ON d.PONbr  = p.PONbr
				   JOIN Inventory i ON d.InvtID = i.InvtID
				WHERE	d.InvtID = ItemSite.InvtID
				    AND d.SiteID = ItemSite.SiteID
				    AND	d.PurchaseType = 'GD'	-- only drop ship lines
				    AND d.OpenLine = 1		-- only open lines
				    AND p.Status IN ('O','P')	-- status = Open or Printed
				    AND p.POType IN ('OR','DP')	-- type = Regular Order or Drop Ship
				    AND i.Stkitem = 1),		-- stock items only -- end of SELECT(
			    @DecPlQty),				-- end of ROUND(
			  0)					-- end of COALESCE(

	-----------------------------------------------------------------------------------

	-- Recalculate QtyInTransit
	-- We aren't paying attention to the 'retired' record flag since we retire the initial TR,
	-- but it is used to calculate in-transit quantity
	Update	ItemSite
	set	QtyInTransit = COALESCE(ROUND((
				SELECT SUM(CASE	WHEN t.TranDesc = 'Standard Cost Variance'
						THEN 0
						ELSE ROUND(CASE WHEN CnvFact = 0
								THEN ROUND(t.Qty, @DecPlQty)
								ELSE CASE 	WHEN t.UnitMultDiv = 'D'
										THEN ROUND(t.Qty / t.CnvFact, @DecPlQty)
										ELSE ROUND(t.Qty * t.CnvFact, @DecPlQty)
										END
								END * t.InvtMult * -1, @DecPlQty)
						END)
				FROM 	INTran t
				join	TrnsfrDoc d ON t.BatNbr = d.BatNbr
				WHERE 	t.InvtID = ItemSite.InvtID
				and	t.ToSiteID = ItemSite.SiteID
				and	t.TranType = 'TR'	-- transfer transaction
				and	t.Rlsed = 1		-- released only
				and	t.JrnlType <> 'OM'	-- not from OM
				and	t.S4Future09 = 0	-- QtyNoUpdate (stock items only)
				and	d.Source <> 'OM'	-- not from OM
				and	d.TransferType = '2'	-- two-step transfers
				and	d.Status = 'I'),	-- status In Transit
				@DecPlQty), 0)

	-----------------------------------------------------------------------------------

	-- Recalculate QtyShipNotInv
	-- ItemSite
	CREATE TABLE #SiteQtyShipNotInv (InvtID CHAR(30), SiteID CHAR(10), QtyShipNotInv FLOAT)
	CREATE UNIQUE CLUSTERED INDEX SiteQtyShipNotInv0 ON #SiteQtyShipNotInv (InvtID, SiteID)

	INSERT INTO #SiteQtyShipNotInv
		SELECT	v.InvtID, v.SiteID, COALESCE(ROUND(SUM(ROUND(v.QtyShipNotInv, @DecPlQty)), @DecPlQty), 0)
		FROM	vp_10990_ShipNotInvoice v
		GROUP BY v.InvtID, v.SiteID

	UPDATE	ItemSite
		Set	QtyShipNotInv = q.QtyShipNotInv
		From	ItemSite Join #SiteQtyShipNotInv q
			On ItemSite.InvtID = q.InvtID
			And ItemSite.SiteID = q.SiteID

	DROP TABLE #SiteQtyShipNotInv

	-- Location
	CREATE TABLE #LocQtyShipNotInv (InvtID CHAR(30), SiteID CHAR(10), WhseLoc CHAR(10), QtyShipNotInv FLOAT)
	CREATE UNIQUE CLUSTERED INDEX LocQtyShipNotInv0 ON #LocQtyShipNotInv (InvtID, SiteID, WhseLoc)

	INSERT INTO #LocQtyShipNotInv
		SELECT	v.InvtID, v.SiteID, v.WhseLoc, COALESCE(ROUND(SUM(ROUND(v.QtyShipNotInv, @DecPlQty)), @DecPlQty), 0)
		FROM	vp_10990_ShipNotInvoice v
		GROUP BY v.InvtID, v.SiteID, v.WhseLoc

	Update	Location
		Set	QtyShipNotInv = q.QtyShipNotInv
		From	Location Join #LocQtyShipNotInv q
			On Location.InvtID = q.InvtID
			And Location.SiteID = q.SiteID
			And Location.WhseLoc = q.WhseLoc

	DROP TABLE #LocQtyShipNotInv

	-- LotSerMst
	CREATE TABLE #LotQtyShipNotInv (InvtID CHAR(30), SiteID CHAR(10), WhseLoc CHAR(10), LotSerNbr CHAR(25), QtyShipNotInv FLOAT)
	CREATE UNIQUE CLUSTERED INDEX LotQtyShipNotInv0 ON #LotQtyShipNotInv (InvtID, SiteID, WhseLoc, LotSerNbr)

	INSERT INTO #LotQtyShipNotInv
		SELECT	v.InvtID, v.SiteID, v.WhseLoc, v.LotSerNbr, COALESCE(ROUND(SUM(ROUND(v.QtyShipNotInv, @DecPlQty)), @DecPlQty), 0)
		FROM	vp_10990_ShipNotInvoice v
		WHERE	LEN(v.LotSerNbr) > 0
		GROUP BY v.InvtID, v.SiteID, v.WhseLoc, v.LotSerNbr

	Update	LotSerMst
		Set	QtyShipNotInv = q.QtyShipNotInv
		From	LotSerMst Join #LotQtyShipNotInv q
			On LotSerMst.InvtID = q.InvtID
			And LotSerMst.SiteID = q.SiteID
			And LotSerMst.WhseLoc = q.WhseLoc
			And LotSerMst.LotSerNbr = q.LotSerNbr

	DROP TABLE #LotQtyShipNotInv

	-- ItemCost (Specific Cost ID method only.  LIFO and FIFO are updated during INBR so will never have Ship Not Invoice.)
	CREATE TABLE #CostQtyShipNotInv (InvtID CHAR(30), SiteID CHAR(10), SpecificCostID CHAR(25), QtyShipNotInv FLOAT)
	CREATE UNIQUE CLUSTERED INDEX CostQtyShipNotInv0 ON #CostQtyShipNotInv (InvtID, SiteID, SpecificCostID)

	INSERT INTO #CostQtyShipNotInv
		SELECT	v.InvtID, v.SiteID, v.SpecificCostID, COALESCE(ROUND(SUM(ROUND(v.QtyShipNotInv, @DecPlQty)), @DecPlQty), 0)
		FROM	vp_10990_ShipNotInvoice v
		WHERE	LEN(v.SpecificCostID) > 0
		GROUP BY v.InvtID, v.SiteID, v.SpecificCostID

	UPDATE	ItemCost
		Set	S4Future03 = q.QtyShipNotInv
		From	ItemCost Join #CostQtyShipNotInv q
			On ItemCost.InvtID = q.InvtID
			And ItemCost.SiteID = q.SiteID
			And ItemCost.SpecificCostID = q.SpecificCostID

	DROP TABLE #CostQtyShipNotInv

	-----------------------------------------------------------------------------------

	-- Recalculate QtyNotAvail

	UPDATE	ItemSite
	SET	QtyNotAvail = (SELECT	COALESCE(ROUND(
						SUM(ROUND(COALESCE(QtyOnHand, 0) - COALESCE(QtyShipNotInv, 0), @DecPlQty)),
					@DecPlQty), 0)
				FROM	Location L JOIN LocTable LT ON
					L.SiteID = LT.SiteID AND
					L.WhseLoc = LT.WhseLoc
				WHERE	LT.InvtID = ItemSite.InvtID AND
					LT.SiteID = ItemSite.SiteID AND
					LT.InclQtyAvail = 0)		-- unsaleable bins

	-----------------------------------------------------------------------------------

	-- Recalculate QtyCustOrd

	-- Assign the new QtyCustOrd values
	update	ItemSite
	set	QtyCustOrd = (	select	COALESCE(ROUND(-SUM(ROUND(Qty, @DecPlQty)), @DecPlQty), 0)
				from	SOPlan p
				join	Inventory i on i.InvtID = p.InvtID
				where	p.InvtID = ItemSite.InvtID
				and	p.SiteID = ItemSite.SiteID
		  		and	p.PlanType in ('30', '32', '34', '50', '52', '60', '62', '64')
				and	i.StkItem = 1
				)

	-----------------------------------------------------------------------------------

	-- Recalculate QtyOnBO

	-- Set the backorder date to today at midnight,
	select	@BODate = GetDate()
	select	@BODate = convert(smalldatetime, convert(varchar(2), datepart(mm, @BODate))
				+ '/' + convert(varchar(2), datepart(dd, @BODate))
				+ '/' + convert(varchar(4), datepart(yy, @BODate)))

	-- Assign the new QtyOnBO values
	update	ItemSite
	set	QtyOnBO = (	select	COALESCE(ROUND(-SUM(ROUND(Qty, @DecPlQty)), @DecPlQty), 0)
				from	SOPlan p
				join	Inventory i on i.InvtID = p.InvtID
				where	p.InvtID = ItemSite.InvtID
				and	p.SiteID = ItemSite.SiteID
		  		and	p.PlanType in ('50', '52', '60', '62', '64')
				and	i.StkItem = 1
				and	p.SOReqShipDate < @BODate
				)

	-----------------------------------------------------------------------------------

	-- Recalculate QtyOnKitAssyOrders

	-- Assign the new QtyOnKitAssyOrders values
	update	ItemSite
	set	QtyOnKitAssyOrders = (	select	COALESCE(ROUND(SUM(ROUND(Qty, @DecPlQty)), @DecPlQty), 0)
					from	SOPlan p
					join	Inventory i on i.InvtID = p.InvtID
					where	p.InvtID = ItemSite.InvtID
					and	p.SiteID = ItemSite.SiteID
		  			and	p.PlanType in ('25', '26')
					and	i.StkItem = 1
					)

	-----------------------------------------------------------------------------------

	-- Recalculate QtyOnTransferOrders

	-- Assign the new QtyOnTransferOrders values
	update	ItemSite
	set	QtyOnTransferOrders = (	select	COALESCE(ROUND(SUM(ROUND(Qty, @DecPlQty)), @DecPlQty), 0)
					from	SOPlan p
					join	Inventory i on i.InvtID = p.InvtID
					where	p.InvtID = ItemSite.InvtID
					and	p.SiteID = ItemSite.SiteID
		  			and	p.PlanType in ('28', '29')
					and	i.StkItem = 1
					)

	-----------------------------------------------------------------------------------

	-- Recalculate QtyAlloc and AllocQty

	-- Assign the new QtyAlloc values

Update	ItemSite
	Set	QtyAlloc = (Select COALESCE(SUM(Case	When lin.CnvFact = 0
								Then 0
							Else	Case	When RTrim(lin.UnitMultDiv) = 'D'
										Then COALESCE(ROUND(lot.QtyShip / lin.CnvFact, @DecPlQty),0)
									Else COALESCE(ROUND(lot.QtyShip * lin.CnvFact, @DecPlQty),0)
								 End
						End), 0)
				From	SOPlan p with(INDEX(SOPlan6)) INNER LOOP Join SOShipLot lot
						On p.CpnyID = lot.CpnyID
						and p.SOShipperID = lot.ShipperID
						and p.SOShipperLineRef = lot.LineRef
					INNER LOOP JOIN  SOShipLine lin
						on lot.CpnyID = lin.CpnyID
						and lot.ShipperID = lin.ShipperID
						and lot.LineRef = lin.LineRef
					join Inventory i
						on i.InvtID = p.InvtID
				where	p.InvtID = ItemSite.InvtID
					and	p.SiteID = ItemSite.SiteID
					and	p.PlanType in ('30', '32', '34')
					and	i.StkItem = 1)

/*
	Recalculate QtyAlloc for Location
*/

Update	Location
	Set	QtyAlloc = (Select COALESCE(SUM(Case	When lin.CnvFact = 0
								Then 0
							Else	Case	When RTrim(lin.UnitMultDiv) = 'D'
										Then COALESCE(ROUND(lot.QtyShip / lin.CnvFact, @DecPLQty),0)
									Else COALESCE(ROUND(lot.QtyShip * lin.CnvFact, @DecPLQty),0)
								 End
						End), 0)
				From	SOPlan p with (INDEX(SOPlan6)) INNER LOOP Join SOShipLot lot
						On p.CpnyID = lot.CpnyID
						and p.SOShipperID = lot.ShipperID
						and p.SOShipperLineRef = lot.LineRef
					INNER LOOP join SOShipLine lin
						on lot.CpnyID = lin.CpnyID
						and lot.ShipperID = lin.ShipperID
						and lot.LineRef = lin.LineRef
					 JOIN Inventory i
						on i.InvtID = p.InvtID
				where	p.InvtID = Location.InvtID
					and	p.SiteID = Location.SiteID
					and	lot.WhseLoc = Location.WhseLoc
					and	p.PlanType in ('30', '32', '34')
					and	i.StkItem = 1)

/*
	Recalculate QtyAlloc for LotSerMst
*/
Update	LotSerMst
	Set	QtyAlloc = (Select COALESCE(SUM(Case	When lin.CnvFact = 0
								Then 0
							Else	Case	When RTrim(lin.UnitMultDiv) = 'D'
										Then COALESCE(ROUND(lot.QtyShip / lin.CnvFact, @DecPlQty),0)
									Else COALESCE(ROUND(lot.QtyShip * lin.CnvFact, @DecPlQty),0)
								 End
						End), 0)
				From	SOPlan p with (INDEX(SOPlan6)) INNER LOOP JOIN SOShipLot lot
						On p.CpnyID = lot.CpnyID
						and p.SOShipperID = lot.ShipperID
						and p.SOShipperLineRef = lot.LineRef
					INNER LOOP join SOShipLine lin
						on lot.CpnyID = lin.CpnyID
						and lot.ShipperID = lin.ShipperID
						and lot.LineRef = lin.LineRef
					join Inventory i
						on i.InvtID = p.InvtID
				where	p.InvtID = LotSerMst.InvtID
					and	p.SiteID = LotSerMst.SiteID
					and	lot.WhseLoc = LotSerMst.WhseLoc
					and	lot.LotSerNbr = LotSerMst.LotSerNbr
					and	Len(lot.LotSerNbr) > 0
					and	p.PlanType in ('30', '32', '34')
					and	i.StkItem = 1)

	-- Assign the new AllocQty values
	update	ItemSite
	set	AllocQty = QtyAlloc
	where	QtyAlloc <> 0
		-----------------------------------------------------------------------------------

	-- Recalculate QtyAvail

	update	ItemSite
	set	QtyAvail = CASE WHEN Inventory.StkItem <> 0
				THEN ROUND(QtyOnHand - QtyNotAvail - QtyShipNotInv
					+ (CASE WHEN @InclQtyInTransit = 1 THEN QtyInTransit + QtyOnTransferOrders ELSE 0 END)
					+ (CASE WHEN @InclQtyOnPO = 1 THEN QtyOnPO ELSE 0 END)
					+ (CASE WHEN @InclQtyOnWO = 1 THEN QtyOnKitAssyOrders ELSE 0 END)
					- (CASE WHEN @InclQtyCustOrd = 1 THEN QtyCustOrd ELSE 0 END)
					- (CASE WHEN @InclQtyOnBO = 1  AND @InclQtyCustOrd = 0 THEN QtyOnBO ELSE 0 END)
					- (CASE WHEN @InclQtyAlloc = 1 AND @InclQtyCustOrd = 0 THEN QtyAlloc ELSE 0 END) , @DecPlQty)
				ELSE 0
				END,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @ProgID,
		LUpd_User = @UserID
	FROM	ItemSite
	LEFT JOIN Inventory ON Inventory.InvtID = ItemSite.InvtID
	where	Inventory.StkItem = 1


