Create Procedure CF517p_cftPacker_ContactId @parm1 varchar (10), @parm2 varchar(6) as 
    Select * from cftPacker Where CustId = @parm1 and ContactId Like @parm2
	Order by ContactId
