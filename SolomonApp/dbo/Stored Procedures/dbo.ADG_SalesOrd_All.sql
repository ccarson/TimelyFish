 CREATE PROCEDURE ADG_SalesOrd_All
	@CpnyID char(10),
	@OrdNbr	char(10)
AS
	select
		*
	from
		SalesOrd
	where
		CpnyID = @CpnyID
	and
		OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


