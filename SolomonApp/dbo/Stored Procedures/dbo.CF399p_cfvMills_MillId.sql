Create Procedure CF399p_cfvMills_MillId @parm1 varchar (6) as 
    Select * from cfvMills Where MillId Like @parm1 and Not Exists (Select * from cftTMVendor Where 
	MillId = cfvMills.MillId)
	Order by MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF399p_cfvMills_MillId] TO [MSDSL]
    AS [dbo];

