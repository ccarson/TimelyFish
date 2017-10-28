 Create Proc EDSOShipLine_InvtIdChk @InvtId varchar(30), @CpnyId varchar(10), @ShipperId varchar(15) As
Select A.* From Inventory A, SOShipLine B Where A.InvtId = B.InvtId And A.InvtId = @InvtId And B.CpnyId = @CpnyId And B.ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_InvtIdChk] TO [MSDSL]
    AS [dbo];

