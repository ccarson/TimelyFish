 create procedure ADG_Shipper_Item_LS_Controlled
	@ShipperID varchar(15)

as

	select	count(*)
	from	SOShipLine
	join	Inventory on Inventory.InvtID = SOShipLine.InvtID
	where	SOShipLine.ShipperID = @ShipperID
	and	Inventory.LotSerTrack <> 'NN'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Shipper_Item_LS_Controlled] TO [MSDSL]
    AS [dbo];

