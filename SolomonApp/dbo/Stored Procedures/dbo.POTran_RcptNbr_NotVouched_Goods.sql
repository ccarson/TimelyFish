 
Create proc POTran_RcptNbr_NotVouched_Goods @parm1 varchar ( 10) as
        Select * from POTran where RcptNbr = @parm1
            and VouchStage <> 'F'
			and PurchaseType in ('GI','GP','GS','GN','PS','PI','MI','FR')
            Order by RcptNbr, PONbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_RcptNbr_NotVouched_Goods] TO [MSDSL]
    AS [dbo];

