 /****** Object:  Stored Procedure dbo.DeleteCARecur    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure DeleteCARecur @parm1 varchar ( 10), @parm2 varchar ( 10) As
Delete From CARecur Where
CARecur.RecurID = @parm1
and cpnyid like @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteCARecur] TO [MSDSL]
    AS [dbo];

