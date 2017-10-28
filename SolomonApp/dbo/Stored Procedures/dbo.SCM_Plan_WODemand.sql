 CREATE PROCEDURE SCM_Plan_WODemand
	@ComputerName	VarChar(21),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@DecPlQty	SmallInt
As
	SET NOCOUNT ON
/*
	WOHeader.Status
		- H - Hold
		- A - Active
		- P - Purge
	WOHeader.WOType
		- M - Manufacturing
		- R - Rework
		- P - Project Work Order
	Where	WOHeader.WOType In ('M', 'R')
		Then	WOMatlReq.WOTask Always Equals WOSetup.Mfg_Task
	Processing Stage
		- P - Plan
		- F - Firm
		- R - Released
		- O - Operation Closed
		- C - Financially Closed
	Where	WOHeader.WOType In ('M', 'R')
		Then	WOHeader.ProcStage
		Else	WOTask.ProcStage
*/

	/* Insert any missing Location Records */
	INSERT INTO Location
		(InvtID, SiteID, WhseLoc, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
		SELECT	DISTINCT INU.InvtID, INU.SiteID, WOMatlReq.Whseloc, @LUpd_Prog, @LUpd_User, GetDate(), @LUpd_Prog, @LUpd_User
		FROM	WOMatlReq (NOLOCK)

		JOIN 	WOHeader (NOLOCK)
		  ON 	WOMatlReq.WONbr = WOHeader.WONbr

		JOIN	LocTable
		  ON	LocTable.SiteID = WOMatlReq.SiteID
		 AND	LocTable.WhseLoc = WOMatlReq.WhseLoc
		 AND	LocTable.InclQtyAvail = 1

		LEFT JOIN WOTask (NOLOCK)
	  	  ON 	WOMatlReq.WONbr = WOTask.WONbr
	  	  AND 	WOMatlReq.Task = WOTask.Task

		JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = WOMatlReq.InvtID
		  AND 	INU.SiteID = WOMatlReq.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND 	INU.UpdateWODemand = 1

		WHERE	NOT EXISTS (SELECT *
					FROM	Location l
					WHERE	l.InvtID = INU.InvtID
					  AND 	l.SiteID = INU.SiteID
					  AND 	l.WhseLoc = WOMatlReq.WhseLoc)
		  AND 	WOHeader.Status <> 'P'				/* Not Purged */
		  AND 	((WOHeader.WOType <> 'P'			/* Not a Project Work Order */
				AND WOHeader.ProcStage IN ('R','F'))	/* Released or Firm Processing Stage */
			OR (WOHeader.WOType = 'P'			/* Project Work Order */
				AND WOTask.ProcStage IN ('R','F')))	/* Released or Firm Processing Stage */
		  AND	WOMatlReq.QtyRemaining > 0

	/* Update the Quantity Work Order Released Demand value into Location by InvtID, SiteID and WhseLoc. */
	UPDATE	Location
	SET	QtyWORlsedDemand = Coalesce(D.Qty_RD,0),			/* Quantity Work Order Released Demand */
		S4Future03 = Coalesce(D.Qty_FM,0),				/* Quantity Work Order Firm Demand */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	FROM	Location

		JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = Location.InvtID
		  AND 	INU.SiteID = Location.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateWODemand = 1

		LEFT JOIN
			(SELECT	Round(Sum(CASE WHEN WOHeader.WOType <> 'P'			/* Not a Project Work Order */
			  		AND WOHeader.ProcStage = 'R'			        /* Released Processing Stage */
			  	                    OR WOHeader.WOType = 'P'			/* Project Work Order */
					AND WOTask.ProcStage = 'R' THEN
					WOMatlReq.QtyRemaining ELSE 0 END), @DecPlQty) AS Qty_RD,
				Round(Sum(CASE WHEN WOHeader.WOType <> 'P'			/* Not a Project Work Order */
			  		AND WOHeader.ProcStage = 'F'			        /* Firm Processing Stage */
			  	                    OR WOHeader.WOType = 'P'			/* Project Work Order */
					AND WOTask.ProcStage = 'F' THEN
					WOMatlReq.QtyRemaining ELSE 0 END), @DecPlQty) AS Qty_FM,
				WOMatlReq.WhseLoc, WOMatlReq.InvtID,WOMatlReq.SiteID
			FROM	WOMatlReq (NOLOCK)

			JOIN 	WOHeader (NOLOCK)
			  ON 	WOMatlReq.WONbr = WOHeader.WONbr

			JOIN	LocTable
			  ON	LocTable.SiteID = WOMatlReq.SiteID
			 AND	LocTable.WhseLoc = WOMatlReq.WhseLoc
			 AND	LocTable.InclQtyAvail = 1

			LEFT JOIN WOTask (NoLock)
			  ON 	WOMatlReq.WONbr = WOTask.WONbr
			  AND 	WOMatlReq.Task = WOTask.Task

			JOIN	INUpdateQty_Wrk INU (NOLOCK)
			  ON 	INU.InvtID = WOMatlReq.InvtID
			  AND 	INU.SiteID = WOMatlReq.SiteID
			  AND	INU.ComputerName + '' LIKE @ComputerName
			  AND 	INU.UpdateWODemand = 1

			WHERE	WOHeader.Status <> 'P'				/* Not Purged */
			  AND 	((WOHeader.WOType <> 'P'			/* Not a Project Work Order */
			  		AND WOHeader.ProcStage IN ('R','F'))	/* Released or Firm Processing Stage */
			  	OR (WOHeader.WOType = 'P'			/* Project Work Order */
					AND WOTask.ProcStage IN ('R','F')))	/* Released or Firm Processing Stage */
			  AND	WOMatlReq.QtyRemaining > 0

			GROUP BY WOMatlReq.WhseLoc, WOMatlReq.InvtID,WOMatlReq.SiteID) AS D

		  ON 	D.WhseLoc = Location.WhseLoc
		  AND 	D.InvtId = INU.InvtID
		  AND 	D.SiteID = INU.SiteID

	/* Update the Quantity Work Order Released Demand value into ItemSite by InvtID and SiteID */
	UPDATE	ItemSite
	SET	QtyWORlsedDemand = Coalesce(D.Qty_RD, 0),			/* Quantity Work Order Released Demand */
		QtyWOFirmDemand = Coalesce(D.Qty_FM, 0),			/* Quantity Work Order Released Demand */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	FROM	ItemSite

		JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = ItemSite.InvtID
		  AND 	INU.SiteID = ItemSite.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateWODemand = 1

		LEFT JOIN
			(SELECT	ROUND(SUM(Location.QtyWORlsedDemand), @DecPlQty) AS Qty_RD,
				ROUND(SUM(Location.S4Future03), @DecPlQty) AS Qty_FM,
				InvtID, SiteID
			FROM	Location (NOLOCK)
			GROUP BY InvtID, SiteID) AS D
		  ON 	D.InvtID = INU.InvtID					/* Inventory ID */
		  AND 	D.SiteID = INU.SiteID					/* Site ID */

	/* Insert any missing LotSerMst Records */
	INSERT INTO LotSerMst
		(InvtID, SiteID, WhseLoc, LotSerNbr, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
		SELECT	DISTINCT INU.InvtID, INU.SiteID,
			WOLotSerT.Whseloc, WOLotSerT.LotSerNbr,
			@LUpd_Prog, @LUpd_User, GetDate(), @LUpd_Prog, @LUpd_User
		FROM	WOLotSerT (NOLOCK)

		JOIN 	WOHeader (NOLOCK)
		  ON 	WOLotSerT.WONbr = WOHeader.WONbr

		JOIN	LocTable
		  ON	LocTable.SiteID = WOLotSerT.SiteID
		 AND	LocTable.WhseLoc = WOLotSerT.WhseLoc
		 AND	LocTable.InclQtyAvail = 1

		LEFT JOIN WOTask (NOLOCK)
	  	  ON 	WOLotSerT.WONbr = WOTask.WONbr
	  	  AND 	WOLotSerT.TaskID = WOTask.Task

		JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = WOLotSerT.InvtID
		  AND 	INU.SiteID = WOLotSerT.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND 	INU.UpdateWODemand = 1

		WHERE	NOT EXISTS (SELECT *
					FROM	LotSerMst l
					WHERE	l.InvtID = INU.InvtID
					  AND 	l.SiteID = INU.SiteID
					  AND 	l.WhseLoc = WOLotSerT.WhseLoc
					  AND	l.LotSerNbr = WOLotSerT.LotSerNbr)

		  AND 	WOHeader.Status <> 'P'				/* Not Purged */
		  AND 	((WOHeader.WOType <> 'P'			/* Not a Project Work Order */
				AND WOHeader.ProcStage = 'R')		/* Released Processing Stage */
			OR (WOHeader.WOType = 'P'			/* Project Work Order */
				AND WOTask.ProcStage = 'R'))		/* Released Processing Stage */
		  AND	(WOLotSerT.Status IN ('A','E'))			/* Active, not Released */

	/* Update the Quantity Work Order Released Demand value into LotSerMst by InvtID, LotSerNbr, SiteID and WhseLoc. */
	UPDATE	LotSerMst
	SET	QtyWORlsedDemand = Coalesce(D.Qty_RD,0),			/* Quantity Work Order Released Demand */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	FROM	LotSerMst

		JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = LotSerMst.InvtID
		  AND 	INU.SiteID = LotSerMst.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateWODemand = 1

		JOIN	Inventory (NOLOCK)
		  ON 	INU.InvtID = Inventory.InvtID
		 AND	Inventory.LotSerTrack IN ('LI','SI')
		 AND 	Inventory.SerAssign = 'R'

		LEFT JOIN
			(SELECT	Round(Sum(WOLotSerT.Qty), @DecPlQty) AS Qty_RD,
				WOLotSerT.WhseLoc, WOLotSerT.InvtID, WOLotSerT.SiteID, WOLotSerT.LotSerNbr
			FROM	WOLotSerT (NOLOCK)

			JOIN 	WOHeader (NOLOCK)
			  ON 	WOLotSerT.WONbr = WOHeader.WONbr

			JOIN	LocTable
			  ON	LocTable.SiteID = WOLotSerT.SiteID
			 AND	LocTable.WhseLoc = WOLotSerT.WhseLoc
			 AND	LocTable.InclQtyAvail = 1

			LEFT JOIN WOTask (NoLock)
			  ON 	WOLotSerT.WONbr = WOTask.WONbr
			  AND 	WOLotSerT.TaskID = WOTask.Task

			WHERE	WOHeader.Status <> 'P'				/* Not Purged */
			  AND 	((WOHeader.WOType <> 'P'			/* Not a Project Work Order */
			  		AND WOHeader.ProcStage = 'R')		/* Released Processing Stage */
			  	OR (WOHeader.WOType = 'P'			/* Project Work Order */
					AND WOTask.ProcStage = 'R'))		/* Released Processing Stage */
			  AND	(WOLotSerT.Status IN ('A','E'))			/* Active, not Released */
			GROUP BY WOLotSerT.WhseLoc, WOLotSerT.InvtID, WOLotSerT.SiteID, WOLotSerT.LotSerNbr) AS D

		  ON 	D.WhseLoc = LotSerMst.WhseLoc
		  AND 	D.InvtId = INU.InvtID
		  AND 	D.SiteID = INU.SiteID
		  AND	D.LotSerNbr = LotSerMst.LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_WODemand] TO [MSDSL]
    AS [dbo];

