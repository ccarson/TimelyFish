 create proc ADG_Invt_AdjustQtyShipNotInv
	@InvtID			varchar(30),
	@SiteID			varchar(10),
	@WhseLoc		varchar(10),
	@LotSerNbr		varchar(25),
	@SpecificCostID 	varchar(25),
	@QtyShip		float,
	@QtyAvailUpdateMode	smallint,	-- 0: CPS Off; 1: CPS On
	@QtyAvail		float,
	@ProgID			varchar(8),
	@UserID			varchar(10),
	@ShippingConfirm integer,
	@ErrorCode		smallint	output
as
	set nocount on

	declare	@QtyPrec	smallint
	declare @StkItem	smallint
    DECLARE @PCInstalled CHAR(1)

    SELECT @PCInstalled = p.S4Future3
      FROM PCSetup p WITH(NOLOCK)

	-- Exit if no quantity is being adjusted.
	if (@QtyShip = 0)
		return

	-- Fetch information from Inventory.
	select	@StkItem = StkItem
	from	Inventory (nolock)
	where	InvtID = @InvtID

	-- Exit if the item is not a stock item.
	if (@StkItem = 0)
		return

	-- Create the item records if they don't already exist.
	exec ADG_Invt_NewItem @InvtID, @SiteID, @WhseLoc, @LotSerNbr,
				@ProgID, @UserID, @ErrorCode output

	-- Exit if an error occurred while creating item records.
	if ((@@Error > 0) or (@ErrorCode <> 0))
		return

	-- Get the precision.
	select @QtyPrec = (select DecPlQty from INSetup (nolock))

	-- LotSerMst
	if (rtrim(@LotSerNbr) > '')
	begin
		update	LotSerMst
		set	QtyShipNotInv = round((QtyShipNotInv + @QtyShip), @QtyPrec),
            ShipConfirmQty = CASE WHEN @ShippingConfirm = 1 
                                   THEN CASE WHEN round((ShipConfirmQty - ROUND(@QtyShip,@QtyPrec)), @QtyPrec) < 0 
                                              THEN 0 
                                              ELSE round((ShipConfirmQty - ROUND(@QtyShip,@QtyPrec)), @QtyPrec)
                                         END
                                   ELSE ShipConfirmQty
                              END,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @ProgID,
			LUpd_User = @UserID

		where	InvtID = @InvtID
		  and	SiteID = @SiteID
		  and 	WhseLoc = @WhseLoc
		  and	LotSerNbr = @LotSerNbr

        IF @PCInstalled = 'S'
           BEGIN
              UPDATE LotSerMst
                 SET PrjINQtyShipNotInv = COALESCE(D.PrjINQtyShipNotInv,0) 
                FROM LotSerMst LEFT JOIN (SELECT i.InvtID, i.SiteID, i.WhseLoc, i.LotSerNbr,
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

                                          WHERE i.InvtID = @InvtID 
                                            AND i.SiteID = @SiteID 
                                            AND i.WhseLoc = @Whseloc
                                            AND i.LotSerNbr = @LotSerNbr
                                            AND (h.Status = 'C' OR h.Shippingconfirmed = '1')
                                            AND (h.ShipRegisterID = ' ' OR t.Rlsed = 0)
                                          GROUP BY i.InvtID, i.SiteID, i.Whseloc, i.LotSerNbr) AS D

                               ON LotSerMst.InvtID = D.InvtID
                              AND LotSerMst.SiteID = D.SiteID
                              AND LotSerMst.WhseLoc = D.WhseLoc
                              AND LotSerMst.LotSerNbr = D.LotSerNbr

             WHERE LotSerMst.InvtID = @InvtID
               AND LotSerMst.SiteID = @SiteID
               AND LotSerMst.WhseLoc = @Whseloc
               AND LotSerMst.LotSerNbr = @LotSerNbr
        END

	end

	-- Location
	update	Location
	set	QtyShipNotInv = round((QtyShipNotInv + @QtyShip), @QtyPrec),
        ShipConfirmQty = CASE WHEN @ShippingConfirm = 1 
                               THEN CASE WHEN round((ShipConfirmQty - ROUND(@QtyShip,@QtyPrec)), @QtyPrec) < 0
                                          THEN 0
                                          ELSE round((ShipConfirmQty - ROUND(@QtyShip,@QtyPrec)), @QtyPrec)
                                     END
                               ELSE ShipConfirmQty
                          END,
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @ProgID,
		LUpd_User = @UserID

	where	InvtID = @InvtID
	  and	SiteID = @SiteID
	  and 	WhseLoc = @WhseLoc

	-- ItemSite
	update	ItemSite
	set	LUpd_DateTime = GetDate(),
		LUpd_Prog = @ProgID,
		LUpd_User = @UserID,
		QtyShipNotInv = round((QtyShipNotInv + @QtyShip), @QtyPrec)

	where	InvtID = @InvtID
	  and	SiteID = @SiteID

    --Update for Project Allocated Inventory being consumed
    IF @PCInstalled = 'S'
    BEGIN

        UPDATE Location
           SET PrjINQtyShipNotInv = ISNULL((SELECT SUM(i.QtyAllocated)
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
                                             WHERE i.InvtID = @InvtID 
                                               AND i.SiteID = @SiteID 
                                               AND i.WhseLoc = @Whseloc
                                               AND (h.Status = 'C' OR h.Shippingconfirmed = '1')
                                               AND (h.ShipRegisterID = ' ' OR t.Rlsed = 0)
                                             GROUP BY i.InvtID, i.SiteID, i.Whseloc),0) 
          FROM Location
         WHERE Location.InvtID = @InvtID
           AND Location.SiteID = @SiteID
           AND Location.WhseLoc = @Whseloc

        UPDATE ItemSite
           SET PrjINQtyShipNotInv = ISNULL((SELECT SUM(i.QtyAllocated)
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
                                             WHERE i.InvtID = @InvtID 
                                               AND i.SiteID = @SiteID 
                                               AND (h.Status = 'C' OR h.Shippingconfirmed = '1')
                                               AND (h.ShipRegisterID = ' ' OR t.Rlsed = 0)
                                             GROUP BY i.InvtID, i.SiteID),0) 
          FROM ItemSite
         WHERE ItemSite.InvtID = @InvtID
           AND ItemSite.SiteID = @SiteID

    END

	-- ItemCost
	update	ItemCost
	set	S4Future03 = round((S4Future03 + @QtyShip), @QtyPrec),
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @ProgID,
		LUpd_User = @UserID
	where	InvtID = @InvtID
	  And	SiteID = @SiteID
	  And	SpecificCostID = @SpecificCostID
	  And   SpecificCostID <> ''

	-- Recalculate the quantity available
	if @QtyAvailUpdateMode = 0	-- CPS Off
		exec ADG_Invt_CalcQtyAvail @InvtID, @SiteID, @ProgID, @UserID

	else if @QtyAvailUpdateMode = 1	-- CPS On
		update	ItemSite
		set	QtyAvail = @QtyAvail
		where	InvtID = @InvtID
		and	SiteID = @SiteID


