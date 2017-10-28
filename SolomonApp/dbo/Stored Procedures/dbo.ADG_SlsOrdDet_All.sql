 CREATE PROCEDURE ADG_SlsOrdDet_All
	@CpnyID		char(10),
	@OrdNbr		char(10),
	@LineRef	char(5)
AS
	select	*
	from	SlsOrdDet
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	LineRef = @LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsOrdDet_All] TO [MSDSL]
    AS [dbo];

