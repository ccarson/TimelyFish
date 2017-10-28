

Create Proc vs_AcctSub_Validate @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar(24) as
    Select CpnyID, Acct, Sub from vs_AcctSub where CpnyID = @parm1 and Acct Like @parm2 and Sub = @parm3 and Active = 1 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vs_AcctSub_Validate] TO [MSDSL]
    AS [dbo];

