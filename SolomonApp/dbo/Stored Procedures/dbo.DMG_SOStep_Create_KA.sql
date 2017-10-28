 CREATE PROCEDURE DMG_SOStep_Create_KA

	@CpnyID varchar(10)
as
	declare @SOTypeID varchar(4)

	select @SOTypeID = 'KA'

	exec DMG_SOStep_Insert_CASY 0, @CpnyID, 0, 0, 0, 0, '',     @SOTypeID, 'O'
	exec DMG_SOStep_Insert_CINS 0, @CpnyID, 0, 0, 0, 0, '',     @SOTypeID, 'O'
	exec DMG_SOStep_Insert_ENT  0, @CpnyID, 0, 1, 0, 0, '',     @SOTypeID, 'R'
	exec DMG_SOStep_Insert_ENTS 0, @CpnyID, 0, 1, 0, 0, '',     @SOTypeID, 'D'
	exec DMG_SOStep_Insert_PASY 0, @CpnyID, 0, 1, 1, 1, '',     @SOTypeID, 'O'
	exec DMG_SOStep_Insert_PINS 0, @CpnyID, 0, 1, 1, 1, '',     @SOTypeID, 'O'
	exec DMG_SOStep_Insert_PRC  1, @CpnyID, 0, 1, 1, 1, '',     @SOTypeID, 'D'
	exec DMG_SOStep_Insert_RASY 1, @CpnyID, 0, 1, 0, 0, '',     @SOTypeID, 'O'
	exec DMG_SOStep_Insert_REL  1, @CpnyID, 0, 1, 0, 0, '',     @SOTypeID, 'R'
	exec DMG_SOStep_Insert_RINS 1, @CpnyID, 0, 1, 0, 0, '0600', @SOTypeID, 'O'
	exec DMG_SOStep_Insert_RUPD 1, @CpnyID, 0, 0, 0, 0, '',     @SOTypeID, 'R'
	exec DMG_SOStep_Insert_USHP 0, @CpnyID, 0, 0, 0, 0, '',     @SOTypeID, 'R'
	exec DMG_SOStep_Insert_X    0, @CpnyID, 0, 1, 0, 0, '',     @SOTypeID, 'R'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Create_KA] TO [MSDSL]
    AS [dbo];

