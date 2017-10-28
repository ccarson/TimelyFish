 create proc ADG_ProcessMgr_DelDupUpdOrdTotals
	@QueueID	int,
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15)
as
	delete	ProcessQueue
	where	ProcessQueueID <> @QueueID
	  and	ProcessType = 'UPDOT'
	  and	CpnyID = @CpnyID
	  and	SOOrdNbr = @SOOrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


