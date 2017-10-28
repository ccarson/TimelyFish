 Create	Procedure SCM_Inventory_Next
	@InvtID		VarChar(30)
As
	Select	Top 1
		*
		From	Inventory (NoLock)
		Where	InvtID > @InvtID
		Order By InvtID


