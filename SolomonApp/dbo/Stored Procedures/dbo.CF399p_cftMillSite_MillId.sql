Create Procedure CF399p_cftMillSite_MillId @parm1 varchar (6) as 
    Select * from cftMillSite Where MillId Like @parm1
	Order by MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF399p_cftMillSite_MillId] TO [MSDSL]
    AS [dbo];

