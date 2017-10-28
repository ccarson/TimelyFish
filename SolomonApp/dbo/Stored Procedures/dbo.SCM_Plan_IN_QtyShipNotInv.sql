 CREATE	PROCEDURE SCM_Plan_IN_QtyShipNotInv
	@ComputerName	VarChar(21),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@DecPlQty	SmallInt
AS
	SET NOCOUNT ON
		SELECT INTran.InvtID, INTran.SiteID, INTran.WhseLoc, LotSerT.LotSerNbr, INTran.SpecificCostID,
		CASE WHEN INTran.CnvFact In (0, 1) THEN
			Round(INTran.Qty * INTran.InvtMult * -1, @DecPlQty)
		ELSE
			CASE WHEN INTran.UnitMultDiv = 'D' THEN
				Round((INTran.Qty * INTran.InvtMult * -1) / INTran.CnvFact, @DecPlQty)
			ELSE
				Round((INTran.Qty * INTran.InvtMult * -1) * INTran.CnvFact, @DecPlQty)
			END
		END AS QtyShipNotInv

	INTO #Temp_IN_QtyShipNotInv_DataSet

	FROM INTran (NOLOCK)

	JOIN INUpdateQty_Wrk INU (NOLOCK)
	  ON 	INU.InvtID = INTran.InvtID
	  AND 	INU.SiteID = INTran.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

	LEFT JOIN LotSerT (NOLOCK)
	  ON 	LotSerT.CpnyID = INTran.CpnyID
	  AND 	LotSerT.BatNbr = INTran.BatNbr
	  AND 	LotSerT.INTranLineRef = INTran.LineRef
	  AND 	LotSerT.SiteID = INTran.SiteID
	  AND 	LotSerT.TranType = INTran.TranType

	WHERE	INTran.Rlsed = 0				/* Not Released */
	  AND 	INTran.JrnlType = 'OM'				/* Create By Order Management */
	  AND 	INTran.Crtd_Prog NOT LIKE 'SD%'
	  AND 	INTran.S4Future09 = 0				/* Transaction will change Inventory */
	  AND 	(INTran.Qty * INTran.InvtMult) < 0		/* Reduce Inventory */
			AND (INTran.TranType In ('IN', 'TR')	/* Invoice Or Transfer */
		OR (INTran.TranType = 'AS'			/* Kit Assembly */
			AND INTran.KitID = ''))			/* Kit Component */

	/* Insert any missing Location Records */
	INSERT INTO Location
		(InvtID, SiteID, WhseLoc, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
		SELECT DISTINCT InvtID, SiteID, WhseLoc, @LUpd_Prog, @LUpd_User, GetDate(), @LUpd_Prog, @LUpd_User
		FROM 	#Temp_IN_QtyShipNotInv_DataSet TDataSet
		WHERE 	NOT EXISTS (SELECT *
			 		FROM	Location l
					WHERE	l.InvtID = TDataSet.InvtID
				  	AND 	l.SiteID = TDataSet.SiteID
				  	AND 	l.WhseLoc = TDataSet.WhseLoc)

	/* Insert any missing LotSerMst Records */
	INSERT INTO LotSerMst
		(InvtID, SiteID, WhseLoc, LotSerNbr, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
		SELECT DISTINCT InvtID, SiteID, WhseLoc, LotSerNbr, @LUpd_Prog, @LUpd_User, GetDate(), @LUpd_Prog, @LUpd_User
		FROM #Temp_IN_QtyShipNotInv_DataSet TDataSet
		WHERE 	TDataSet.LotSerNbr IS NOT NULL
		   AND	NOT EXISTS (SELECT *
					FROM LotSerMst LSM
					WHERE 	LSM.InvtID = TDataSet.InvtID
					  AND	LSM.SiteID = TDataSet.SiteID
					  AND	LSM.WhseLoc = TDataSet.WhseLoc
					  AND	LSM.LotSerNbr = TDataSet.LotSerNbr)

	/* Update Location Table */
	-- Append to Location records that do have INTran activity.
	-- Note: The stored procedure SCM_Plan_IN_QtyShipNotInv has
	--       already taken care of Location records with NO activity.
	UPDATE	Location
	SET	QtyShipNotInv = Round(Location.QtyShipNotInv + D.QtyShipNotInv, @DecPlQty),	/* Quantity Shipped Not Invoiced */
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
		FROM	Location WITH (INDEX(Location0)) 	-- Force Index for better performance

	JOIN	(SELECT InvtID, SiteID, WhseLoc, Round(Sum(QtyShipNotInv), @DecPlQty) AS QtyShipNotInv

		FROM 	#Temp_IN_QtyShipNotInv_DataSet (NOLOCK)

		GROUP BY InvtID, SiteID, WhseLoc) AS D

	  ON	D.InvtID = Location.InvtID
	  AND	D.SiteID = Location.SiteID
	  AND	D.WhseLoc = Location.WhseLoc

	/* Update LotSerMst Table */
	-- Append to LotSerMst records that do have INTran activity.
	-- Note: The stored procedure SCM_Plan_IN_QtyShipNotInv has
	--       already taken care of LotSerMst records with NO activity.
	UPDATE	LotSerMst
	SET	QtyShipNotInv = Round(LotSerMst.QtyShipNotInv + D.QtyShipNotInv, @DecPlQty),	/* Quantity Shipped Not Invoiced */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	FROM LotSerMst
		JOIN	(SELECT InvtID, SiteID, WhseLoc, LotSerNbr, Round(Sum(QtyShipNotInv), @DecPlQty) AS QtyShipNotInv

		FROM 	#Temp_IN_QtyShipNotInv_DataSet (NOLOCK)

		-- When #Temp_IN_QtyShipNotInv_DataSet was created, LotSerT was the right table
		-- on a LEFT OUTER JOIN.  We are only interested in records in LotSerT which
		-- satisfied the join.  LotSerNbr data column values comes from LotSerT.
		-- Bottom Line: LotSerNbr IS NULL when join failed.
		--              LotSerNbr IS NOT NULL when join succeeded.
		WHERE LotSerNbr IS NOT NULL

		GROUP BY InvtID, SiteID, WhseLoc, LotSerNbr) AS D

	  ON	D.InvtID = LotSerMst.InvtID
	  AND	D.SiteID = LotSerMst.SiteID
	  AND	D.WhseLoc = LotSerMst.WhseLoc
	  AND	D.LotSerNbr = LotSerMst.LotSerNbr
		/* Update ItemCost Table */
	-- Append to ItemCost records that have INTran activity.
	-- Note: The stored procedure SCM_Plan_IN_QtyShipNotInv has
	--       already taken care of ItemCost records with NO activity
	--	 and OM related activity.
	UPDATE	ItemCost
	SET	S4Future03 = ROUND(ItemCost.S4Future03 + D.QtyShipNotInv, @DecPlQty),		/* Quantity Shipped Not Invoiced */
	--	QtyShipNotInv = Round(IC.QtyShipNotInv		-- R4.50
	--		+ v1.QtyShipNotInv, @DecPlQty),	--R4.50	/* Quantity Shipped Not Invoiced */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
		FROM	ItemCost
		JOIN	(SELECT	SpecificCostID, InvtID, SiteID, Round(Sum(QtyShipNotInv), @DecPlQty) AS QtyShipNotInv

		FROM 	#Temp_IN_QtyShipNotInv_DataSet (NOLOCK)

		GROUP BY InvtID, SiteID, SpecificCostID) AS D

	  ON 	D.InvtID = ItemCost.InvtID			/* Inventory ID */
	  AND 	D.SiteID = ItemCost.SiteID			/* Site ID */
	  And 	D.SpecificCostID = ItemCost.SpecificCostID	/* Specific Cost Identity */
		WHERE ItemCost.LayerType = 'S'			/* LayerType - Standard */



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_IN_QtyShipNotInv] TO [MSDSL]
    AS [dbo];

