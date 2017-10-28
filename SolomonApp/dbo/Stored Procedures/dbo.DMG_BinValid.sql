 create procedure DMG_BinValid
	@SiteID varchar(10),
	@WhseLoc varchar(10),
	@ValidType varchar(10)
as
	declare @ReturnValue varchar(1)

	if upper(@ValidType) = 'ASSEMBLY' begin
		select	@ReturnValue = AssemblyValid
		from	LocTable
		where	SiteID = @SiteID
		and	WhseLoc = @WhseLoc
	end

	if upper(@ValidType) = 'RECEIPTS' begin
		select	@ReturnValue = ReceiptsValid
		from	LocTable
		where	SiteID = @SiteID
		and	WhseLoc = @WhseLoc
	end

	if upper(@ValidType) = 'SALES' begin
		select	@ReturnValue = SalesValid
		from	LocTable
		where	SiteID = @SiteID
		and	WhseLoc = @WhseLoc
	end

	select @ReturnValue

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_BinValid] TO [MSDSL]
    AS [dbo];

