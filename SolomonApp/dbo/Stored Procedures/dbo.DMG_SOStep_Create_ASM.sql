 CREATE PROCEDURE DMG_SOStep_Create_ASM

	@CpnyID varchar(10)
as
	declare @SOTypeID varchar(4)

	select @SOTypeID = 'ASM'
	exec DMG_SOStep_Insert_ENT  0, @CpnyID, 1, 1, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_ASM 1, '0000', '4440700', @CpnyID, 0, 0, 'Send Purchase Order Ack', '0000', '4440700', 0, 0, '0105',  '',@SOTypeID, 'D'
	exec DMG_SOStep_Insert_REL  1, @CpnyID, 1, 1, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_PRC  1, @CpnyID, 0, 1, 1, 1, '', @SOTypeID, 'D'
	exec DMG_SOStep_Insert_X    0, @CpnyID, 1, 1, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_ENTS 0, @CpnyID, 1, 1, 0, 0, '', @SOTypeID, 'D'
	exec DMG_SOStep_Insert_PPAK 0, @CpnyID, 1, 1, 0, 1, '', @SOTypeID, 'D'
	exec DMG_SOStep_Insert_ASM 1, '0000', '4440500', @CpnyID, 1, 0, 'Send 940', '0000', '4440500', 0, 0, '0620', '',@SOTypeID, 'R'
	exec DMG_SOStep_Insert_ASM 1, '0000', '5040500', @CpnyID, 0, 0, 'Print Container Labels', '0000', '5040500', 0, 0, '0630', '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_CSHP 0, @CpnyID, 0, 0, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_RUPD 1, @CpnyID, 0, 0, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_USHP 0, @CpnyID, 0, 0, 0, 0, '', @SOTypeID, 'R'
	exec DMG_SOStep_Insert_ASM 1, '', '5040200', @CpnyID, 0, 0, 'Send ASN', '0100', '5040200', 0, 0, '0815',  '',@SOTypeID, 'R'
	exec DMG_SOStep_Insert_PINV 0, @CpnyID, 0, 0, 1, 1, '', @SOTypeID, 'O'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Create_ASM] TO [MSDSL]
    AS [dbo];

