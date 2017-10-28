 create procedure DMG_SOShipHeader_All_NoCancelled
as
	set nocount on

	select	*

	from	SOShipHeader

	where	Cancelled = 0

	order by CpnyID, ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipHeader_All_NoCancelled] TO [MSDSL]
    AS [dbo];

