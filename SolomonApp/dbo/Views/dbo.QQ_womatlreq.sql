
CREATE VIEW [QQ_womatlreq]
AS
SELECT	M.WONbr AS [Work Order Nbr], M.CpnyID AS [Company ID], H.InvtID AS [Finished Good], H.ProcStage AS [Processing Stage], H.Status, 
		CONVERT(DATE,H.PlanStart) AS [Plan Start Date], CONVERT(DATE,H.PlanEnd) AS [Plan End Date], M.Sequence, M.LineRef AS [Line Reference Nbr], 
		M.InvtID AS [Component ID], M.SiteID AS [Site ID], M.WhseLoc AS [Warehouse Bin Location], M.QtyToIssue AS [Issue Now], 
		M.QtyWOReqd AS [WO Qty Required], M.QtyRemaining AS [Qty Remaining], M.SpecificCostID AS [Specific Cost ID], M.StockUsage AS [Stock Usage], 
		I.StkUnit AS [Stocking UOM], M.QtyStd AS [Std Qty/Unit], CONVERT(DATE,M.DateReqd) AS [Required Date], M.UnitCost AS [Unit Cost], 
		M.RtgStep AS [Routing Step], M.Comment, M.CompAdded AS [Component Added], M.CnvFact AS [Conversion Factor], 
		CONVERT(DATE,M.Crtd_DateTime) AS [Create Date], M.Crtd_Prog AS [Create Program], CONVERT(TIME,M.Crtd_Time) AS [Create Time], 
		M.Crtd_User AS [Create User], M.LSLineCntr AS [Lot/Serial Line Counter], CONVERT(DATE,M.LUpd_DateTime) AS [Last Update Date], 
		M.LUpd_Prog AS [Last Update Program], CONVERT(TIME,M.LUPd_Time) AS [Last Update Time], M.LUpd_User AS [Last Update User], M.NoteID, 
		M.QtyAutoIssuedPO AS [Qty from PO], M.QtyAutoIssuedWO AS [Qty from WO], M.QtyIssuedToDate AS [Qty Issued], M.QtyScrapNoReAlloc AS [Qty Scrapped], 
		M.QtyScrapReAlloc AS [Qty Scrapped/Reallocation], M.QtyTransferInWO AS [Qty Transferred from wO], M.QtyTransferOutNoReA AS [Qty Transfer Out], 
		M.QtyTransferOutReA AS [Qty Transfer Out/Reallocation], M.S4Future01, M.S4Future02, M.S4Future03, M.S4Future04, M.S4Future05, M.S4Future06, 
        CONVERT(DATE,M.S4Future07) AS [S4Future07], CONVERT(DATE,M.S4Future08) AS [S4Future08], M.S4Future09, M.S4Future10, M.S4Future11, M.S4Future12, 
        M.Task, M.UnitDesc AS UOM, M.User1, M.User2, M.User3, M.User4, M.User5, M.User6, CONVERT(DATE,M.User7) AS [User7], CONVERT(DATE,M.User8) AS [User8], 
        M.User9, M.User10
FROM	WOMatlReq M with (nolock) 
			INNER JOIN WOHeader H with (nolock) ON M.CpnyID = H.CpnyID AND M.WONbr = H.WONbr 
			INNER JOIN Inventory I with (nolock) ON M.InvtID = I.InvtID

