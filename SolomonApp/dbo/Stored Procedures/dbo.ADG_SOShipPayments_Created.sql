
create proc ADG_SOShipPayments_Created 
     @ShipRegisterID varchar(10) 
     
as
	Update SOShipPayments 
        Set S4future01 = '1'
	where S4Future11 = @ShipRegisterID
        
