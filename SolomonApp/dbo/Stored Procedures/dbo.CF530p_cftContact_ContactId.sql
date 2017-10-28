Create Procedure CF530p_cftContact_ContactId @parm1 varchar (6) as 
    Select  * from cftContact c Where Exists (Select * from cftContactRoleType 
	Where ContactId = c.ContactId and RoleTypeId = '003') and ContactID like @parm1  
	order by ContactID

