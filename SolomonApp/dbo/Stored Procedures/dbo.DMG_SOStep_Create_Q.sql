 CREATE PROCEDURE DMG_SOStep_Create_Q

	@CpnyID varchar(10)
as
	declare @SOTypeID varchar(4)

	select @SOTypeID = 'Q'

	exec DMG_SOStep_Insert_CLOR 0, @CpnyID, 0, 0, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_ENT  0, @CpnyID, 0, 1, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_PRQ  1, @CpnyID, 0, 1, 1, 1, '', @SOTypeID, 'O'
	exec DMG_SOStep_Insert_REL  1, @CpnyID, 0, 1, 0, 0, '', @SOTypeID, 'R'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Create_Q] TO [MSDSL]
    AS [dbo];

