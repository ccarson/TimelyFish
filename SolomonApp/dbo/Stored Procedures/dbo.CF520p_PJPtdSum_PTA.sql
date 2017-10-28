Create Procedure CF520p_PJPtdSum_PTA @parm1 varchar (16), @parm2 varchar (32), @parm3 varchar (16) as 
    Select * from PJPtdSum Where Project = @parm1 and Pjt_Entity = @parm2 and Acct = @parm3
	and Act_Amount <> 0

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_PJPtdSum_PTA] TO [MSDSL]
    AS [dbo];

