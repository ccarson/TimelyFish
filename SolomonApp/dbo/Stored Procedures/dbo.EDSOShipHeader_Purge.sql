 Create Proc EDSOShipHeader_Purge As
Delete From EDSOShipHeader Where Not Exists (Select * From SOShipHeader Where EDSOShipHeader.CpnyId =
SOShipHeader.CpnyId And EDSOShipHeader.ShipperId = SOShipHeader.ShipperId)
Delete From EDContainer Where Not Exists (Select * From SOShipHeader Where EDContainer.CpnyId =
SOShipHeader.CpnyId And EDContainer.ShipperId = SOShipHeader.ShipperId)
Delete From EDContainerDet Where Not Exists (Select * From SOShipHeader Where EDContainerDet.CpnyId =
SOShipHeader.CpnyId And EDContainerDet.ShipperId = SOShipHeader.ShipperId)
Delete From EDShipTicket Where Not Exists (Select * From SOShipHeader Where EDShipTicket.CpnyId =
SOShipHeader.CpnyId And EDShipTicket.ShipperId = SOShipHeader.ShipperId)
Delete From EDShipment Where Not Exists (Select * From EDShipTicket Where EDShipment.BOLNbr =
EDShipTicket.BOLNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_Purge] TO [MSDSL]
    AS [dbo];

