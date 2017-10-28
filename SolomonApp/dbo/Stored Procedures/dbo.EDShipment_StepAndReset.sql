 Create Procedure EDShipment_StepAndReset AS
Select * From EDShipment Where BOLNbr In (Select Distinct(EDShipTicket.BOLNbr) From EDShipTicket,SOShipHeader Where EDShipTicket.ShipperId = SOShipHeader.ShipperId And EDShipTicket.CpnyId = SOShipHeader.CpnyId And SOShipHeader.NextFunctionId = '5040200')
Union
Select * From EDShipment Where ShipStatus = 'C' And BOLState = 'S' And SendASN = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_StepAndReset] TO [MSDSL]
    AS [dbo];

