 CREATE PROCEDURE SCM_Plan_QtyAlloc
	@ComputerName	VarChar(21),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@DecPlQty	SmallInt
AS
	SET NOCOUNT ON

	/*
	This procedure will calculate and update the Quantity Allocated for the supplied Inventory ID
	and Site ID for the Location and LotSerMst tables.
	*/

    DECLARE @PCInstalled CHAR(1)

    SELECT @PCInstalled = p.S4Future3
      FROM PCSetup p WITH(NOLOCK)

	/* Insert any missing Location Records */
	INSERT INTO Location
		(InvtID, SiteID, WhseLoc, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
		SELECT DISTINCT SOPlan.InvtID, SOPlan.SiteID, SOShipLot.WhseLoc, @LUpd_Prog, @LUpd_User, GetDate(), @LUpd_Prog, @LUpd_User

		FROM	SOPlan (NOLOCK)

		JOIN 	SOShipLot WITH (NOLOCK)
		  ON 	SOPlan.CpnyID = SOShipLot.CpnyID
		  AND 	SOPlan.SOShipperID = SOShipLot.ShipperID
		  AND 	SOPlan.SOShipperLineRef = SOShipLot.LineRef
			JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = SOPlan.InvtID
		  AND 	INU.SiteID = SOPlan.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateSO = 1

		WHERE	SOPlan.PlanType IN ('30', '32', '34')
		  AND	SOShipLot.WhseLoc <> ''
		  AND 	NOT EXISTS (SELECT *
			 		FROM	Location l (NOLOCK)
					WHERE	l.InvtID = SOPlan.InvtID
				  	AND 	l.SiteID = SOPlan.SiteID
				  	AND 	l.WhseLoc = SOShipLot.WhseLoc)

	/* Insert any missing LotSerMst Records */
	INSERT INTO LotSerMst
		(InvtID, SiteID, WhseLoc, LotSerNbr, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
		SELECT DISTINCT SOPlan.InvtID, SOPlan.SiteID, SOShipLot.WhseLoc, SOShipLot.LotSerNbr, @LUpd_Prog, @LUpd_User, GetDate(), @LUpd_Prog, @LUpd_User

		FROM	SOPlan (NOLOCK)

		JOIN 	SOShipLot WITH(NOLOCK)
		  ON 	SOPlan.CpnyID = SOShipLot.CpnyID
		  AND 	SOPlan.SOShipperID = SOShipLot.ShipperID
		  AND 	SOPlan.SOShipperLineRef = SOShipLot.LineRef
			JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = SOPlan.InvtID
		  AND 	INU.SiteID = SOPlan.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateSO = 1

		WHERE	SOPlan.PlanType IN ('30', '32', '34')
		  AND	SOShipLot.WhseLoc <> ''
		  AND	SOShipLot.LotSerNbr <> ''
		  AND 	NOT EXISTS (SELECT *
					FROM LotSerMst LSM (NOLOCK)
					WHERE 	LSM.InvtID = SOPlan.InvtID
					  AND	LSM.SiteID = SOPlan.SiteID
					  AND	LSM.WhseLoc = SOShipLot.WhseLoc
					  AND	LSM.LotSerNbr = SOShipLot.LotSerNbr)
		/* Update Location Table */
	-- Clear Location records that have NO activity
	-- and recalculate Location records that do have activity
	UPDATE	Location
	SET	QtyAlloc = Coalesce(D.QtyAlloc, 0),	/* Quantity Allocated */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
		FROM	Location (NOLOCK)

	JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON	INU.InvtID = Location.InvtID
	  AND	INU.SiteID = Location.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1
		LEFT JOIN
		-- SOShipLine.CnvFact = SOShipLot.S4Future03
		-- SOShipLine.UnitMultDiv = SOShipLot.S4Future11
		(SELECT SOPlan.InvtID, SOPlan.SiteID, SOShipLot.WhseLoc,
			ROUND(SUM(CASE WHEN SOShipLot.S4Future03 = 0 THEN
				0
			ELSE
				CASE WHEN SOShipLot.S4Future11 = 'D' THEN
					ROUND(SOShipLot.Qtyship / SOShipLot.S4Future03, @DecPlQty)
				ELSE
					ROUND(SOShipLot.QtyShip * SOShipLot.S4Future03, @DecPlQty)
				END
			END), @DecPlQty) AS QtyAlloc

		FROM	(SELECT InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef FROM SOPlan (NOLOCK) GROUP BY InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef) SOPlan
			JOIN 	SOShipLot WITH(NOLOCK)
		  ON 	SOPlan.CpnyID = SOShipLot.CpnyID
		  AND 	SOPlan.SOShipperID = SOShipLot.ShipperID
		  AND 	SOPlan.SOShipperLineRef = SOShipLot.LineRef
			JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = SOPlan.InvtID
		  AND 	INU.SiteID = SOPlan.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateSO = 1
			WHERE	SOPlan.PlanType IN ('30', '32', '34')
		  AND	SOShipLot.WhseLoc <> ''

		GROUP BY SOPlan.InvtID, SOPlan.SiteID, SOShipLot.WhseLoc) AS D

	  ON 	D.InvtID = INU.InvtID		/* Inventory ID */
	  AND 	D.SiteID = INU.SiteID		/* Site ID */
	  AND 	D.WhseLoc = Location.WhseLoc		/* Warehouse Bin Location */
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

      --Update for Project Allocated Inventory being consumed
      IF @PCInstalled = 'S'
        BEGIN
          UPDATE Location
             SET PrjINQtyAlloc = Coalesce(D.QtyAlloc, 0),	/* Quantity Allocated */
                 LUpd_DateTime = GetDate(),
                 LUpd_Prog = @LUpd_Prog,
                 LUpd_User = @LUpd_User
            FROM	Location WITH(NOLOCK) JOIN INUpdateQty_Wrk INU (NOLOCK)
                                          ON INU.InvtID = Location.InvtID
                                         AND INU.SiteID = Location.SiteID
                                         AND INU.ComputerName + '' LIKE @ComputerName
                                         AND INU.UpdateSO = 1
                                        LEFT JOIN (SELECT SOPlan.InvtID, SOPlan.SiteID, INPrjAllocation.WhseLoc,
		      	                                        ROUND(sum(INPrjAllocation.QtyAllocated), @DecPlQty) AS QtyAlloc
		                                             FROM	(SELECT InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef 
                                                             FROM SOPlan (NOLOCK) 
                                                            GROUP BY InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef) SOPlan
                                                      JOIN INPrjAllocation WITH(NOLOCK)
                                                        ON INPrjAllocation.CpnyID = SOPlan.CpnyID
                                                       AND INPrjAllocation.SrcNbr = SOPlan.SOShipperID
                                                       AND INPrjAllocation.SrcLineRef = SOPlan.SOShipperLineRef
                                                       AND INPrjAllocation.SrcType = 'SH'
                                                       AND INPrjAllocation.WhseLoc <> ''
                                                      JOIN INUpdateQty_Wrk INU (NOLOCK)
                                                        ON INU.InvtID = SOPlan.InvtID
                                                       AND INU.SiteID = SOPlan.SiteID
                                                       AND INU.ComputerName + '' LIKE @ComputerName
                                                       AND INU.UpdateSO = 1
                                                     WHERE SOPlan.PlanType IN ('30', '32', '34')
                                                       AND INPrjAllocation.WhseLoc <> ''
                                                     GROUP BY SOPlan.InvtID, SOPlan.SiteID, INPrjAllocation.WhseLoc) AS D
                                        ON D.InvtID = INU.InvtID		/* Inventory ID */
                                       AND D.SiteID = INU.SiteID		/* Site ID */
                                       AND D.WhseLoc = Location.WhseLoc		/* Warehouse Bin Location */
                                       AND INU.ComputerName + '' LIKE @ComputerName
                                       AND INU.UpdateSO = 1

      END

	update	Location
	set	QtyAllocSO = Coalesce(D.QtyAlloc, 0),
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User

	from	Location

	join	INUpdateQty_Wrk INU (NOLOCK)
	  ON	INU.InvtID = Location.InvtID
	  AND	INU.SiteID = Location.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

	left join (	select	SOPlan.InvtID,
			SOPlan.SiteID,
			SOLot.WhseLoc,
			sum(	case when SOLine.UnitMultDiv = 'D' then
					case when SOLine.CnvFact <> 0 then
						round(SOLot.QtyShip / SOLine.CnvFact, @DecPlQty)
					else
						0
					end
				else
					round(SOLot.QtyShip * SOLine.CnvFact, @DecPlQty)
				end) as QtyAlloc

		from	SOPlan

		JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = SOPlan.InvtID
		  AND 	INU.SiteID = SOPlan.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateSO = 1
			join	SOLine
		on	SOLine.CpnyID = SOPlan.CpnyID
		and	SOLine.OrdNbr = SOPlan.SOOrdNbr
		and	SOLine.LineRef = SOPlan.SOLineRef

		join	SOLot
		on	SOLot.CpnyID = SOPlan.CpnyID
		and	SOLot.OrdNbr = SOPlan.SOOrdNbr
		and	SOLot.LineRef = SOPlan.SOLineRef
		and	SOLot.SchedRef = SOPlan.SOSchedRef

		where	SOPlan.PlanType in ('60', '61')	-- Order
		and	SOLot.Status = 'O'
		and	SOLot.WhseLoc <> ''

		group by SOPlan.InvtID, SOPlan.SiteID, SOLot.WhseLoc) as D

	on	D.InvtID = Location.InvtID
	and	D.SiteID = Location.SiteID
	and	D.WhseLoc = Location.WhseLoc

    IF @PCInstalled = 'S'
        BEGIN
          UPDATE Location
             SET PrjINQtyAllocSO = Coalesce(D.PrjINQtyAllocSO, 0),	/* Quantity Allocated */
                 LUpd_DateTime = GetDate(),
                 LUpd_Prog = @LUpd_Prog,
                 LUpd_User = @LUpd_User
            FROM	Location WITH(NOLOCK) JOIN INUpdateQty_Wrk INU (NOLOCK)
                                          ON INU.InvtID = Location.InvtID
                                         AND INU.SiteID = Location.SiteID
                                         AND INU.ComputerName + '' LIKE @ComputerName
                                         AND INU.UpdateSO = 1
                                        LEFT JOIN (SELECT SOPlan.InvtID, SOPlan.SiteID, INPrjAllocation.WhseLoc,
		      	                                        ROUND(sum(INPrjAllocation.QtyAllocated), @DecPlQty) AS PrjINQtyAllocSO
		                                             FROM	(SELECT InvtID, SiteID, PlanType, CpnyID, SOOrdNbr, SOLineRef 
                                                             FROM SOPlan (NOLOCK) 
                                                            GROUP BY InvtID, SiteID, PlanType, CpnyID, SOOrdNbr, SOLineRef) SOPlan
                                                      JOIN INPrjAllocation WITH(NOLOCK)
                                                        ON INPrjAllocation.CpnyID = SOPlan.CpnyID
                                                       AND INPrjAllocation.SrcNbr = SOPlan.SOOrdNbr
                                                       AND INPrjAllocation.SrcLineRef = SOPlan.SOLineRef
                                                       AND INPrjAllocation.SrcType = 'SO'
                                                       AND INPrjAllocation.Whseloc <> ' '
                                                      JOIN INUpdateQty_Wrk INU (NOLOCK)
                                                        ON INU.InvtID = SOPlan.InvtID
                                                       AND INU.SiteID = SOPlan.SiteID
                                                       AND INU.ComputerName + '' LIKE @ComputerName
                                                       AND INU.UpdateSO = 1
                                                     WHERE SOPlan.PlanType IN ('60', '61')	-- Order
                                                       AND INPrjAllocation.WhseLoc <> ' '
                                                     GROUP BY SOPlan.InvtID, SOPlan.SiteID, INPrjAllocation.WhseLoc) AS D
                                        ON D.InvtID = INU.InvtID		/* Inventory ID */
                                       AND D.SiteID = INU.SiteID		/* Site ID */
                                       AND D.WhseLoc = Location.WhseLoc		/* Warehouse Bin Location */
                                       AND INU.ComputerName + '' LIKE @ComputerName

    END

	/* Update LotSerMst Table */
	-- Clear LotSerMst records that have NO activity
	-- and recalculate LotSerMst records that do have activity
	UPDATE	LotSerMst
	SET	QtyAlloc = Coalesce(D.QtyAlloc, 0),	/* Quantity Allocated */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
		FROM	LotSerMst (NOLOCK)
		JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON	INU.InvtID = LotSerMst.InvtID
	  AND	INU.SiteID = LotSerMst.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

	LEFT JOIN
		-- SOShipLine.CnvFact = SOShipLot.S4Future03
		-- SOShipLine.UnitMultDiv = SOShipLot.S4Future11
		(SELECT SOPlan.InvtID, SOPlan.SiteID, SOShipLot.WhseLoc, SOShipLot.LotSerNbr,
			ROUND(SUM(CASE WHEN SOShipLot.S4Future03 = 0 THEN
				0
			ELSE
				CASE WHEN SOShipLot.S4Future11 = 'D' THEN
					ROUND(SOShipLot.Qtyship / SOShipLot.S4Future03, @DecPlQty)
				ELSE
					ROUND(SOShipLot.QtyShip * SOShipLot.S4Future03, @DecPlQty)
				END
			END), @DecPlQty) AS QtyAlloc

		FROM	(SELECT InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef FROM SOPlan (NOLOCK) GROUP BY InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef) SOPlan
			JOIN 	SOShipLot WITH(NOLOCK)
		  ON 	SOPlan.CpnyID = SOShipLot.CpnyID
		  AND 	SOPlan.SOShipperID = SOShipLot.ShipperID
		  AND 	SOPlan.SOShipperLineRef = SOShipLot.LineRef
			JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = SOPlan.InvtID
		  AND 	INU.SiteID = SOPlan.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateSO = 1
			WHERE	SOPlan.PlanType IN ('30', '32', '34')
		  AND	SOShipLot.WhseLoc <> ''
		  AND 	SOShipLot.LotSerNbr <> ''

		GROUP BY SOPlan.InvtID, SOPlan.SiteID, SOShipLot.WhseLoc, SOShipLot.LotSerNbr) AS D

	  ON 	D.InvtID = INU.InvtID		/* Inventory ID */
	  AND 	D.SiteID = INU.SiteID		/* Site ID */
	  AND 	D.WhseLoc = LotSerMst.WhseLoc		/* Warehouse Bin Location */
	  AND 	D.LotSerNbr = LotSerMst.LotSerNbr	/* Lot/Serial Number */

      IF @PCInstalled = 'S'
        BEGIN
          UPDATE LotSerMst
             SET PrjINQtyAlloc = COALESCE(D.PrjINQtyAlloc,0),
                 LUpd_DateTime = GetDate(),
                 LUpd_Prog = @LUpd_Prog,
                 LUpd_User = @LUpd_User
            FROM LotSerMst JOIN INUpdateQty_Wrk INU WITH(NOLOCK)
                             ON INU.InvtID = LotSerMst.InvtID
                            AND INU.SiteID = LotSerMst.SiteID
                            AND INU.ComputerName + '' LIKE @ComputerName
                            AND INU.UpdateSO = 1

                           LEFT JOIN (SELECT SOPlan.InvtID,
                                        i.LotSerNbr,
                                        SOPlan.SiteID,
                                        i.WhseLoc,
                                        Sum(i.QtyAllocated) as PrjINQtyAlloc
                                   FROM (SELECT InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef
                                           FROM SOPlan s WITH(NOLOCK)
                                          GROUP BY InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef) SOPlan
  
                                        JOIN INPrjAllocationLot i WITH(NOLOCK)
                                          on i.CpnyID = SOPlan.CpnyID
                                         AND i.SrcNbr = SOPlan.SOShipperID
                                         AND i.SrcLineRef = SOPlan.SOShipperLineRef
                                         AND i.SrcType = 'SH'

                                        JOIN INUpdateQty_Wrk INU (NOLOCK)
                                          ON INU.InvtID = SOPlan.InvtID
                                         AND INU.SiteID = SOPlan.SiteID
                                         AND INU.ComputerName + '' LIKE @ComputerName
                                         AND INU.UpdateSO = 1

                                  WHERE SOPlan.PlanType in ('30', '32', '34')	-- Shipper
                                    AND i.LotSerNbr <> ' '
                                    AND i.Whseloc <> ' '
                                  GROUP BY SOPlan.InvtID, SOPlan.SiteID, i.WhseLoc, i.LotSerNbr) as D

                             ON D.InvtID = INU.InvtID
                            AND D.SiteID = INU.SiteID
                            AND D.LotSerNbr = LotSerMst.LotSerNbr
                            AND D.WhseLoc = LotSerMst.WhseLoc
       END

	update	LotSerMst
	set	QtyAllocSO = Coalesce(D.QtyAlloc, 0),
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User

	from	LotSerMst

	join	INUpdateQty_Wrk INU (NOLOCK)
	  ON	INU.InvtID = LotSerMst.InvtID
	  AND	INU.SiteID = LotSerMst.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdateSO = 1

	left join (	select	SOPlan.InvtID,
			SOPlan.SiteID,
			SOLot.WhseLoc,
			SOLot.LotSerNbr,
			sum(	case when SOLine.UnitMultDiv = 'D' then
					case when SOLine.CnvFact <> 0 then
						round(SOLot.QtyShip / SOLine.CnvFact, @DecPlQty)
					else
						0
					end
				else
					round(SOLot.QtyShip * SOLine.CnvFact, @DecPlQty)
				end) as QtyAlloc

		from	SOPlan

		JOIN	INUpdateQty_Wrk INU (NOLOCK)
		  ON 	INU.InvtID = SOPlan.InvtID
		  AND 	INU.SiteID = SOPlan.SiteID
		  AND	INU.ComputerName + '' LIKE @ComputerName
		  AND	INU.UpdateSO = 1
			join	SOLine
		on	SOLine.CpnyID = SOPlan.CpnyID
		and	SOLine.OrdNbr = SOPlan.SOOrdNbr
		and	SOLine.LineRef = SOPlan.SOLineRef

		join	SOLot
		on	SOLot.CpnyID = SOPlan.CpnyID
		and	SOLot.OrdNbr = SOPlan.SOOrdNbr
		and	SOLot.LineRef = SOPlan.SOLineRef
		and	SOLot.SchedRef = SOPlan.SOSchedRef

		where	SOPlan.PlanType in ('60', '61')	-- Order
		and	SOLot.Status = 'O'
		and	SOLot.WhseLoc <> ''
		and	SOLot.LotSerNbr <> ''

		group by SOPlan.InvtID, SOPlan.SiteID, SOLot.WhseLoc, SOLot.LotSerNbr) as D

	on	D.InvtID = LotSerMst.InvtID
	and	D.SiteID = LotSerMst.SiteID
	and	D.WhseLoc = LotSerMst.WhseLoc
	and	D.LotSerNbr = LotSerMst.LotSerNbr

    IF @PCInstalled = 'S'
       BEGIN
          UPDATE LotSerMst
             SET PrjINQtyAllocSO = COALESCE(D.PrjINQtyAllocSO,0),
                 LUpd_DateTime = GetDate(),
                 LUpd_Prog = @LUpd_Prog,
                 LUpd_User = @LUpd_User
            FROM LotSerMst JOIN INUpdateQty_Wrk INU WITH(NOLOCK)
                             ON INU.InvtID = LotSerMst.InvtID
                            AND INU.SiteID = LotSerMst.SiteID
                            AND INU.ComputerName + '' LIKE @ComputerName
                            AND INU.UpdateSO = 1

                           LEFT JOIN (SELECT s.InvtID,
                                             i.LotSerNbr,
                                             s.SiteID,
                                             i.WhseLoc,
                                             SUM(i.QtyAllocated) as PrjINQtyAllocSO
                                   FROM SOPlan s JOIN SOLine l
                                                   ON l.CpnyID = s.CpnyID
                                                  AND l.OrdNbr = s.SOOrdNbr
                                                  AND l.LineRef = s.SOLineRef

                                                 JOIN INPrjAllocationLot	i
                                                   ON i.CpnyID = s.CpnyID
                                                  AND i.SrcNbr = s.SOOrdNbr
                                                  AND i.SrcLineRef = s.SOLineRef
                                                  AND i.SrcType = 'SO'

                                                 JOIN INUpdateQty_Wrk INU (NOLOCK)
                                                   ON INU.InvtID = s.InvtID
                                                  AND INU.SiteID = s.SiteID
                                                  AND INU.ComputerName + '' LIKE @ComputerName
                                                  AND INU.UpdateSO = 1

                                  WHERE	s.PlanType in ('60', '61')	-- Order
                                    AND	i.LotSerNbr <> ' '
                                    AND i.WhseLoc <> ' '
                                  GROUP BY s.InvtID, s.SiteID, i.WhseLoc, i.LotSerNbr) as D

                            ON D.InvtID = LotSerMst.InvtID
                           AND	D.LotSerNbr = LotSerMst.LotSerNbr
                           AND	D.SiteID = LotSerMst.SiteID
                           AND	D.WhseLoc = LotSerMst.WhseLoc
       END

	IF @LUpd_Prog = '10990'
		EXEC SCM_Plan_OtherQty @ComputerName, @LUpd_Prog, @LUpd_User, @DecPlQty



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_QtyAlloc] TO [MSDSL]
    AS [dbo];

