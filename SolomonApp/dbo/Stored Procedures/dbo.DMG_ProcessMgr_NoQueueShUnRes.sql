 create proc DMG_ProcessMgr_NoQueueShUnRes
	@QueueShippersOnUnreserve smallint OUTPUT
as
	--Make the default 1 if the select below fails
	set @QueueShippersOnUnreserve = 1

	select	@QueueShippersOnUnreserve = convert(smallint, S4Future12)
	from	SOSetup (NOLOCK)

	--select @QueueShippersOnUnreserve


