 Create Proc EDSOShipLot_QtyShipUpd @CpnyId varchar(10), @ShipperId varchar(15), @LineRef varchar(5), @QtyShip float As
Update SOShipLot Set QtyShip = @QtyShip Where CpnyId = @CpnyId And ShipperId = @ShipperId And LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLot_QtyShipUpd] TO [MSDSL]
    AS [dbo];

