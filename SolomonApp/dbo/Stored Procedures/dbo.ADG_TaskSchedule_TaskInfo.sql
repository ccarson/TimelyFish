 create proc ADG_TaskSchedule_TaskInfo
as
	select	TaskProgram,
		CpnyID,
		FunctionID,
		FunctionClass,
		StartTime,
		EndTime,
		Interval
	from	TaskSchedule
	where	Active = 1
	order by StartTime, TaskProgram

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_TaskSchedule_TaskInfo] TO [MSDSL]
    AS [dbo];

