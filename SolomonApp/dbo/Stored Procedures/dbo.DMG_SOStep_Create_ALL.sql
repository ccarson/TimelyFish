 CREATE PROCEDURE DMG_SOStep_Create_ALL

	@CpnyID varchar(10)
as
	declare @SOTypeID varchar(4)

	select @SOTypeID = 'ALL'

	exec DMG_SOStep_Insert_CASY      0,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'O'
	exec DMG_SOStep_Insert_CINS      0,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'O'
	exec DMG_SOStep_Insert_CLOR      1,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'R'
	exec DMG_SOStep_Insert_CPAK      0,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_CPIK      0,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_CREC      0,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'R'
	exec DMG_SOStep_Insert_CSHP      0,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'R'
	exec DMG_SOStep_Insert_ENT       0,      @CpnyID,       1,         1,             0,       0,    '',       @SOTypeID,      'R'
	exec DMG_SOStep_Insert_ENTS      0,      @CpnyID,       1,         1,             0,       0,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_NASY      0,      @CpnyID,       0,         1,             1,       1,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_NINS      0,      @CpnyID,       0,         1,             1,       1,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_NPAK      0,      @CpnyID,       0,         1,             1,       1,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_NPIK      0,      @CpnyID,       0,         1,             1,       1,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_NSHP      0,      @CpnyID,       0,         1,             1,       1,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_PASY      1,      @CpnyID,       1,         1,             1,       1,    '',       @SOTypeID,      'O'
	exec DMG_SOStep_Insert_PINS      0,      @CpnyID,       1,         1,             1,       1,    '',       @SOTypeID,      'O'
	exec DMG_SOStep_Insert_PINV      0,      @CpnyID,       0,         0,             1,       1,    '',       @SOTypeID,      'O'
	exec DMG_SOStep_Insert_PPAK      0,      @CpnyID,       1,         1,             1,       1,    '',       @SOTypeID,      'O'
	exec DMG_SOStep_Insert_PPIK      0,      @CpnyID,       1,         1,             1,       1,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_PRC       1,      @CpnyID,       0,         1,             1,       1,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_PREC      1,      @CpnyID,       0,         0,             1,       1,    '',       @SOTypeID,      'O'
	exec DMG_SOStep_Insert_PRQ       1,      @CpnyID,       0,         1,             1,       1,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_RASY      1,      @CpnyID,       1,         1,             0,       0,    '0500',   @SOTypeID,      'O'
	exec DMG_SOStep_Insert_REL       1,      @CpnyID,       1,         1,             0,       0,    '',       @SOTypeID,      'R'
	exec DMG_SOStep_Insert_RINS      1,      @CpnyID,       1,         1,             0,       0,    '0600',   @SOTypeID,      'O'
	exec DMG_SOStep_Insert_RPAK      0,      @CpnyID,       1,         1,             0,       0,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_RREC      0,      @CpnyID,       0,         1,             0,       0,    '',       @SOTypeID,      'O'
	exec DMG_SOStep_Insert_RSHP      0,      @CpnyID,       1,         1,             0,       0,    '',       @SOTypeID,      'D'
	exec DMG_SOStep_Insert_RUPD      1,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'R'
	exec DMG_SOStep_Insert_USHP      0,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'R'
	exec DMG_SOStep_Insert_X         0,      @CpnyID,       1,         1,             0,       0,    '',       @SOTypeID,      'R'
	exec DMG_SOStep_Insert_CANA      1,      @CpnyID,       0,         0,             0,       0,    '',       @SOTypeID,      'R'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Create_ALL] TO [MSDSL]
    AS [dbo];

