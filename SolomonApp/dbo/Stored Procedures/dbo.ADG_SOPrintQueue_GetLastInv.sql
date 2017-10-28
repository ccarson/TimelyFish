 CREATE PROCEDURE ADG_SOPrintQueue_GetLastInv
	@CpnyID 	varchar(10),
	@RI_ID 		smallint

AS

	select	Max(InvcNbr)
	from	SOPrintQueue
	Where	CpnyID = @CpnyID
	  and	RI_ID = @RI_ID
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


