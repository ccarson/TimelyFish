 create procedure ADG_Company_Count

	@CpnyID varchar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

	select 	count(*)
	from	vs_Company
	where	CpnyID like @CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


