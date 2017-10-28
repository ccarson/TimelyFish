 create proc ADG_Customer_Status
	@custid	varchar(15)
as
	select	status
	from	customer
	where	custid like @custid

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


