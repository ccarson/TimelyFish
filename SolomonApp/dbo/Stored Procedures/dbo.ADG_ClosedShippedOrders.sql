 create proc ADG_ClosedShippedOrders
as

	declare		@CpnyID 	varchar(10)
	declare		@OrdNbr		varchar(15)
	declare		@LineRef	varchar(5)
	declare		@SchedRef	varchar(5)

	declare		SOSchedCursor cursor for
	select		CpnyID, OrdNbr, LineRef, SchedRef
	from		SOSched
	where		Status = 'O' and QtyOrd = 0

	open SOSchedCursor

	fetch next from SOSchedCursor
	into @CpnyID, @OrdNbr, @LineRef, @SchedRef

	-- Loop through the SOSchedCursor table.
	while (@@fetch_status <> -1)
	begin
		-- Close the SOSched line
		update 	SOSched
		set 	Status = 'C',
			LUpd_DateTime = GETDATE(),
			LUpd_Prog = 'SQL',
			LUpd_User = 'SQL'
		where	CpnyID = @CpnyID
		  and	OrdNbr = @OrdNbr
		  and	LineRef = @LineRef
		  and 	SchedRef = @SchedRef

		-- If there are no open schedules for the current line,
		-- then set the SOLine.Status = 'C'.
		If 	(select	count(*)
			from 	SOSched
			where 	CpnyID = @CpnyID
			  and 	OrdNbr = @OrdNbr
			  and 	LineRef = @LineRef
			  and	Status = 'O') = 0
				update	SOLine
			set	Status = 'C',
				LUpd_DateTime = GETDATE(),
				LUpd_Prog = 'SQL',
				LUpd_User = 'SQL'
			where 	CpnyID = @CpnyID
			  and 	OrdNbr = @OrdNbr
			  and 	LineRef = @LineRef

		-- If there are no open lines for the current order,
		-- then set SOHeader.Status = 'C'.
		If 	(select	count(*)
			from 	SOLine
			where 	CpnyID = @CpnyID
			  and 	OrdNbr = @OrdNbr
			  and	Status = 'O') = 0
				update	SOHeader
			set	Status = 'C',
				LUpd_DateTime = GETDATE(),
				LUpd_Prog = 'SQL',
				LUpd_User = 'SQL'
			where 	CpnyID = @CpnyID
			  and 	OrdNbr = @OrdNbr

		fetch next from SOSchedCursor
		into @CpnyID, @OrdNbr, @LineRef, @SchedRef
		end

	deallocate SOSchedCursor

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


