 CREATE PROCEDURE ADG_SOSched_Delete
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@LineRef varchar(5),
	@SchedRef varchar(5)
AS
IF PATINDEX('%[%]%', @CpnyID) = 0  and PATINDEX('%[%]%', @ordnbr) = 0 
	DELETE FROM SOSched
	WHERE CpnyID = @CpnyID AND
		OrdNbr = @OrdNbr AND
		LineRef LIKE @LineRef AND
		SchedRef LIKE @SchedRef
ELSE
	DELETE FROM SOSched
	WHERE CpnyID LIKE @CpnyID AND
		OrdNbr LIKE @OrdNbr AND
		LineRef LIKE @LineRef AND
		SchedRef LIKE @SchedRef

IF PATINDEX('%[%]%', @CpnyID) = 0  and PATINDEX('%[%]%', @ordnbr) = 0 
	DELETE FROM SOSchedMark
	WHERE CpnyID = @CpnyID AND
		OrdNbr = @OrdNbr AND
		LineRef LIKE @LineRef AND
		SchedRef LIKE @SchedRef
ELSE
	DELETE FROM SOSchedMark
	WHERE CpnyID LIKE @CpnyID AND
		OrdNbr LIKE @OrdNbr AND
		LineRef LIKE @LineRef AND
		SchedRef LIKE @SchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


