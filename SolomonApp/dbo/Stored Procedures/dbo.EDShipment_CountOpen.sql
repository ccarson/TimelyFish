 Create Proc EDShipment_CountOpen @BolNbr varchar(20) As
Select Count(*) From EDShipTicket A, SOShipHeader B
Where A.BOLNbr = @BOLNbr And A.CpnyId = B.CpnyId And A.ShipperID = B.ShipperId And B.Status <> 'C'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_CountOpen] TO [MSDSL]
    AS [dbo];

