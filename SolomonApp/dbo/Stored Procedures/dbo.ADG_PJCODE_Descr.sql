 CREATE PROCEDURE ADG_PJCODE_Descr
	@code_type varchar(4),
	@code_value varchar(30)
AS
	select	code_value_desc
	from	PJCODE
	where	code_type = @code_type
	and	code_value = @code_value

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_PJCODE_Descr] TO [MSDSL]
    AS [dbo];

