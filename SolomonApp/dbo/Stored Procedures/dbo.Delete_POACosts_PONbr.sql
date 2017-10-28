 /****** Object:  Stored Procedure dbo.Delete_POACosts_PONbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure Delete_POACosts_PONbr @parm1 varchar ( 10) As
Delete from POACosts Where PONbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_POACosts_PONbr] TO [MSDSL]
    AS [dbo];

