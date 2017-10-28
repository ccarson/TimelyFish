create procedure CF001p_cftUserDefaults_UserID
	@parm1 varchar (47) 
	as
	select * from cftUserDefaults
        where UserID = @parm1
	order by UserID

