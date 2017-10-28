Create Procedure xDamageDisc_DKeyPct @parm1 varchar (2), @parm2 float as 
    Select * from xDamageDisc Where DmgKey = @parm1 and DmgPct + DmgAdj = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xDamageDisc_DKeyPct] TO [MSDSL]
    AS [dbo];

