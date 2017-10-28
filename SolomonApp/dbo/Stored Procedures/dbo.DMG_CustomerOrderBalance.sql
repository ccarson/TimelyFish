 create proc DMG_CustomerOrderBalance
	@CustID		varchar(15)
as
	exec ADG_CreditInfo_OrdShipBal '', @CustID, '', ''

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CustomerOrderBalance] TO [MSDSL]
    AS [dbo];

