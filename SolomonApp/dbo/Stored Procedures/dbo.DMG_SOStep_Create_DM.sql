﻿ CREATE PROCEDURE DMG_SOStep_Create_DM

	@CpnyID varchar(10)
as
	declare @SOTypeID varchar(4)

	select @SOTypeID = 'DM'

	exec DMG_SOStep_Insert_ENT  0, @CpnyID, 0, 1, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_ENTS 0, @CpnyID, 0, 1, 0, 0, '', @SOTypeID, 'D'
	exec DMG_SOStep_Insert_PINV 0, @CpnyID, 0, 0, 1, 1, '', @SOTypeID, 'O'
	exec DMG_SOStep_Insert_PRC  1, @CpnyID, 0, 1, 1, 1, '', @SOTypeID, 'D'
	exec DMG_SOStep_Insert_REL  1, @CpnyID, 0, 1, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_RUPD 1, @CpnyID, 0, 0, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_USHP 0, @CpnyID, 0, 0, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_X    0, @CpnyID, 0, 1, 0, 0, '', @SOTypeID, 'R'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Create_DM] TO [MSDSL]
    AS [dbo];

