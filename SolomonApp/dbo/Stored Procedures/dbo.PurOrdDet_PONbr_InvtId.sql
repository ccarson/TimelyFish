 /****** Object:  Stored Procedure dbo.PurOrdDet_PONbr_InvtId    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurOrdDet_PONbr_InvtId @parm1 varchar ( 10), @parm2 varchar ( 30) as
    Select * from PurOrdDet where PONbr = @parm1
         and InvtId = @parm2
         order by InvtId, PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_PONbr_InvtId] TO [MSDSL]
    AS [dbo];

