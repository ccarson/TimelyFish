 Create Proc EDShipment_CountContainers @BOLNbr varchar(20) As
Select Count(*) From EDShipTicket A Join EDContainer B On A.ShipperId = B.ShipperId And A.CpnyId = B.CpnyId
Where A.BOLNbr = @BOLNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_CountContainers] TO [MSDSL]
    AS [dbo];

