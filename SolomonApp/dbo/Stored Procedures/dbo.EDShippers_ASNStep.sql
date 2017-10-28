 Create Proc EDShippers_ASNStep As
Select CpnyId, ShipperId From SOShipHeader Where NextFunctionId = '5040200' And Cancelled = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShippers_ASNStep] TO [MSDSL]
    AS [dbo];

