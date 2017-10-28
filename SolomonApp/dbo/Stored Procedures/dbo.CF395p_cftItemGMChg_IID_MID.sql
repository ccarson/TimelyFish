Create Procedure CF395p_cftItemGMChg_IID_MID @parm1 varchar (30), @parm2 varchar (6) as 
    Select * from cftItemGMChg Where InvtId = @parm1 and MillId Like @parm2
	Order by InvtId, MillId	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF395p_cftItemGMChg_IID_MID] TO [MSDSL]
    AS [dbo];

