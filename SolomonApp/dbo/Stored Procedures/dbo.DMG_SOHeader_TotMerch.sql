 CREATE PROCEDURE DMG_SOHeader_TotMerch
	@CpnyID varchar(10),
	@OrdNbr varchar(15)
AS
	select	TotMerch
	from	SOHeader
	where	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_TotMerch] TO [MSDSL]
    AS [dbo];

