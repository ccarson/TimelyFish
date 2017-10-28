Create Procedure bavx_Contact_ContactId @parm1 varchar (6) as 
    Select * from vx_Contact Where ContactId Like @parm1
	Order by ContactId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[bavx_Contact_ContactId] TO [MSDSL]
    AS [dbo];

