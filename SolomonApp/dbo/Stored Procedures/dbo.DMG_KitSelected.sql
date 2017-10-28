 create procedure DMG_KitSelected
	@KitID varchar(30),
	@DfltSite varchar(10) OUTPUT,
	@TranStatusCode varchar(2) OUTPUT
as
	select	@DfltSite = Inventory.DfltSite,
		@TranStatusCode = Inventory.TranStatusCode
	from	Kit (NOLOCK)
	join	Inventory (NOLOCK) on Inventory.InvtID = Kit.KitID
	where	Kit.KitId = @KitID
	and	Kit.Status = 'A'
	and	Inventory.TranStatusCode in ('AC','NP','OH')

	if @@ROWCOUNT = 0 begin
		set @DfltSite = ''
		set @TranStatusCode = ''
		return 0	--Failure
	end
	else begin
		--select @DfltSite, @TranStatusCode
		return 1	--Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_KitSelected] TO [MSDSL]
    AS [dbo];

