 CREATE PROCEDURE DMG_GetFlexKeyLabel
 	@control_code varchar (30)
AS
    	Select 	SUBSTRING(control_data, 2, 16) FlexKeyLabel
	from 	PJCONTRL
        where 	control_code = @control_code
	  and	control_type = 'FK'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetFlexKeyLabel] TO [MSDSL]
    AS [dbo];

