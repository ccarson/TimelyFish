Create Procedure pCF511_ContactId @parm1 varchar (6) as 
    Select * from cftContact
	Where ContactTypeID=4 AND ContactId Like @parm1 
	Order by ContactId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511_ContactId] TO [MSDSL]
    AS [dbo];

