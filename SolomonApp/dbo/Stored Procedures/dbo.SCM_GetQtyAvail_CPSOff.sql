 Create	Procedure SCM_GetQtyAvail_CPSOff
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@LeadTimeDate	smalldatetime
	As
	-- Supply Options
	Declare	@InclQtyOnPO		smallint
	Declare	@InclQtyInTransit	smallint
	Declare @InclQtyOnWO		smallint
	Declare	@InclWOFirmSupply	smallint
	Declare @InclWORlsedSupply	smallint

	-- Demand Options
	Declare @InclQtyCustOrd		smallint
	Declare @InclQtyOnBO		smallint
	Declare @InclAllocQty		smallint
	Declare @InclWOFirmDemand	smallint
	Declare @InclWORlsedDemand	smallint

	-- Get the Qty Avail Supply and Demand Options from INSetup
	SELECT 	@InclQtyOnPO 		= InclQtyOnPO,
		@InclQtyInTransit 	= InclQtyInTransit,
		@InclQtyOnWO 		= InclQtyOnWO,
		@InclWOFirmSupply	= InclWOFirmSupply,
		@InclWORlsedSupply	= InclWORlsedSupply,

		@InclQtyCustOrd		= InclQtyCustOrd,
		@InclQtyOnBO		= InclQtyOnBO,
		@InclAllocQty		= InclAllocQty,
		@InclWOFirmDemand	= InclWOFirmDemand,
		@InclWORlsedDemand	= InclWORlsedDemand
	From	INSetup


	Select  Sum(Qty)
		From	SOPlan (NoLock)
		Where	InvtID LIKE @InvtID
		  And 	SiteID LIKE @SiteID
		  And	PlanDate <= @LeadTimeDate

		  -- QOH
		  And	(PlanType = '10'						-- PlanTypeInventory

		  -- Supply
		  or	(PlanType in ('20', '21') and @InclQtyOnPO <> 0)		-- PlanTypePOFloating, PlanTypePOFixed
		  or	(PlanType in ('15', '17') and @InclWOFirmSupply <> 0)		-- PlanTypeWOFirmSupply, PlanTypeWOFirmSupplyFixed
		  or	(PlanType in ('16', '18') and @InclWORlsedSupply <> 0)		-- PlanTypeWORlsdSupply, PlanTypeWORlsdSupplyFixed
		  or	(Plantype in ('25', '26') and @InclQtyOnWO <> 0)		-- PlanTypeSOKitIn, PlanTypeShKitIn

		  -- Transfers
		  or	(Plantype in ('28', '29', '66')  and @InclQtyInTransit <> 0)	-- PlanTypeSOTransferIn, PlanTypeShTransferIn, PlanTypeExpired

		  -- Demand
		  or	(Plantype in ('50', '54', '60', '52', '62', '64',  '30', '32', '34') and @InclQtyCustOrd <> 0)	-- PlanTypeSOFixed, PlanTypeSOWOFixed, PlanTypeSOFloating, PlanTypeSOCompFixed, PlanTypeSOCompOut, PlanTypeSOTransferOut
		  or	(Plantype in ('50', '54', '60', '52', '62', '64') and PlanDate < GetDate() and @InclQtyOnBO <> 0)   --Back Orders
		  or	(Plantype in ('30', '32', '34') and @InclAllocQty <> 0)				-- PlanTypeShipper, PlanTypeShCompOut, PlanTypeShTransferOut
		  or	(Plantype = '80' and @InclWOFirmDemand <> 0)					-- PlanTypeWOFirmDemand
		  or	(Plantype = '82' and @InclWORlsedDemand <> 0))					-- PlanTypeWORlsdDemand
	Group By InvtID, SiteID
	Order By Sum(Qty)


