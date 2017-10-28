 create procedure DMG_SOHeader_CSIS
	@CpnyID		varchar(10),
	@Status		varchar(1),
	@InvtIDParm	varchar(30),
	@SiteIDParm	varchar(10)
as
	set nocount on

	select	*

	from	SOHeader h

	where	h.CpnyID LIKE @CpnyID
	and	h.Status LIKE @Status
	and exists (select * from SOLine l where l.CpnyID = h.CpnyID and l.OrdNbr = h.OrdNbr and l.InvtID like @InvtIDParm and l.SiteID like @SiteIDParm)

	order by CpnyID, OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_CSIS] TO [MSDSL]
    AS [dbo];

