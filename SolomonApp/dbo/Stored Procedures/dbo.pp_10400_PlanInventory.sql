 create proc pp_10400_PlanInventory
	@CpnyID			varchar(10),
	@BatNbr			varchar(10),
	@CPSOnOff		smallint,
	@ComputerName		varchar(21)
as
	declare @InvtID		varchar(30)
	declare @SiteID		varchar(10)

	declare		INTranCursor	cursor
	for
	select		InvtID,
			SiteID
	from		INTran
	where		BatNbr = @BatNbr
	  and		TranType not in ('CG', 'CT')
	group by	InvtID,
			SiteID

	open INTranCursor

	fetch next from INTranCursor into @InvtID, @SiteID

	while (@@fetch_status = 0)
	begin
		exec ADG_ProcessMgr_QueueInvt @CpnyID, @InvtID, @SiteID, @CPSOnOff, @ComputerName

		fetch next from INTranCursor into @InvtID, @SiteID
	end

	close INTranCursor
	deallocate INTranCursor

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


