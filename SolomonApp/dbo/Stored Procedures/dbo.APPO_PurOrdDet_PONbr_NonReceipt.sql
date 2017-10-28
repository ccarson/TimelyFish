 Create Proc APPO_PurOrdDet_PONbr_NonReceipt @parm1 varchar ( 10) as
    Select * from PurOrdDet where PONbr = @parm1
         and RcptStage <> 'X'


