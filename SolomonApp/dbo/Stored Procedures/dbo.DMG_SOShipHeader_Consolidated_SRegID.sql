 CREATE PROCEDURE DMG_SOShipHeader_Consolidated_SRegID
	@CpnyID varchar(10), @RI_WHERE varchar(1024)
AS

if RTRIM(@RI_WHERE) <> '' SELECT @RI_WHERE = ' AND (' + @RI_WHERE + ')'

exec('	Select	CpnyID,
		ShipperID,
		InvcNbr
	From	SOShipHeader (NOLOCK)
	Where	Status = ''C''
	And 	ShipRegisterID = ''''
	And 	ConsolInv = 1
	And 	InvcNbr <> ''''
	And 	Exists(Select * From SOEvent (NOLOCK) Where CpnyID = SOShipHeader.CpnyID And ShipperID = SOShipHeader.ShipperID And EventType = ''PINV'')
	and	CpnyID = '''+ @CpnyID + '''' + @RI_WHERE + ' Order By InvcNbr')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipHeader_Consolidated_SRegID] TO [MSDSL]
    AS [dbo];

