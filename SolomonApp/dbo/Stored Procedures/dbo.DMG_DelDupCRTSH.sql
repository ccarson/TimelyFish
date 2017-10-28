 CREATE PROC DMG_DelDupCRTSH
as
	declare		@CpnyID		varchar(10)
	declare		@OrdNbr		varchar(15)
	declare		@QueueID	integer

	declare		PQCursor	cursor
	for
	select		CpnyID,
			SOOrdNbr,
			min(ProcessQueueID)

	from		ProcessQueue
	where		ProcessType = 'CRTSH'
	  and		ProcessPriority = 290

	group by	CpnyID,
			SOOrdNbr

	open PQCursor

	fetch next from PQCursor into @CpnyID, @OrdNbr, @QueueID

	while (@@fetch_status = 0)
	begin
		exec ADG_ProcessMgr_DelDupSOSh @QueueID, @CpnyID, @OrdNbr

		fetch next from PQCursor into @CpnyID, @OrdNbr, @QueueID
	end

	close PQCursor
	deallocate PQCursor

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_DelDupCRTSH] TO [MSDSL]
    AS [dbo];

