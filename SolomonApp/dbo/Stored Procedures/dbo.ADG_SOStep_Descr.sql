 CREATE PROCEDURE ADG_SOStep_Descr
	@CpnyID varchar(10),
	@SOTypeID varchar(4),
	@FunctionID varchar(8),
	@FunctionClass varchar(4)
AS
	SELECT Descr
	FROM SOStep
	WHERE CpnyID = @CpnyID AND
		SOTypeID = @SOTypeID AND
		FunctionID = @FunctionID AND
		FunctionClass = @FunctionClass

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOStep_Descr] TO [MSDSL]
    AS [dbo];

