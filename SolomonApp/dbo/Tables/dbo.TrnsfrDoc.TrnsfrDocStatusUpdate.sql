
CREATE TRIGGER TrnsfrDocStatusUpdate ON TrnsfrDoc 
FOR INSERT, UPDATE
AS
	Set NOCOUNT ON
	UPDATE 	SOShipHeader 
	SET 	S4Future02 = Inserted.Status
	
	FROM 	SOShipHeader
	JOIN 	Inserted 
	  ON 	SOShipHeader.CpnyID = Inserted.CpnyID
   	 AND 	SOShipHeader.INBatNbr = Inserted.BatNbr
