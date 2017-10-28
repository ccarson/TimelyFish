 /****** Object:  Stored Procedure dbo.PurOrdDet_PONbr_NotVouched    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurOrdDet_PONbr_NotVouched @parm1 varchar ( 10) as
    Select * from PurOrdDet where PONbr = @parm1
         and VouchStage <> 'F'
         order by PONbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_PONbr_NotVouched] TO [MSDSL]
    AS [dbo];

