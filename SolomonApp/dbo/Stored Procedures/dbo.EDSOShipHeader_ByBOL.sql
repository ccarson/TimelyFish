 CREATE Proc EDSOShipHeader_ByBOL @BOLNbr varchar(20) As
Select B.* From EDShipTicket A Inner Join SOShipHeader B On A.CpnyId = B.CpnyId And A.ShipperId =
B.ShipperId Where A.BOLNbr = @BOLNbr Order By A.CpnyId, A.ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_ByBOL] TO [MSDSL]
    AS [dbo];

