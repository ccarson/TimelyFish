Create Procedure CF300p_cfvPigGroupInv_PGD @parm1 varchar (10), @parm2 smalldatetime as 
    Select Sum(Qty) from cfvPigGroupInv Where PigGroupId = @parm1 and TranDate <= @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cfvPigGroupInv_PGD] TO [MSDSL]
    AS [dbo];

