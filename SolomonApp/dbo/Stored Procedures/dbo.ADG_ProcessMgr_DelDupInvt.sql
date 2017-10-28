 create proc ADG_ProcessMgr_DelDupInvt
	@QueueID	int,
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	delete	from ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'PLNIN'
	and	InvtID = @InvtID
	and	SiteID = @SiteID


