 CREATE PROCEDURE ADG_Terms_All
	@TermsID varchar(2)
AS
	select	*
	from	Terms
	where	TermsID = @TermsID
	and	NbrInstall < 2

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Terms_All] TO [MSDSL]
    AS [dbo];

