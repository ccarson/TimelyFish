Create Procedure CF530p_cftPacker_ContactId @parm1 varchar (6) as 
    Select p.*, c.* from cftPacker p Left Join cftContact c on p.ContactId = c.ContactId
	Where p.ContactId Like @parm1
	Order by p.ContactId
