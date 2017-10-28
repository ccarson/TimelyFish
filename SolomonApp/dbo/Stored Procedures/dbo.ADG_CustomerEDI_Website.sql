 create proc ADG_CustomerEDI_Website
	@custid	varchar(15)
as
	select	WebSite
	from	customerEDI
	where	custid like @custid

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


