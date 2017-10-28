 CREATE PROCEDURE ADG_SlsPrcDet_ConvertChainDisc

AS
	Declare @DfltDiscountID VarChar(1)
		Select @DfltDiscountID = dfltdiscountid from SOSetup

	UPDATE	SlsPrcDet
	Set		S4Future01 = @DfltDiscountID + rtrim(Convert(varchar(29), DiscPct))
	WHERE	S4Future01 = ''
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrcDet_ConvertChainDisc] TO [MSDSL]
    AS [dbo];

