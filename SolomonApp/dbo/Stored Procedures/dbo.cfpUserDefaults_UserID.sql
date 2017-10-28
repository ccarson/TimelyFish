create procedure cfpUserDefaults_UserID
	@parm1 varchar (47) 
	as
	select * from cftUserDefaults
        where UserID = @parm1
	order by UserID
