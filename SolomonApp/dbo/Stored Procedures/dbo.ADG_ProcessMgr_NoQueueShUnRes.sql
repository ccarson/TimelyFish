 create proc ADG_ProcessMgr_NoQueueShUnRes
as
	select	convert(smallint, S4Future12)
	from	SOSetup (nolock)


