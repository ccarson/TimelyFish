 CREATE PROCEDURE DMG_SOShipHeader_Clsd_SRegID
	@CpnyID varchar(10), @RI_WHERE VARCHAR(1024)
AS

if RTRIM(@RI_WHERE) <> '' SELECT @RI_WHERE = ' AND (' + @RI_WHERE + ')'

exec('	Select	CpnyID,
		ShipperID,
		InvcNbr
	From	SOShipHeader (NOLOCK)
	Where	Status = ''C''
	And 	ShipRegisterID = ''''
	And 	ConsolInv = 0
	and	CpnyID = '''+ @CpnyID + '''' + @RI_WHERE)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipHeader_Clsd_SRegID] TO [MSDSL]
    AS [dbo];

