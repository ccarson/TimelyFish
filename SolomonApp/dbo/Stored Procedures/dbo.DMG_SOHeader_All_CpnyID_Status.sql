 create procedure DMG_SOHeader_All_CpnyID_Status
	@CpnyID		varchar(10),
	@Status		varchar(1)
as
	set nocount on

	select	*

	from	SOHeader

	where	CpnyID LIKE @CpnyID
	and	Status LIKE @Status

	order by CpnyID, OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_All_CpnyID_Status] TO [MSDSL]
    AS [dbo];

