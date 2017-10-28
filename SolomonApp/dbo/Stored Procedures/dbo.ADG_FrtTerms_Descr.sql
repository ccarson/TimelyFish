 CREATE PROCEDURE ADG_FrtTerms_Descr
	@parm1 varchar(10)
AS
	Select Descr
	from FrtTerms
	where FrtTermsID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


