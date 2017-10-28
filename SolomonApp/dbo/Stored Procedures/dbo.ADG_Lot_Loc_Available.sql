 create procedure ADG_Lot_Loc_Available

	@InvtID varchar(30),
	@SiteID varchar(10),
	@SplitLots integer,
	@QtyNormalized float

as
	select	LotSerMst.InvtID,
		LotSerMst.SiteID,
		'QtyAvail' = LotSerMst.QtyOnHand - LotSerMst.QtyAlloc,
		LotSerMst.LotSerNbr,
		LotSerMst.WhseLoc,
		LocTable.PickPriority
	from	LotSerMst
	join	LocTable on LocTable.SiteID = LotSerMst.SiteID and LocTable.WhseLoc = LotSerMst.WhseLoc
	where	LotSerMst.InvtID like @InvtID
	  and	LotSerMst.SiteID like @SiteID
	  and	(0 = @SplitLots or (0 <> @SplitLots and (LotSerMst.QtyOnHand - LotSerMst.QtyAlloc) >= @QtyNormalized))
	order by LocTable.PickPriority, QtyAvail

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Lot_Loc_Available] TO [MSDSL]
    AS [dbo];

