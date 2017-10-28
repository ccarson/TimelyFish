Create Procedure CF394p_cftSubstMill_MI @parm1 varchar (6), @parm2 varchar (30) as 
    Select * from cftSubstMill Where MillIdDflt Like @parm1 and InvtId Like @parm2
	Order by MillIdDflt, InvtId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF394p_cftSubstMill_MI] TO [MSDSL]
    AS [dbo];

