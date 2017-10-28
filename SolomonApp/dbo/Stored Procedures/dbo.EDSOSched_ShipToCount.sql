 CREATE Proc EDSOSched_ShipToCount @CpnyId varchar(10), @OrdNbr varchar(15) As
Select Count(Distinct ShipToId) + Sum(MarkFor) From SOSched Where CpnyId = @CpnyId And OrdNbr = @OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOSched_ShipToCount] TO [MSDSL]
    AS [dbo];

