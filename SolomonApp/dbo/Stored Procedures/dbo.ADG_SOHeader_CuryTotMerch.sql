 CREATE PROCEDURE ADG_SOHeader_CuryTotMerch
	@CpnyID varchar(10),
	@OrdNbr varchar(15)
AS
	SELECT CuryTotMerch
	FROM SOHeader
	Where CpnyID = @CpnyID AND
		OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


