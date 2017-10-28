 create proc DMG_UpdateAll_Init_IS
	@ComputerName		varchar(21),
	@InvtIDParm		varchar(30),
	@SiteIDParm		varchar(10)
as
	delete from SOPlan
	where InvtID like @InvtIDParm and SiteID like @SiteIDParm
		delete from INUpdateQty_Wrk
	where ComputerName = @ComputerName


