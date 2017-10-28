 CREATE PROCEDURE ADG_SOPrintQueue_GetInv
	@CpnyID 	varchar(10),
	@RI_ID 		smallint,
	@InvcNbr	varchar(15)

AS

	select	*
	from	SOPrintQueue
	Where	CpnyID = @CpnyID
	  and	RI_ID = @RI_ID
	  and 	InvcNbr = @InvcNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


