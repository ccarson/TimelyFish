
create proc FlexBill_SOShipPayments_Created 
     @ShipperID varchar(15), @CpnyID varchar(10), @ShipRegisterID varchar(10)
     
as
	Update SOShipPayments 
        Set S4future01 = '1',
            S4Future11 = @ShipRegisterID,
            S4Future12 = 'PA'        
	where ShipperID = @ShipperID
	  AND cpnyID = @CpnyID
        
