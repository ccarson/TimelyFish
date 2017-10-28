 CREATE PROCEDURE EDShipment_Set_ShipStatus @BolNbr varchar(20) AS
Update EDShipment set ShipStatus = 'R' where BOLNbr = @BolNbr


