 /****** Object:  Stored Procedure dbo.PurOrdDet_PONbr_LineRef    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurOrdDet_PONbr_LineRef @parm1 varchar ( 10), @parm2 varchar ( 05) As
        Select * from PurOrdDet
            where PONbr = @parm1
              And LineRef Like @parm2
              And PurchaseType IN ('DL','FR','GI','GP','GS','MI','GN','PI','PS')
        Order By POnbr, LineRef, InvtId, QtyOrd, QtyRcvd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_PONbr_LineRef] TO [MSDSL]
    AS [dbo];

