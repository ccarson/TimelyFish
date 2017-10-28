Create Procedure CF399p_cftMillSite_CpnyId @parm1 varchar (10), @parm2 varchar (6) as 
    Select * from cftMillSite Where CpnyId Like @parm1 and MillId Like @parm2
	Order by CpnyId, MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF399p_cftMillSite_CpnyId] TO [MSDSL]
    AS [dbo];

