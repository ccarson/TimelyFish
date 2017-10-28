 create procedure DMG_ModuleRegistered
	@RegItem 	varchar(5),
	@Unlocked 	smallint OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	if (	select	AccessNbr
		from 	vs_Access (NOLOCK)
        	where 	UserId = 'MasterAccess'
	) > 20
	begin
		select	@Unlocked = Unlocked
		from	vs_RegistDetail (NOLOCK)
		where	RegItem = @RegItem

		if @@ROWCOUNT = 0
			set @Unlocked = 0
	end
	else
		set @Unlocked = 1

	--select @Unlocked


