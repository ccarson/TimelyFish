 


Create View vr_40791_EARWarnings As


          
	--------------------------------------  
	-- Late Sales Orders Section
	--------------------------------------
	SELECT	'WarningType' = "LateSalesOrders", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = SOSched.ReqDate,
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = "",
		'POLineRef' = "",
		'QtyDiff' = 0,
		'SOUOM' = "",
		'SODemand' = 0,
		'SOSchedStatus' = "",
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = "",
		'WONbr' = "",
		'WOBuildToLineRef' = "",
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		LEFT OUTER JOIN POAlloc 
		on SOSched.CpnyID = POAlloc.CpnyID
		and SOSched.OrdNbr = POAlloc.SOOrdNbr
		and SOSched.LineRef = POAlloc.SOLineRef
		and SOSched.SchedRef = POAlloc.SOSchedRef
	WHERE	SOSched.Status = "O"
		and POAlloc.CpnyID is null
		and POAlloc.SOOrdNbr is null
		and POAlloc.SOLineRef is null
		and POAlloc.SOSchedRef is null
	  	and SOLine.BoundToWO = 0

	UNION
	--------------------------------------  
	-- Late Purchase Orders
	--------------------------------------
	SELECT	'WarningType' = "LatePurchaseOrders", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = SOSched.ReqDate,
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = PurOrdDet.PromDate,
		'PONbr' = POAlloc.PONbr,
		'POLineRef' = POAlloc.POLineRef,
		'QtyDiff' = 0,
		'SOUOM' = "",
		'SODemand' = 0,
		'SOSchedStatus' = "",
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = "",
		'WONbr' = "",
		'WOBuildToLineRef' = "",
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		JOIN POAlloc 
		on SOSched.CpnyID = POAlloc.CpnyID
		and SOSched.OrdNbr = POAlloc.SOOrdNbr
		and SOSched.LineRef = POAlloc.SOLineRef
		and SOSched.SchedRef = POAlloc.SOSchedRef
		JOIN PurchOrd 
		on POAlloc.PONbr = PurchOrd.PONbr
		JOIN PurOrdDet
		on PurchOrd.PONbr = PurOrdDet.PONbr
		and POAlloc.POLineRef = PurOrdDet.LineRef
	WHERE	SOSched.Status = "O"
		and PurchOrd.POType = "OR"
		and PurOrdDet.PromDate > SOSched.ReqPickDate
            
	UNION
	--------------------------------------  
	-- Purchase Order Quantity Shortage/Surplus
	--------------------------------------
	SELECT	'WarningType' = "PurchaseOrderQtyShortageSurplus", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = "",
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = POAlloc.PONbr,
		'POLineRef' = POAlloc.POLineRef,
		'QtyDiff' = Case When SOLine.UnitMultDiv = "D" Then
					-- Convert the PO units to stocking units and then convert it back up to Sales Order Units.
					Round( ((Case When PurOrdDet.UnitMultDiv = "D" Then Round(PurOrdDet.QtyOrd / PurOrdDet.CnvFact, POSetup.DecPlQty) Else Round(PurOrdDet.QtyOrd * PurOrdDet.CnvFact, POSetup.DecPlQty) end)  
						- (Case When SOLine.UnitMultDiv = "D" Then Round(SOSched.QtyOrd / SOLine.CnvFact, PL.DecPlQty) Else Round(SOSched.QtyOrd * SOLine.CnvFact, PL.DecPlQty) end)) * SOLine.CnvFact, PL.DecPlQty)
				else
					Round( ((Case When PurOrdDet.UnitMultDiv = "D" Then Round(PurOrdDet.QtyOrd / PurOrdDet.CnvFact, POSetup.DecPlQty) Else Round(PurOrdDet.QtyOrd * PurOrdDet.CnvFact, POSetup.DecPlQty) end)  
						- (Case When SOLine.UnitMultDiv = "D" Then Round(SOSched.QtyOrd / SOLine.CnvFact, PL.DecPlQty) Else Round(SOSched.QtyOrd * SOLine.CnvFact, PL.DecPlQty) end)) / SOLine.CnvFact, PL.DecPlQty)  END,
		'SOUOM' = SOLine.UnitDesc,
		'SODemand' = Case When SOSched.Status = "O" Then SOSched.QtyOrd else 0 end,
		'SOSchedStatus' = SOSched.Status,
		'POSupply' = Case When PurchOrd.Status in ("O", "P") Then 
					-- Convert the PO units to stocking units and then convert it back up to Sales Order Units.
					Case When SOLine.UnitMultDiv = "D" Then
						Round( (Case When PurOrdDet.UnitMultDiv = "D" Then Round(PurOrdDet.QtyOrd / PurOrdDet.CnvFact, POSetup.DecPlQty) Else Round(PurOrdDet.QtyOrd * PurOrdDet.CnvFact, POSetup.DecPlQty) end) * SOLine.CnvFact, PL.DecPlQty) 
					Else
						Round( (Case When PurOrdDet.UnitMultDiv = "D" Then Round(PurOrdDet.QtyOrd / PurOrdDet.CnvFact, POSetup.DecPlQty) Else Round(PurOrdDet.QtyOrd * PurOrdDet.CnvFact, POSetup.DecPlQty) end) / SOLine.CnvFact, PL.DecPlQty) END					
				  When PurchOrd.Status = "M" Then 
					Case When SOLine.UnitMultDiv = "D" Then
						Round( (Case When PurOrdDet.UnitMultDiv = "D" Then Round(PurOrdDet.QtyRcvd / PurOrdDet.CnvFact, POSetup.DecPlQty) Else Round(PurOrdDet.QtyRcvd * PurOrdDet.CnvFact, POSetup.DecPlQty) end) * SOLine.CnvFact, PL.DecPlQty) 
					Else
						Round( (Case When PurOrdDet.UnitMultDiv = "D" Then Round(PurOrdDet.QtyRcvd / PurOrdDet.CnvFact, POSetup.DecPlQty) Else Round(PurOrdDet.QtyRcvd * PurOrdDet.CnvFact, POSetup.DecPlQty) end) / SOLine.CnvFact, PL.DecPlQty) END
			          else 0 end,

		'POStatus' = PurchOrd.Status,
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = "",
		'WONbr' = "",
		'WOBuildToLineRef' = "",
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	vp_DecPl Pl (NoLock), POSetup (NoLock),
		SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		JOIN POAlloc 
		on SOSched.CpnyID = POAlloc.CpnyID
		and SOSched.OrdNbr = POAlloc.SOOrdNbr
		and SOSched.LineRef = POAlloc.SOLineRef
		and SOSched.SchedRef = POAlloc.SOSchedRef
		JOIN PurchOrd 
		on POAlloc.PONbr = PurchOrd.PONbr
		JOIN PurOrdDet
		on PurchOrd.PONbr = PurOrdDet.PONbr
		and POAlloc.POLineRef = PurOrdDet.LineRef
	WHERE	SOSched.Status = "O"
		and PurchOrd.POType = "OR"
		and SOSched.SiteID <> PurOrdDet.SiteID
	
	
	UNION
	--------------------------------------  
	-- Purchase Order Site Mismatches
	--------------------------------------
	SELECT	'WarningType' = "PurchaseOrderSiteMismatches", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = "",
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = POAlloc.PONbr,
		'POLineRef' = POAlloc.POLineRef,
		'QtyDiff' = 0,
		'SOUOM' = "",
		'SODemand' = 0,
		'SOSchedStatus' = "",
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOSched.SiteID,
		'POSiteID' = PurOrdDet.SiteID,
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = "",
		'WONbr' = "",
		'WOBuildToLineRef' = "",
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		JOIN POAlloc 
		on SOSched.CpnyID = POAlloc.CpnyID
		and SOSched.OrdNbr = POAlloc.SOOrdNbr
		and SOSched.LineRef = POAlloc.SOLineRef
		and SOSched.SchedRef = POAlloc.SOSchedRef
		JOIN PurchOrd 
		on POAlloc.PONbr = PurchOrd.PONbr
		JOIN PurOrdDet
		on PurchOrd.PONbr = PurOrdDet.PONbr
		and POAlloc.POLineRef = PurOrdDet.LineRef
	WHERE	SOSched.Status = "O"
		and PurchOrd.POType = "OR"
		and SOSched.SiteID <> PurOrdDet.SiteID

	UNION
	--------------------------------------  
	-- Purchase Order Inventory ID Mismatches
	--------------------------------------
	SELECT	'WarningType' = "PurchaseOrderInventoryIDMismatches", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = "",
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = POAlloc.PONbr,
		'POLineRef' = POAlloc.POLineRef,
		'QtyDiff' = 0,
		'SOUOM' = "",
		'SODemand' = 0,
		'SOSchedStatus' = "",
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOSched.SiteID,
		'POSiteID' = PurOrdDet.SiteID,
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = PurOrdDet.InvtID,
		'WOInvtID' = "",
		'WOPlanEndDate' = "",
		'WONbr' = "",
		'WOBuildToLineRef' = "",
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		JOIN POAlloc 
		on SOSched.CpnyID = POAlloc.CpnyID
		and SOSched.OrdNbr = POAlloc.SOOrdNbr
		and SOSched.LineRef = POAlloc.SOLineRef
		and SOSched.SchedRef = POAlloc.SOSchedRef
		JOIN PurchOrd 
		on POAlloc.PONbr = PurchOrd.PONbr
		JOIN PurOrdDet
		on PurchOrd.PONbr = PurOrdDet.PONbr
		and POAlloc.POLineRef = PurOrdDet.LineRef
	WHERE	SOSched.Status = "O"
		and PurchOrd.POType = "OR"
		and SOLine.InvtID <> PurOrdDet.InvtID

	UNION
	--------------------------------------  
	-- Late Work Orders
	--------------------------------------
	SELECT	'WarningType' = "LateWorkOrders", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = SOSched.ReqDate,
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = "",
		'POLineRef' = "",
		'QtyDiff' = 0,
		'SOUOM' = "",
		'SODemand' = 0,
		'SOSchedStatus' = "",
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = WOHeader.PlanEnd,
		'WONbr' = WOHeader.WONbr,
		'WOBuildToLineRef' = WOBuildTo.BuildToLineRef,
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		JOIN WOBuildTo
		ON WOBuildTo.WONbr = SOLine.ProjectID
		and WOBuildTo.OrdNbr = SOLine.OrdNbr
		and WOBuildTo.BuildToLineRef = SOLine.LineRef
		LEFT OUTER JOIN WOHeader
		On WOHeader.WONbr = WOBuildTo.WONbr
	WHERE	SOSched.Status = "O"
		and SOLine.BoundToWO <> 0
		and WOBuildTo.OrdNbr <> "" 
		and WOBuildTo.LineRef <> "" 
		and WOBuildTo.QtyRemaining <> 0 
		and WOBuildTo.Status = "P"
		and WOHeader.Status <> "P"
		and SOSched.ReqPickDate < WOHeader.PlanEnd		

	UNION

	--------------------------------------  
	-- Work Order Quantity Shortage/Surplus - PART 1
	-- Searching SOSched for Open Sales 
	-- Order Schedules Bound to Work Orders.
	--------------------------------------
	SELECT	'WarningType' = "WorkOrderQuantityShortageSurplus", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = "",
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = "",
		'POLineRef' = "",
		'QtyDiff' = Case When WOBuildTo.WONbr is NULL or WOHeader.PlanEnd = "" then 0 - SOLine.QtyOrd
				 -- Convert the WO units which are stored in Stocking Units up to Sales Order UOM.
				 When WOHeader.PlanEnd <> "" and WOHeader.Status = "P" then (Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyComplete * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyComplete * SOLine.CnvFact, PL.DecPlQty) end) - SOLine.QtyOrd
				 When WOHeader.PlanEnd <> "" and WOHeader.Status <> "P" then (Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) end)  - SOLine.QtyOrd end,
					
		'SOUOM' = SOLine.UnitDesc,
		'SODemand' = Case When SOSched.Status = "O" Then SOSched.QtyOrd else 0 end,
		'SOSchedStatus' = SOSched.Status,
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = WOHeader.PlanEnd,
		'WONbr' = WOHeader.WONbr,
		'WOBuildToLineRef' = WOBuildTo.LineRef,
		'SOQtyRemain' = SOLine.QtyOrd - SOLine.QtyShip,
		'WOQtyRemain' = (Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyRemaining * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyRemaining * SOLine.CnvFact, PL.DecPlQty) end),
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = Case When WOHeader.Status in ("A", "H") then 
					-- Convert the WO units which are stored in Stocking Units up to Sales Order UOM.
					(Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) end)
			     else 	(Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyComplete * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyComplete * SOLine.CnvFact, PL.DecPlQty) end) end,

		'WOStatus' = WOHeader.Status,
		'WOProcStage' = WOHeader.ProcStage
	FROM	vp_DecPl Pl (NoLock),
		SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		LEFT JOIN WOBuildTo
		ON WOBuildTo.WONbr = SOLine.ProjectID
		and WOBuildTo.OrdNbr = SOLine.OrdNbr
		and WOBuildTo.BuildToLineRef = SOLine.LineRef
		LEFT JOIN WOHeader
		On WOHeader.WONbr = WOBuildTo.WONbr
	WHERE	SOSched.Status = "O"
		and SOLine.BoundToWO <> 0

	UNION

	--------------------------------------  
	-- Work Order Quantity Shortage/Surplus - PART 2
	-- Searching WOBuildTo for Open Work Orders
	-- Bound to Sales Orders.
	--------------------------------------
	SELECT	'WarningType' = "WorkOrderQuantityShortageSurplus", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = "",
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = "",
		'POLineRef' = "",
		'QtyDiff' = Case When SOSched.Status = "O" then 
				(Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) end) - SOSched.QtyOrd 
			    else (Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) end) end,
		'SOUOM' = SOLine.UnitDesc,
		'SODemand' = Case When SOSched.Status = "O" Then SOSched.QtyOrd else 0 end,
		'SOSchedStatus' = SOSched.Status,
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = WOHeader.PlanEnd,
		'WONbr' = WOHeader.WONbr,
		'WOBuildToLineRef' = WOBuildTo.LineRef,
		'SOQtyRemain' = SOLine.QtyOrd - SOLine.QtyShip,
		'WOQtyRemain' = (Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyRemaining * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyRemaining * SOLine.CnvFact, PL.DecPlQty) end),
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = Case When WOHeader.Status in ("A", "H") then 
					(Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyCurrent * SOLine.CnvFact, PL.DecPlQty) end)
			     else 	(Case When SOLine.UnitMultDiv = "D" Then Round(WOBuildTo.QtyComplete * SOLine.CnvFact, PL.DecPlQty) else Round(WOBuildTo.QtyComplete * SOLine.CnvFact, PL.DecPlQty) end) end,
		'WOStatus' = WOHeader.Status,
		'WOProcStage' = WOHeader.ProcStage
	FROM	vp_DecPl Pl (NoLock),
		SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		JOIN WOBuildTo
		ON WOBuildTo.WONbr = SOLine.ProjectID
		and WOBuildTo.OrdNbr = SOLine.OrdNbr
		and WOBuildTo.BuildToLineRef = SOLine.LineRef
		LEFT JOIN WOHeader
		On WOHeader.WONbr = WOBuildTo.WONbr
	WHERE	WOBuildTo.BuildToType = "ORD"
		and WOHeader.PlanEnd <> ""
		and WOHeader.Status <> "P"
		and WOHeader.ProcStage in ("P", "F", "R")
		
	UNION
	--------------------------------------  
	-- Work Order Site Mismatches
	--------------------------------------
	SELECT	'WarningType' = "WorkOrderSiteMismatches", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = "",
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = "",
		'POLineRef' = "",
		'QtyDiff' = 0,
		'SOUOM' = "",
		'SODemand' = 0,
		'SOSchedStatus' = "",
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = WOBuildTo.SiteID,
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = "",
		'WONbr' = WOHeader.WONbr,
		'WOBuildToLineRef' = WOBuildTo.BuildToLineRef,
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		JOIN WOBuildTo
		ON WOBuildTo.WONbr = SOLine.ProjectID
		and WOBuildTo.OrdNbr = SOLine.OrdNbr
		and WOBuildTo.BuildToLineRef = SOLine.LineRef
		LEFT JOIN WOHeader
		On WOHeader.WONbr = WOBuildTo.WONbr
	WHERE	SOSched.Status = "O"
		and SOLine.BoundToWO <> 0
		and WOBuildTo.OrdNbr <> "" 
		and WOBuildTo.LineRef <> "" 
		and WOBuildTo.QtyRemaining <> 0 
		and WOBuildTo.Status = "P"
		and WOHeader.Status <> "P"
		and SOLine.SiteID <> WOBuildTo.SiteID

	UNION
	--------------------------------------  
	-- Work Order Inventory ID Mismatches
	--------------------------------------
	SELECT	'WarningType' = "WorkOrderInventoryIDMismatches", 
		'SOReqPickDate' = SOSched.ReqPickDate,
		'SOReqDate' = "",
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = SOSched.SchedRef,
		'POPromDate' = "",
		'PONbr' = "",
		'POLineRef' = "",
		'QtyDiff' = 0,
		'SOUOM' = "",
		'SODemand' = 0,
		'SOSchedStatus' = "",
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = WOBuildTo.InvtID,
		'WOPlanEndDate' = "",
		'WONbr' = WOHeader.WONbr,
		'WOBuildToLineRef' = WOBuildTo.BuildToLineRef,
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = 0,
		'WOCostLayerType' = "",
		'WOCostSpecificCostID' = "",
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
	 	JOIN SOSched
		On SOLine.CpnyID = SOSched.CpnyID
		and SOLine.OrdNbr = SOSched.OrdNbr
		and SOLine.LineRef = SOSched.LineRef
		JOIN WOBuildTo
		ON WOBuildTo.WONbr = SOLine.ProjectID
		and WOBuildTo.OrdNbr = SOLine.OrdNbr
		and WOBuildTo.BuildToLineRef = SOLine.LineRef
		LEFT JOIN WOHeader
		On WOHeader.WONbr = WOBuildTo.WONbr
	WHERE	SOSched.Status = "O"
		and SOLine.BoundToWO <> 0
		and WOBuildTo.OrdNbr <> "" 
		and WOBuildTo.LineRef <> "" 
		and WOBuildTo.QtyRemaining <> 0 
		and WOBuildTo.Status = "P"
		and WOHeader.Status <> "P"
		and SOLine.InvtID <> WOBuildTo.InvtID

	UNION
	--------------------------------------  
	-- Surplus Quantity in Work Order Cost Layer for Closed Sales Order Lines
	--------------------------------------
	SELECT	'WarningType' = "SurplusQuantityInWorkOrderCostLayer", 
		'SOReqPickDate' = "",
		'SOReqDate' = "",
		'CustID' = SOHeader.CustID,
		'OrdNbr' = SOHeader.OrdNbr,
		'SOLineRef' = SOLine.LineRef,
		'SOSchedRef' = "",
		'POPromDate' = "",
		'PONbr' = "",
		'POLineRef' = "",
		'QtyDiff' = 0,
		'SOUOM' = "",
		'SODemand' = 0,
		'SOSchedStatus' = "",
		'POSupply' = 0,
		'POStatus' = "",
		'SOSiteID' = SOLine.SiteID,
		'POSiteID' = "",
		'WOSiteID' = "",
		'SOInvtID' = SOLine.InvtID,
		'POInvtID' = "",
		'WOInvtID' = "",
		'WOPlanEndDate' = "",
		'WONbr' = "",
		'WOBuildToLineRef' = "",
		'SOQtyRemain' = 0,
		'WOQtyRemain' = 0,
		'WOCostLayerQty' = ItemCost.Qty,
		'WOCostLayerType' = ItemCost.LayerType,
		'WOCostSpecificCostID' = ItemCost.SpecificCostID,
		'WOSupply' = 0,
		'WOStatus' = "",
		'WOProcStage' = ""
	FROM	SOHeader
	 	JOIN SOLine 
	 	On SOHeader.CpnyID = SOLine.CpnyID
	 	and SOHeader.OrdNbr = SOLine.OrdNbr
		JOIN ItemCost
		On ItemCost.SpecificCostID = RTrim(SOLine.OrdNbr) + RTrim(SOLine.LineRef)
	WHERE	SOLine.BoundToWO <> 0
		and ItemCost.LayerType = "W"
		and SOLine.Status in ("C", "X")



 
