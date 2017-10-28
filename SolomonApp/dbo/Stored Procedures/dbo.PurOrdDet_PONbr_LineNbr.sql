 /****** Object:  Stored Procedure dbo.PurOrdDet_PONbr_LineNbr    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurOrdDet_PONbr_LineNbr @parm1 varchar ( 10), @parm2 smallint as
    Select * from PurOrdDet where PONbr = @parm1
         and LineNbr = @parm2
         order by PONbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_PONbr_LineNbr] TO [MSDSL]
    AS [dbo];

