 /****** Object:  Stored Procedure dbo.POACosts_PONbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Proc POACosts_PONbr @parm1 varchar ( 10), @parm2 varchar ( 10) as
    Select * from POACosts where
        PONbr = @parm1 and
                InvcTypeID like @parm2
        Order by PONbr, InvcTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POACosts_PONbr] TO [MSDSL]
    AS [dbo];

