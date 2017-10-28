 create procedure DMG_SOHeader_All_NoCancelled
as
	set nocount on

	select	*

	from	SOHeader

	where	Cancelled = 0

	order by CpnyID, OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_All_NoCancelled] TO [MSDSL]
    AS [dbo];

