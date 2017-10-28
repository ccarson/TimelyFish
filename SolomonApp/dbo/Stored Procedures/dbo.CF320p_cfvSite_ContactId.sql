Create Procedure CF320p_cfvSite_ContactId @parm1 varchar (6) as 
    Select * from cfvSite Where ContactId Like @parm1
	Order by ContactId
