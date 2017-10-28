 /****** Object:  Stored Procedure dbo.APCheck_Tran    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APCheck_Tran @parm1 varchar ( 10), @parm2 varchar ( 2), @parm3 varchar ( 10), @parm4 varchar ( 24), @parm5beg smallint, @parm5end smallint As
Select * from APTran Where
RefNbr = @parm1 And
TranType = @parm2 And
Acct = @parm3 And
Sub = @parm4 And
LineNbr Between @parm5beg and @parm5end
Order By Acct, Sub, RefNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APCheck_Tran] TO [MSDSL]
    AS [dbo];

