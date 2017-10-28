 CREATE PROCEDURE ADG_LostSaleCode_Descr
	@parm1 varchar(2)
AS
	SELECT Descr
	FROM LostSaleCode
	WHERE  LostSaleID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


