 /****** Object:  Stored Procedure dbo.PurOrdDet_PONbr_LineNbr1    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurOrdDet_PONbr_LineNbr1 @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
    Select * from PurOrdDet where PONbr = @parm1
         and LineNbr between @parm2beg and @parm2end
         order by PONbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_PONbr_LineNbr1] TO [MSDSL]
    AS [dbo];

