 Create Proc PurOrdDet_PONbr_LineRef2 @parm1 varchar ( 10), @parm2 varchar ( 05) As
        Select * from PurOrdDet where
                PONbr = @parm1 And
                LineRef = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_PONbr_LineRef2] TO [MSDSL]
    AS [dbo];

