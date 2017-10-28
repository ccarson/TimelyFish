 Create proc LCUpdate_LastCost_Invtid
	@InvtID varchar (30),
	@NewCost float
as
UPdate Inventory
	Set LastCost = @NewCost
Where
	Invtid = @InvtID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCUpdate_LastCost_Invtid] TO [MSDSL]
    AS [dbo];

