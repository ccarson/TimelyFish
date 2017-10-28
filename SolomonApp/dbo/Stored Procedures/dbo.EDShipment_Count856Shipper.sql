 CREATE PROCEDURE EDShipment_Count856Shipper @BOLNbr varchar(20)As
Select Count(*) From EDShipTicket A, SOShipHeader B Where A.BOLNbr = @BOLNbr And A.CpnyId = B.CpnyId
And A.ShipperId = B.ShipperId And B.EDI856 = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_Count856Shipper] TO [MSDSL]
    AS [dbo];

