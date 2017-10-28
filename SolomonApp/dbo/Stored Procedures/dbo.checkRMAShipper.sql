
Create Proc checkRMAShipper
    @ShipID Varchar(15),
    @CompnyID as varchar(10)
as

Select OrdNbr 
	From SOLine
	Where OrigShipperID = @ShipID
		and CpnyID = @CompnyID
