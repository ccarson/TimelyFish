 create proc ADG_GLWildcard_AcctXref
	@CpnyID	varchar(10),
	@Acct	varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	set nocount on

	declare	@GLCpnyID	varchar(10)
	declare @Query		varchar(255)

	-- Get the 'account' company.
	select	@GLCpnyID = CpnyCOA
	from	VS_Company
	where	CpnyID = @CpnyID

	set nocount off

	--Execute the query from a variable so this procedure will compile even though the
	--view may not exist
	select @Query = 'select count(*) from VS_AcctXref where CpnyID = ' + QUOTENAME(@GLCpnyID, '''') + ' and Acct = ' + QUOTENAME(@Acct, '''')

	execute (@Query)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


