Create Procedure CF303p_cftSubstMill_IM @parm1 varchar (30), @parm2 varchar (6) as 
    Select * from cftSubstMill Where InvtId = @parm1 and MillIdDflt Like @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftSubstMill_IM] TO [MSDSL]
    AS [dbo];

