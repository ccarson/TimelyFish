 /****** Object:  Stored Procedure dbo.APDoc_Check_Voids    Script Date: 4/7/98 12:49:19 PM ******/
create Proc APDoc_Check_Voids @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime as
Select * from apdoc
Where cpnyid = @parm1
and acct = @parm2
and sub = @parm3
and status = 'V'
and DocType = 'VC'
and DocDate > @parm4
and rlsed = 1
Order by refnbr, docdate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Check_Voids] TO [MSDSL]
    AS [dbo];

