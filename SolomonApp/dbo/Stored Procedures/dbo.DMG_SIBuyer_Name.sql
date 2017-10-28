 CREATE PROCEDURE DMG_SIBuyer_Name
	@Buyer varchar(10)
AS
	Select	BuyerName
	from	SIBuyer
	where	Buyer = @Buyer

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SIBuyer_Name] TO [MSDSL]
    AS [dbo];

