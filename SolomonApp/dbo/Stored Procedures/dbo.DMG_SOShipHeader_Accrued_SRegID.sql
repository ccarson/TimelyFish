 CREATE PROCEDURE DMG_SOShipHeader_Accrued_SRegID
	@CpnyID varchar(10), @RI_WHERE VARCHAR(1024)
AS

if RTRIM(@RI_WHERE) <> '' SELECT @RI_WHERE = ' AND (' + @RI_WHERE + ')'

exec('	Select	CpnyID,
		ShipperID,
		InvcNbr
	From	SOShipHeader (NOLOCK)
	Where	Status = ''C''
	And 	ShipRegisterID = ''''
	And 	AccrShipRegisterID = ''''
	And 	Not Exists(Select * From SOEvent (NOLOCK) Where CpnyID = SOShipHeader.CpnyID And ShipperID = SOShipHeader.ShipperID And EventType = ''PINV'')
	And 	ConsolInv = 1
	and	CpnyID = '''+ @CpnyID + '''' + @RI_WHERE)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipHeader_Accrued_SRegID] TO [MSDSL]
    AS [dbo];

