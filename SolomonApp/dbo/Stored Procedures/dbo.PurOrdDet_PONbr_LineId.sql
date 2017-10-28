 Create Proc PurOrdDet_PONbr_LineId @parm1 varchar ( 10), @parm2 smallint as
    Select * from PurOrdDet where PONbr = @parm1
         and LineId = @parm2
         order by PONbr, LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_PONbr_LineId] TO [MSDSL]
    AS [dbo];

