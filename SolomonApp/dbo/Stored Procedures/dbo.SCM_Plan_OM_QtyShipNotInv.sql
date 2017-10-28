 CREATE PROCEDURE SCM_Plan_OM_QtyShipNotInv
	@ComputerName	VarChar(21),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@DecPlQty	SmallInt
As
	SET NOCOUNT ON

    DECLARE @PCInstalled CHAR(1)

    SELECT @PCInstalled = p.S4Future3
      FROM PCSetup p WITH(NOLOCK)

	SELECT	SOShipLot.WhseLoc AS WhseLoc,
		INU.InvtID AS InvtID,
		INU.SiteID AS SiteID,
		CASE WHEN SOShipLine.CnvFact In (0, 1) THEN
			Round(SOShipLot.QtyShip, @DecPlQty)
		ELSE
			CASE WHEN SOShipLine.UnitMultDiv = 'D' THEN
				Round(SOShipLot.QtyShip / SOShipLine.CnvFact, @DecPlQty)
			ELSE
				Round(SOShipLot.QtyShip * SOShipLine.CnvFact, @DecPlQty)
			END
		END AS QtyShipNotInv,
		SOShipLot.LotSerNbr AS LotSerNbr,
		SOShipLot.S4Future01 AS SpecificCostID

	INTO #Temp_OM_QtyShipNotInv_DataSet

	FROM	SOShipHeader (NOLOCK)

	JOIN SOShipLine (NOLOCK)
	  ON 	SOShipLine.CpnyID = SOShipHeader.CpnyID
	  AND 	SOShipLine.ShipperID = SOShipHeader.ShipperID

	JOIN SOShipLot (NOLOCK)
	  ON 	SOShipLine.CpnyID = SOShipLot.CpnyID
	  AND	SOShipLine.ShipperID = SOShipLot.ShipperID
	  AND	SOShipLine.LineRef = SOShipLot.LineRef

	JOIN SOType (NOLOCK)
	  ON 	SOShipHeader.CpnyID = SOType.CpnyID
	  AND 	SOShipHeader.SOTypeID = SOType.SOTypeID

	JOIN INUpdateQty_Wrk INU (NOLOCK)
	  ON 	INU.InvtID = SOShipLine.InvtID
	  AND 	INU.SiteID = SOShipLine.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

	WHERE	SOShipHeader.Status = 'C'			/* Complete */
	  AND 	SOShipHeader.Cancelled = 0			/* Not Cancelled */
	  AND 	(SOShipHeader.DropShip = 0 OR 			/* Not Drop Ship or Drop Ship and AutoPO */
			Coalesce((SELECT TOP 1 os.AutoPO
				FROM 	SOShipSched ss

				INNER LOOP
				JOIN 	SOSched os
				  ON	ss.CpnyID = os.CpnyID
				  AND	ss.OrdNbr = os.OrdNbr
				  AND	ss.OrdLineRef = os.LineRef
				  AND	ss.OrdSchedRef = os.SchedRef

				WHERE	ss.CpnyID = SOShipLine.CpnyID
				  AND	ss.ShipperID = SOShipLine.ShipperID
				  AND	ss.ShipperLineRef = SOShipLine.LineRef), 0) = 1)

	  AND 	SOShipHeader.ShipRegisterID = ''			/* Not Journallized */
	  AND 	SOShipHeader.INBatNbr = ''			/* IN Batch hasn't been created. */
	  AND 	SOShipHeader.ARBatNbr = ''			/* AR Batch hasn't been created. */
	  AND 	Round(SOShipLot.QtyShip, @DecPlQty) > 0		/* Some Quantity has Shipped */
	  AND 	SOType.Behavior NOT IN ('CM', 'DM', 'SHIP')	/* Sales Order Type Not Allowed */

	/* Insert any missing Location Records */
	INSERT INTO Location
		(InvtID, SiteID, WhseLoc, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
		SELECT DISTINCT InvtID, SiteID, WhseLoc, @LUpd_Prog, @LUpd_User, GetDate(), @LUpd_Prog, @LUpd_User
		FROM 	#Temp_OM_QtyShipNotInv_DataSet TDataSet
		WHERE 	NOT EXISTS (SELECT *
			 		FROM	Location l
					WHERE	l.InvtID = TDataSet.InvtID
				  	AND 	l.SiteID = TDataSet.SiteID
				  	AND 	l.WhseLoc = TDataSet.WhseLoc)

	/* Insert any missing LotSerMst Records */
	INSERT INTO LotSerMst
		(InvtID, SiteID, WhseLoc, LotSerNbr, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
		SELECT DISTINCT InvtID, SiteID, WhseLoc, LotSerNbr, @LUpd_Prog, @LUpd_User, GetDate(), @LUpd_Prog, @LUpd_User
		FROM 	#Temp_OM_QtyShipNotInv_DataSet TDataSet
		WHERE 	LotSerNbr <> ''
		  AND 	NOT EXISTS (SELECT *
					FROM LotSerMst LSM
					WHERE 	LSM.InvtID = TDataSet.InvtID
					  AND	LSM.SiteID = TDataSet.SiteID
					  AND	LSM.WhseLoc = TDataSet.WhseLoc
					  AND	LSM.LotSerNbr = TDataSet.LotSerNbr)

	/* Update Location Table */
	-- Clear Location records that have NO activity
	-- and recalculate Location records that do have activity
	UPDATE	Location
	SET	QtyShipNotInv = Coalesce(D.QtyShipNotInv, 0),	/* Quantity Shipped Not Invoiced */
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User

	FROM	Location WITH (INDEX(Location0)) 	-- Force Index for better performance

	JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON	INU.InvtID = Location.InvtID
	  AND	INU.SiteID = Location.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

	LEFT JOIN
		(SELECT	InvtID, SiteID, WhseLoc, Round(Sum(QtyShipNotInv), @DecPlQty) AS QtyShipNotInv

		FROM	#Temp_OM_QtyShipNotInv_DataSet (NOLOCK)

		GROUP BY InvtID, SiteID, WhseLoc) AS D

	  ON 	D.InvtID = INU.InvtID		/* Inventory ID */
	  AND 	D.SiteID = INU.SiteID		/* Site ID */
	  AND 	D.WhseLoc = Location.WhseLoc		/* Warehouse Bin Location */

	/* Update LotSerMst Table */
	-- Clear LotSerMst records that have NO activity
	-- and recalculate LotSerMst records that do have activity
	UPDATE	LotSerMst
	SET	QtyShipNotInv = Coalesce(D.QtyShipNotInv, 0),	/* Quantity Shipped Not Invoiced */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User

	FROM	LotSerMst

	JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON	INU.InvtID = LotSerMst.InvtID
	  AND	INU.SiteID = LotSerMst.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

	LEFT JOIN
		(SELECT	InvtID, SiteID, WhseLoc, LotSerNbr, Round(Sum(QtyShipNotInv), @DecPlQty) AS QtyShipNotInv

		FROM	#Temp_OM_QtyShipNotInv_DataSet (NOLOCK)

		GROUP BY InvtID, SiteID, WhseLoc, LotSerNbr) AS D

	  ON 	D.InvtID = INU.InvtID		/* Inventory ID */
	  AND 	D.SiteID = INU.SiteID		/* Site ID */
	  AND 	D.WhseLoc = LotSerMst.WhseLoc		/* Warehouse Bin Location */
	  AND 	D.LotSerNbr = LotSerMst.LotSerNbr	/* Lot/Serial Number */

    IF @PCInstalled = 'S'
    BEGIN
	   UPDATE Location
	      SET PrjINQtyShipNotInv = Coalesce(D.PrjINQtyShipNotInv, 0),	/* Quantity Shipped Not Invoiced Project Inventory*/
              LUpd_DateTime = GetDate(),
              LUpd_Prog = @LUpd_Prog,
              LUpd_User = @LUpd_User

         FROM Location JOIN INUpdateQty_Wrk INU (NOLOCK)
                         ON INU.InvtID = Location.InvtID
                        AND INU.SiteID = Location.SiteID
                        AND INU.ComputerName + '' LIKE @ComputerName
                        AND INU.UpdateSO = 1

                       LEFT JOIN (SELECT i.InvtID, i.SiteID, i.Whseloc,SUM(i.QtyAllocated) AS PrjINQtyShipNotInv
                                    FROM SOShipLine l JOIN SOShipHeader h
                                                        ON l.ShipperID = h.ShipperID
                                                       AND l.CpnyID = h.CpnyID
                                                      JOIN INPrjAllocation i
                                                        ON l.ShipperID = i.SrcNbr
                                                       AND l.LineRef = i.SrcLineRef
                                                       AND i.SrcType = 'SH'
                                                      LEFT JOIN INTran t
                                                        ON t.ShipperID = l.ShipperID
                                                       AND t.ShipperLineRef = l.LineRef
                                                       AND t.BatNbr = h.INBatNbr
                                  WHERE h.Shippingconfirmed = 1 
                                    AND (h.ShipRegisterID = ' ' OR t.Rlsed = 0)
                                  GROUP BY i.InvtID, i.SiteID, i.Whseloc) AS D
                        ON D.InvtID = INU.InvtID 
                       AND D.SiteID = INU.SiteID 
       WHERE Location.InvtID = INU.InvtID 
         AND Location.SiteID = INU.SiteID 
         AND Location.WhseLoc = D.Whseloc

	   UPDATE LotSerMst
	      SET PrjINQtyShipNotInv = Coalesce(D.PrjINQtyShipNotInv, 0),	/* Quantity Shipped Not Invoiced Project Inventory*/
              LUpd_DateTime = GetDate(),
              LUpd_Prog = @LUpd_Prog,
              LUpd_User = @LUpd_User

         FROM LotSerMst JOIN INUpdateQty_Wrk INU (NOLOCK)
                          ON INU.InvtID = LotSerMst.InvtID
                         AND INU.SiteID = LotSerMst.SiteID
                         AND INU.ComputerName + '' LIKE @ComputerName
                         AND INU.UpdateSO = 1

                        LEFT JOIN (SELECT i.InvtID, i.SiteID, i.WhseLoc, i.LotSerNbr,
                                          SUM(i.QtyAllocated) AS PrjINQtyShipNotInv
                                     FROM SOShipLine l JOIN SOShipHeader h
                                                         ON l.ShipperID = h.ShipperID
                                                        AND l.CpnyID = h.CpnyID

                                                       JOIN INPrjAllocationLot i
                                                         ON l.ShipperID = i.SrcNbr
                                                        AND l.LineRef = i.SrcLineRef
                                                        AND i.SrcType = 'SH'

                                                       LEFT JOIN INTran t
                                                         ON t.ShipperID = l.ShipperID
                                                        AND t.ShipperLineRef = l.LineRef
                                                        AND t.BatNbr = h.INBatNbr

                                    WHERE h.Shippingconfirmed = 1 
                                      AND (h.ShipRegisterID = ' ' OR t.Rlsed = 0)
                                    GROUP BY i.InvtID, i.SiteID, i.Whseloc, i.LotSerNbr) AS D
                          ON INU.InvtID = D.InvtID
                         AND INU.SiteID = D.SiteID

        WHERE LotSerMst.InvtID = D.InvtID
          AND LotSerMst.SiteID = D.SiteID
          AND LotSerMst.WhseLoc = D.Whseloc
          AND LotSerMst.LotSerNbr = D.LotSerNbr

    END


	/* Update ItemCost Table */
	-- Clear ItemCost records that have NO activity
	-- and recalculate ItemCost records that do have activity
	UPDATE	ItemCost
	SET	S4Future03 = Coalesce(D.QtyShipNotInv, 0),	/* Quantity Shipped Not Invoiced */
-- R4.50	QtyShipNotInv = Round(QtyShipNotInv
-- R4.50	 + @QtyShipNotInv, @DecPlQty),			/* Quantity Shipped Not Invoiced */
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
		FROM	ItemCost
		JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON	INU.InvtID = ItemCost.InvtID
	  AND	INU.SiteID = ItemCost.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

	LEFT JOIN
		(SELECT	InvtID, SiteID, SpecificCostID, Round(Sum(QtyShipNotInv), @DecPlQty) AS QtyShipNotInv

		FROM	#Temp_OM_QtyShipNotInv_DataSet (NOLOCK)

		GROUP BY InvtID, SiteID, SpecificCostID) AS D

	  ON 	D.InvtID = INU.InvtID			/* Inventory ID */
	  AND 	D.SiteID = INU.SiteID			/* Site ID */
	  AND 	D.SpecificCostID = ItemCost.SpecificCostID	/* Specific Cost Identity */

	WHERE	ItemCost.LayerType = 'S'			/* LayerType - Standard */


