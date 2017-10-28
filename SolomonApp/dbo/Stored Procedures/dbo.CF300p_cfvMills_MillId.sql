Create Procedure CF300p_cfvMills_MillId @parm1 varchar (6) as 
    Select * from cfvMills Where MillId Like @parm1
	Order by MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cfvMills_MillId] TO [MSDSL]
    AS [dbo];

