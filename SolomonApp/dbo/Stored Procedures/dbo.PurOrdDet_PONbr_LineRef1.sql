 /****** Object:  Stored Procedure dbo.PurOrdDet_PONbr_LineRef1    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurOrdDet_PONbr_LineRef1 @parm1 varchar ( 10), @parm2 varchar ( 05) As
        Select * from PurOrdDet where
                PONbr = @parm1 And
                VouchStage <> 'F'
                and PurchaseType in ('GD','SP','SE','SW')
                And LineRef Like @parm2
        Order By POnbr, LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_PONbr_LineRef1] TO [MSDSL]
    AS [dbo];

