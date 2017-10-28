CREATE Procedure CF041p_PurchOrd_VendID 
	@VendID varchar (15)
	as 
    	Select * 
	from PurchOrd 
	Where VendID Like @VendID
	Order by VendID, PONbr DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF041p_PurchOrd_VendID] TO [MSDSL]
    AS [dbo];

