Create Procedure CF399p_cfvMills_TMillId @parm1 varchar (6) as 
    Select * from cfvMills Where MillId Like @parm1 and Not Exists (Select * from cftMillSite Where 
	MillId = cfvMills.MillId)
	Order by MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF399p_cfvMills_TMillId] TO [MSDSL]
    AS [dbo];

