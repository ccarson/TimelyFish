 Create Proc EDShipment_CpnyIdShipperId @CpnyId varchar(10), @ShipperId varchar(10) As
Select * From EDShipment Where BOLNbr = (Select BOLNbr From EDShipTicket Where
CpnyId = @CpnyId And ShipperId = @ShipperId)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_CpnyIdShipperId] TO [MSDSL]
    AS [dbo];

