
CREATE VIEW [QQ_woheader]
AS
SELECT	H.WONbr AS [Work Order Number], H.CpnyID AS [Company ID], H.ProcStage AS [Processing Stage], H.Status, 
		CONVERT(DATE,H.PlanStart) AS [Plan Start Date], CONVERT(DATE,H.PlanEnd) AS [Plan End Date], B.BuildToType AS [Build To Type], 
		H.InvtID AS [Inventory ID], B.SiteID AS [Site ID], B.WhseLoc AS [Warehouse Bin Location], B.QtyCurrent AS [Current Qty], 
		B.QtyRemaining AS [Remaining Qty], B.QtyCompleteOps AS [Completed Qty], B.QtyQCHold AS [Quality Ctrl Hold Qty], B.QtyScrap AS [Scrap Qty], 
		B.QtyComplete AS [Completed & Costed Qty], B.QtyReDirect AS [Redirected Qty], B.QtyRework AS [Rework Qty], 
		B.QtyReworkComp AS [Completed Rework Qty], B.CustID AS [Customer ID], B.OrdNbr AS [Sales Order Nbr], 
		B.SpecificCostID AS [Specific Cost ID], B.BuildToWO AS [Build To Work Order], B.QtyOrig AS [Original Qty], 
		B.BuildToProj AS [Build To Project], B.BuildToTask AS [Build To Task], B.BuildToLineRef AS [Build To Line Reference Nbr], 
		B.TargetDescr AS [Target Description], CONVERT(DATE,H.Crtd_DateTime) AS [Create Date], H.Crtd_Prog AS [Create Program], 
		CONVERT(TIME,H.Crtd_Time) AS [Create Time], H.Crtd_User AS [Create User], CONVERT(DATE,H.LUpd_DateTime) AS [Last Update Date], 
		H.LUpd_Prog AS [Last Update Program], CONVERT(TIME,H.LUPd_Time) AS [Last Update Time], H.LUpd_User AS [Last Update User]
FROM	WOHeader H with (nolock) 
			INNER JOIN WOBuildTo B with (nolock) ON H.CpnyID = B.CpnyID AND H.WONbr = B.WONbr 

