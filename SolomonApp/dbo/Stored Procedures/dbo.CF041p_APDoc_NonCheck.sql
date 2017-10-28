CREATE Procedure CF041p_APDoc_NonCheck 
	@VendID varchar (15)
	as 
    	Select * 
	from APDoc 
	Where VendID Like @VendID
	AND DocType IN('VO','AD','AC')
	Order by VendID, InvcNbr 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF041p_APDoc_NonCheck] TO [MSDSL]
    AS [dbo];

