
Create Proc [dbo].[APPO_PurOrdDet_PONbr_NotVouch_NoRcptExp] @parm1 varchar ( 10) as
    Select * from PurOrdDet where PONbr = @parm1
         and VouchStage <> 'F'
         and RcptStage = 'X'
		 and PurchaseType <> 'DL'
 	and not exists(select 'x' from aptran where
		ponbr = @parm1 and
		APTran.POLineRef = PurOrdDet.LineRef and
		aptran.rlsed = 0)
        order by PONbr, LineNbr
