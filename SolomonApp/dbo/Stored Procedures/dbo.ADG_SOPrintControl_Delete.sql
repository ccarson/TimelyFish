 CREATE PROCEDURE ADG_SOPrintControl_Delete
	@CpnyID varchar(10),
	@SOTypeID varchar(4)
AS
	DELETE FROM SOPrintControl
	WHERE CpnyID = @CpnyID AND
		SOTypeID = @SOTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


