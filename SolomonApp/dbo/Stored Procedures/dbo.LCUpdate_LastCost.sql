 Create proc LCUpdate_LastCost
	@InvtID varchar (30),
	@SiteID varchar(10),
	@NewCost float
as
UPdate ItemSite
	Set LastCost = @NewCost
Where
	Invtid = @InvtID
	And SiteID = @SiteId


