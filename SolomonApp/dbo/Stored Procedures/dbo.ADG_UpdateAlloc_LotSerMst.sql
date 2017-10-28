 Create Proc ADG_UpdateAlloc_LotSerMst
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10),
	@LotSerNbr	Varchar(25),
	@ProgID		Varchar(8),
	@UserID		Varchar(10),
	@OldBucket	smallint,
	@NewBucket	smallint,
	@OldAlloc	float,
	@NewAlloc	float
    
As

	declare	@WOOpt varchar (1)
	declare @DecPlQty smallint

	select	@WOOpt = left(S4Future11,1)
	from	WOSetup (nolock)
	where	Init = 'Y'
	
	select @DecPlQty = DecPlQty
      From INSetup WITH (NoLock)

		insert	LotSerMst
		(
			Cost, Crtd_DateTime, Crtd_Prog, Crtd_User,
			ExpDate, InvtID, LIFODate, LotSerNbr,
			LUpd_DateTime, LUpd_Prog, LUpd_User,
			MfgrLotSerNbr, NoteID, OrigQty, QtyAlloc,
			QtyOnHand, QtyShipNotInv, QtyWORlsedDemand, RcptDate,
			S4Future01, S4Future02, S4Future03, S4Future04,
			S4Future05, S4Future06, S4Future07, S4Future08,
			S4Future09, S4Future10, S4Future11, S4Future12,
			ShipContCode, SiteID, Source, SrcOrdNbr, Status, StatusDate,
			User1, User2, User3, User4,
			User5, User6, User7, User8,
			WarrantyDate, WhseLoc
		)
		select distinct
			0, getdate(), @ProgID, @UserID,
			'', @InvtID, '', @LotSerNbr,
			getdate(), @ProgID, @UserID,
			'', 0, 0, 0,
			0, 0, 0, '',
			'', '', 0, 0,
			0, 0, '', '',
			0, 0, '', '',
			'', @SiteID, 'OM', '', 'H', '',
			'', '', 0, 0,
			'', '', '', '',
			'', @WhseLoc

	from	Inventory (nolock)
	where	InvtID = @InvtID
		and	not exists (	select	InvtID, SiteID, WhseLoc, LotSerNbr
					from	LotSerMst
					where	InvtID = @InvtID
					and	LotSerNbr = @LotSerNbr
					and	SiteID = @SiteID
					and	WhseLoc = @WhseLoc)
if @@error != 0 return(@@error)

--Project Allocated Inventory being issued to project.
UPDATE l SET PrjINQtyAllocIN = ISNULL(a.QtyAllocated,0)
  FROM LotSerMst l LEFT JOIN (SELECT SUM(t.QtyAllocated) QtyAllocated, InvtID, SiteID, WhseLoc, LotSerNbr 
                               FROM INPrjAllocationLot t
                              WHERE t.SrcType = 'IS'
                                AND t.InvtID = @InvtID
                                AND t.SiteID = @SiteID
                                AND t.WhseLoc = @WhseLoc
                                AND t.LotSerNbr = @LotSerNbr
                              GROUP BY t.InvtID, t.SiteID, t.WhseLoc, t.LotSerNbr) As a
                    ON l.InvtID = a.InvtID
                   AND l.SiteID = a.SiteID
                   AND l.WhseLoc = a.WhseLoc
                   AND l.LotSerNbr = a.LotSerNbr
 WHERE l.InvtID = @InvtID 
   and l.SiteID = @SiteID
   AND l.WhseLoc = @WhseLoc
   AND l.LotSerNbr = @LotSerNbr
if @@error != 0 return(@@error)

If @NewBucket = 7 
  BEGIN
          UPDATE LotSerMst
             SET PrjINQtyAlloc = COALESCE(D.PrjINQtyAlloc,0)
            FROM LotSerMst LEFT JOIN (SELECT SOPlan.InvtID,
                                             i.LotSerNbr,
                                             SOPlan.SiteID,
                                             i.WhseLoc,
                                             Sum(i.QtyAllocated) as PrjINQtyAlloc
                                        FROM (SELECT InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef
                                                FROM SOPlan s WITH(NOLOCK)
                                               WHERE s.InvtID = @InvtID
                                                 AND s.SiteID = @SiteID
                                               GROUP BY InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef) SOPlan
                                        JOIN INPrjAllocationLot i WITH(NOLOCK)
                                          on i.CpnyID = SOPlan.CpnyID
                                         AND i.SrcNbr = SOPlan.SOShipperID
                                         AND i.SrcLineRef = SOPlan.SOShipperLineRef
                                         AND i.SrcType = 'SH'
                                  WHERE SOPlan.PlanType in ('30', '32', '34')	-- Shipper
                                     AND	SOPlan.InvtID = @InvtID
                                     AND	SOPlan.SiteID = @SiteID
                                   GROUP BY SOPlan.InvtID, SOPlan.SiteID, i.WhseLoc, i.LotSerNbr) as D

                             ON D.InvtID = LotSerMst.InvtID
                            AND D.LotSerNbr = LotSerMst.LotSerNbr
                            AND D.SiteID = LotSerMst.SiteID
                            AND D.WhseLoc = LotSerMst.WhseLoc
         WHERE LotSerMst.InvtID = @InvtID 
           AND LotSerMst.SiteID = @SiteID
           AND LotSerMst.WhseLoc = @WhseLoc
           AND LotSerMst.LotSerNbr = @LotSerNbr
           if @@error != 0 return(@@error)
  END

update LotSerMst set
	QtyAllocBM = case when convert(dec(25,9),QtyAllocBM)-case @OldBucket when 1 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 1 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocBM)-case @OldBucket when 1 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 1 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAllocIN = case when convert(dec(25,9),QtyAllocIN)-case @OldBucket when 2 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 2 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocIN)-case @OldBucket when 2 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 2 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAllocPORet = case when convert(dec(25,9),QtyAllocPORet)-case @OldBucket when 3 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 3 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocPORet)-case @OldBucket when 3 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 3 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAllocSD = case when convert(dec(25,9),QtyAllocSD)-case @OldBucket when 4 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 4 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocSD)-case @OldBucket when 4 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 4 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAllocSO = case when convert(dec(25,9),QtyAllocSO)-case @OldBucket when 5 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 5 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocSO)-case @OldBucket when 5 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 5 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyShipNotInv = case when convert(dec(25,9),QtyShipNotInv)-case @OldBucket when 6 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 6 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyShipNotInv)-case @OldBucket when 6 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 6 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAlloc = case when convert(dec(25,9),QtyAlloc)-case @OldBucket when 7 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 7 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAlloc)-case @OldBucket when 7 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 7 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyWORlsedDemand = case when convert(dec(25,9),QtyWORlsedDemand)-case @OldBucket when 8 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 8 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyWORlsedDemand)-case @OldBucket when 8 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 8 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAvail =  convert(dec(25,9),QtyAvail)-case when @NewBucket between 1 and 7 or @NewBucket = 8 and @WOOpt in ('F','R') then convert(dec(25,9),@NewAlloc) else 0 end
			+ case @OldBucket when 1 then case when convert(dec(25,9),QtyAllocBM)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocBM)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 2 then case when convert(dec(25,9),QtyAllocIN)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocIN)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 3 then case when convert(dec(25,9),QtyAllocPORet)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocPORet)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 4 then case when convert(dec(25,9),QtyAllocSD)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocSD)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 5 then case when convert(dec(25,9),QtyAllocSO)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocSO)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 6 then case when convert(dec(25,9),QtyShipNotInv)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyShipNotInv)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 7 then case when convert(dec(25,9),QtyAlloc)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAlloc)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case when @OldBucket = 8 and @WOOpt in ('F','R') then case when convert(dec(25,9),QtyWORlsedDemand)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyWORlsedDemand)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end,
	LUpd_Prog = @ProgId,
	LUpd_User = @UserId,
	LUpd_DateTime = getdate()
where InvtID = @InvtID and SiteID = @SiteID and WhseLoc = @WhseLoc and LotSerNbr = @LotSerNbr
if @@error != 0 return(@@error)

If @NewBucket = 7 
  BEGIN
  
    UPDATE LotSerMst
       SET QtyAvail = round(QtyOnHand
                   - QtyAlloc
                   - QtyAllocBM
                   - QtyAllocIN
                   - QtyAllocPORet
                   - QtyAllocSD
                   - QtyAllocSO
                   - QtyShipNotInv
                   - QtyAllocProjIN
                   + PrjINQtyAlloc
                   + PrjINQtyAllocSO
                   + PrjINQtyShipNotInv
                   + PrjINQtyAllocIN
                   + PrjINQtyAllocPORet
                   - case when @WOOpt in ('F','R') then QtyWORlsedDemand else 0 End,
                   @DecPlQty)
    WHERE InvtID = @InvtID
      AND SiteID = @SiteID
      AND WhseLoc = @WhseLoc
      AND LotSerNbr = @LotSerNbr
      AND EXISTS (SELECT *
                    FROM LocTable l
                   WHERE l.SiteID = @SiteID
                     AND l.WhseLoc = LotSerMst.WhseLoc
                     AND l.InclQtyAvail = 1)
    if @@error != 0 return(@@error)
 END

