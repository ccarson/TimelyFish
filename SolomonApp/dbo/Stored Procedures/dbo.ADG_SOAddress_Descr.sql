 CREATE PROCEDURE ADG_SOAddress_Descr
	@CustID 	varchar(15),
	@ShipToID	varchar(10)
AS
	SELECT	Descr
	FROM	SOAddress
	WHERE	CustID = @CustID
	  AND	ShipToID = @ShipToID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOAddress_Descr] TO [MSDSL]
    AS [dbo];

