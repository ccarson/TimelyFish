 CREATE Procedure EDContainer_AssignBolNbr @BolNbr varchar(20), @CpnyId varchar(10), @ShipperId varchar(15) As
Update EDContainer Set BolNbr = @BolNbr Where CpnyId = @CpnyId And ShipperId = @ShipperId
Update EDSOShipHeader Set BOL = @BolNbr Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_AssignBolNbr] TO [MSDSL]
    AS [dbo];

