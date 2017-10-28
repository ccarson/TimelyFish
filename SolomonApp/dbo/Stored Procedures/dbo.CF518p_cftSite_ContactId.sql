Create Procedure CF518p_cftSite_ContactId @parm1 varchar (6) as 
    Select * from cftSite Where ContactId Like @parm1
	Order by ContactId
