 /****** Object:  Stored Procedure dbo.DeleteCATran    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure DeleteCATran @parm1 varchar ( 10), @parm2 varchar ( 10) As
Delete From CATran Where
CATran.RecurID = @parm1
and @parm2 like cpnyid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteCATran] TO [MSDSL]
    AS [dbo];

