 CREATE PROCEDURE ADG_LotSerMstLotSerNbr_Count
	@LotSerNbr 	varchar (25)
AS
	SELECT	Count(*)
	FROM 	LotSerMst
        WHERE 	LotSerNbr like @LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LotSerMstLotSerNbr_Count] TO [MSDSL]
    AS [dbo];

