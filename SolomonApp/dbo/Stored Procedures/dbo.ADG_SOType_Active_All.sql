 CREATE PROCEDURE ADG_SOType_Active_All

	@FunctionID	varchar(8),
	@FunctionClass	varchar(4),
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
AS
	select	SOType.*
	from	SOType, SOStep
	where	SOType.CpnyID = SOStep.CpnyID
	  and	SOType.SOTypeID = SOStep.SOTypeID
	  and	SOStep.FunctionID = @FunctionID
	  and	SOStep.FunctionClass = @FunctionClass
	  and	SOType.CpnyID LIKE @CpnyID
	  and	SOType.SOTypeID LIKE @SOTypeID
	  and	SOType.Active = 1
	order by SOType.CpnyID,
	   	SOType.SOTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOType_Active_All] TO [MSDSL]
    AS [dbo];

