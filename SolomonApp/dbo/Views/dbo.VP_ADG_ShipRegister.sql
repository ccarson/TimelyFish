 

CREATE VIEW VP_ADG_ShipRegister

 AS

	SELECT 	CpnyID, InvcNbr, OrdNbr, 
		ShipperID, ShipRegisterID=IsNull(NullIf(ShipRegisterID,''),AccrShipRegisterID),
		ReportName = '', VoidType = ''
	FROM 	SOShipHeader 

	UNION

	SELECT 	CpnyID, InvcNbr, OrdNbr = '', 
		ShipperID = '', ShipRegisterID,
		ReportName, VoidType
	FROM 	SOVoidInvc



 
