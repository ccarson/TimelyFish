Create Procedure xDamageDisc_DKeyFld @parm1 varchar (2), @parm2 varchar (5) as 
    Select * from xDamageDisc Where DmgKey = @parm1 and KeyFld Like @parm2 Order by DmgKey, DmgPct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xDamageDisc_DKeyFld] TO [MSDSL]
    AS [dbo];

