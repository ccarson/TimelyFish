 create procedure DMG_Book_PostBookings
	@PostBookings	smallint OUTPUT
as
	select	@PostBookings = PostBookings
	from	SOSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @PostBookings = 0
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end


