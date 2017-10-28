 Create Procedure DMG_SubXref_Sub

	@CpnyID varchar(10),
	@Sub varchar(24)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

	select	*
	from	vs_SubXRef
	where	CpnyID = @CpnyID
	and	Active = 1
	and	Sub Like @Sub
	order by Sub
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SubXref_Sub] TO [MSDSL]
    AS [dbo];

