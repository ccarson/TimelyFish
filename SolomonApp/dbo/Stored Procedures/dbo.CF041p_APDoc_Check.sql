CREATE Procedure [dbo].[CF041p_APDoc_Check] 
	@VendID varchar (15)
	as 
    	Select * 
	from APDoc 
	Where VendID Like @VendID
	AND DocType IN('CK','MC','ZC','VC')
	Order by VendID,DocDate Desc, RefNbr DESC 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF041p_APDoc_Check] TO [MSDSL]
    AS [dbo];

