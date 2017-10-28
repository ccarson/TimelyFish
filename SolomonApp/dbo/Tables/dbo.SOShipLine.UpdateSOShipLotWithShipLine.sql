
CREATE TRIGGER UpdateSOShipLotWithShipLine ON SOShipLine 
FOR INSERT, UPDATE
AS
SET NOCOUNT ON
 	UPDATE 	SOShipLot 
	SET 	S4Future11 = Inserted.UnitMultDiv, 
		S4Future03 = Inserted.CnvFact
	FROM 	SOShiplot, Inserted
	WHERE	SOShipLot.CpnyID = Inserted.CpnyID
	  AND 	SOShipLot.ShipperID = Inserted.ShipperID 
	  AND 	SOShipLot.LineRef = Inserted.LineRef
