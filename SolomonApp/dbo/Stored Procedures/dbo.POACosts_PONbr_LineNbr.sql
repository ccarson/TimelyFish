 /****** Object:  Stored Procedure dbo.POACosts_PONbr_LineNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Proc POACosts_PONbr_LineNbr @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
    Select * from POACosts where
        PONbr = @parm1 and
                LineNbr between @parm2beg and @parm2end
        Order by PONbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POACosts_PONbr_LineNbr] TO [MSDSL]
    AS [dbo];

