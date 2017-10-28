 Create Procedure DMG_AcctXref_PJ_Account_Acct

	@CpnyID varchar(10),
	@Acct varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

	select	*
	from	vs_AcctXref
	join 	PJ_Account on vs_AcctXref.Acct = Pj_Account.gl_Acct
	where	vs_AcctXref.CpnyID = @CpnyID
	and	vs_AcctXref.Acct like @Acct
	and	vs_AcctXref.Active = 1
	order by vs_AcctXref.Acct

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


