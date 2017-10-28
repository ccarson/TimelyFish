 Create Proc ADG_UpdateAlloc_Location
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10),
	@ProgID		Varchar(8),
	@UserID		Varchar(10),
	@OldBucket	smallint,
	@NewBucket	smallint,
	@OldAlloc	float,
	@NewAlloc	float
        
As

	declare	@WOOpt varchar (1)
	Declare @CPSOnOff int
	Declare @DecPlQty smallint
	DECLARE @PrjINQtyAlloc float

	select	@WOOpt = left(S4Future11,1)
	from	WOSetup (nolock)
	where	Init = 'Y'

    select @CPSOnOff = CPSOnOff, @DecPlQty = DecPlQty
      from Insetup WITH(NOLOCK)
      
    SELECT  @PrjINQtyAlloc = 0

	insert	Location
	(
		CountStatus, Crtd_DateTime, Crtd_Prog, Crtd_User,
		InvtID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
		QtyAlloc, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
		S4Future01, S4Future02, S4Future03, S4Future04,
		S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		Selected, SiteID, User1, User2, User3, User4,
		User5, User6, User7, User8, WhseLoc
	)
	select
		'A', getdate(), @ProgID, @UserID,
		@InvtID, getdate(), @ProgID, @UserID, 0,
		0, 0, 0, 0,
		'', '', 0, 0,
		0, 0, '', '',
		0, 0, '', '',
		0, @SiteID, '', '', 0, 0,
		'', '', '', '', @WhseLoc

	from	Inventory (nolock)
	where	InvtID = @InvtID
	and	not exists (	select	InvtID, SiteID, WhseLoc
				from	Location
				where	InvtID = @InvtID
				and	SiteID = @SiteID
				and	WhseLoc = @WhseLoc)
if @@error != 0 return(@@error)

update Location set
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
	S4Future03 = case when convert(dec(25,9),S4Future03)-case @OldBucket when 9 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 9 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),S4Future03)-case @OldBucket when 9 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 9 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAvail = convert(dec(25,9),QtyAvail)-case when @NewBucket between 1 and 7 or @NewBucket = 8 and @WOOpt in ('F','R') or @NewBucket = 9 and @WOOpt = 'F' then convert(dec(25,9),@NewAlloc) else 0 end
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
				end else 0 end
			+ case when @OldBucket = 9 and @WOOpt = 'F' then case when convert(dec(25,9),S4Future03)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),S4Future03)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end,
	LUpd_Prog = @ProgId,
	LUpd_User = @UserId,
	LUpd_DateTime = getdate()
where InvtID = @InvtID and SiteID = @SiteID and WhseLoc = @WhseLoc
if @@error != 0 return(@@error)

If @NewBucket = 7 AND ISNULL((SELECT TOP 1 i.SrcNbr FROM InvProjAlloc i WITH(NOLOCK) WHERE InvtID = @InvtID and SiteID = @SiteID),'') <> ''
   BEGIN
        UPDATE Location
           SET PrjInQtyAlloc = isnull((SELECT sum(INPrjAllocation.QtyAllocated)
                                         FROM (SELECT InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef
                                                 FROM SOPlan WITH(NOLOCK)
                                                WHERE SOPlan.InvtID = @InvtID
                                                  AND SOPlan.SiteID = @SiteID
                                                  AND SOPlan.PlanType in ('30', '32', '34')
                                                GROUP BY InvtID, SiteID, PlanType, CpnyID, SOShipperID, SOShipperLineRef) SOPlan

                                                JOIN INPrjAllocation WITH(NOLOCK)
                                                  ON INPrjAllocation.CpnyID = SOPlan.CpnyID
                                                 AND INPrjAllocation.SrcNbr = SOPlan.SOShipperID
                                                 AND INPrjAllocation.SrcLineRef = SOPlan.SOShipperLineRef
                                                 AND INPrjAllocation.SrcType = 'SH'

                                      WHERE SOPlan.PlanType in ('30', '32', '34')	-- Shipper
                                        AND SOPlan.InvtID = @InvtID
                                        AND SOPlan.SiteID = @SiteID
                                        AND INPrjAllocation.InvtID = @InvtID
                                        AND INPrjAllocation.WhseLoc = @Whseloc), 0)
          FROM Location
         WHERE Location.InvtID = @InvtID
           AND Location.SiteID = @SiteID
           AND Location.Whseloc = @Whseloc
        
         UPDATE Location
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
                + PrjINQtyShipNotInv
                + PrjINQtyAllocSO
                + PrjINQtyAllocIN
                + PrjINQtyAllocPORet
                - case when @WOOpt in ('F','R') then QtyWORlsedDemand else 0 End
                - case when @WOOpt = 'F' then S4Future03 else 0 end,
                  @DecPlQty)
	     WHERE InvtID = @InvtID
           AND SiteID = @SiteID
           AND EXISTS (SELECT *
                         FROM LocTable l
                        WHERE l.SiteID = @SiteID
                          AND l.WhseLoc = Location.WhseLoc
                          AND l.InclQtyAvail = 1)
                          
	     SELECT @PrjINQtyAlloc = isnull(sum(PrjINQtyAlloc), 0)
           FROM Location
	      WHERE InvtID = @InvtID
            AND SiteID = @SiteID

	     UPDATE ItemSite
            SET PrjINQtyAlloc = @PrjINQtyAlloc
          WHERE InvtID = @InvtID
            AND SiteID = @SiteID                          
                                  
         if (@CPSOnOff = 0)
             BEGIN
		         exec ADG_Invt_CalcQtyAvail @InvtID, @SiteID, @ProgId, @UserId
		     END
		 ELSE
		     BEGIN
                  UPDATE ItemSite
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
                         + PrjINQtyShipNotInv
                         + PrjINQtyAllocSO
                         + PrjINQtyAllocIN
                         + PrjINQtyAllocPORet
                         - case when @WOOpt in ('F','R') then QtyWORlsedDemand else 0 End
                         - case when @WOOpt = 'F' then S4Future03 else 0 end,
                         @DecPlQty)
                   WHERE InvtID = @InvtID
                     AND SiteID = @SiteID
		     END        
    END
