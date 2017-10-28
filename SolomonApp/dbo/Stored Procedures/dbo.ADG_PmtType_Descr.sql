 CREATE PROCEDURE ADG_PmtType_Descr
	@CpnyID varchar(10),
	@PmtTypeID varchar(4)
AS
	SELECT	Descr
	FROM	PmtType
	WHERE	CpnyID = @CpnyID
	  AND	PmtTypeID = @PmtTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


