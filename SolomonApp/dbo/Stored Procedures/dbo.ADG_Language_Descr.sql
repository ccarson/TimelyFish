 create proc ADG_Language_Descr @parm1 varchar(4) as
	select	Descr
	from	Language
	where	LanguageID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Language_Descr] TO [MSDSL]
    AS [dbo];

