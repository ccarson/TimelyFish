 CREATE PROCEDURE ADG_SOPrintQueue_GetFirstInv
	@CpnyID 	varchar(10),
	@RI_ID 		smallint

AS

	select	Min(InvcNbr)
	from	SOPrintQueue
	Where	CpnyID = @CpnyID
	  and	RI_ID = @RI_ID
	  and 	InvcNbr <> ''
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


