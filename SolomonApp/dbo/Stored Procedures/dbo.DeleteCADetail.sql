 /****** Object:  Stored Procedure dbo.DeleteCADetail    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure DeleteCADetail @parm1 varchar ( 10) As
Delete from Catran Where
CaTran.Batnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteCADetail] TO [MSDSL]
    AS [dbo];

