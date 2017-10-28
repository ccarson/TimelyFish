 Create Procedure DMG_AcctSub_PJ_Account_Acct

	@CpnyID varchar(10),
	@Acct varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

	select	*
	from	vs_AcctSub
	join	PJ_Account on vs_AcctSub.Acct = Pj_Account.gl_Acct
	where	vs_AcctSub.CpnyID = @CpnyID
	and	vs_AcctSub.Acct like @Acct
	and	vs_AcctSub.Active = 1
	order by vs_AcctSub.Acct

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_AcctSub_PJ_Account_Acct] TO [MSDSL]
    AS [dbo];

