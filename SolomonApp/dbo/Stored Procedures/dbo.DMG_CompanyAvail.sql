 create proc DMG_CompanyAvail
	@BaseCuryID	varchar(4),
	@DatabaseName	varchar(30),
	@CpnyID		varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	Select	*
	from	vs_Company
	where	BaseCuryID like @BaseCuryID
	and	DatabaseName like @DatabaseName
	and	CpnyID like @CpnyID
	order by CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


