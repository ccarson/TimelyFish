 Create Proc EDSOShipLine_VerifyCntr @CpnyId varchar(10), @ShipperId varchar(15) As
Select Count(*) From SOShipLine Where CpnyId = @CpnyId And ShipperId = @ShipperId And LotSerCntr = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_VerifyCntr] TO [MSDSL]
    AS [dbo];

