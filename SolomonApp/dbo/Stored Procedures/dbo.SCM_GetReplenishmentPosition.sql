 Create	Procedure SCM_GetReplenishmentPosition
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@LeadTimeDate	smalldatetime
	As
		Select IsNull(Sum(Qty),0)
		From	SOPlan (NoLock)
		Where	InvtID = @InvtID
		  And 	SiteID = @SiteID
		  And	PlanDate <= @LeadTimeDate

		  -- QOH
		  And	(PlanType = '10'	   -- Inventory On Hand

		  -- Supply
		  or	(PlanType in ('20', '21', '23', '24')) -- Purchase Order, PO for Sales Order
		  or	(PlanType in ('15', '17')) -- WO Firm Supply, Firm Supply Fixed (Firm Supply Bound to a Sales Order)
		  or	(PlanType in ('16', '18')) -- WO Released Supply, Released Supply Fixed ( Released Supply Bound to a Sales Order)
		  or	(Plantype in ('25', '26')) -- Kit Assembly, Shipper for Kit Assembly (Manual Ahipper)

		  -- Transfers
		  or	(Plantype in ('28', '29'))  -- Transfer In, Shipper for Transfer In

		  -- Demand
		  or	(Plantype in ('50', '54', '60', '52', '62', '64')) -- Sales Order Bound to PO,SO bound to WO,Sales Order, Kit Component Bound to PO, Kit Component, Transfer Out
		  or	(Plantype in ('30', '32', '34'))  -- Shipper, Shipper for Kit Component,Shipper for Transfer Out
		  or	(Plantype = '80') -- WO Firm Demand
		  or	(Plantype = '82')) --WO Rlsed Demand



