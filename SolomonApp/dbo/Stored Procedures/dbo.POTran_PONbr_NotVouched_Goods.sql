 
Create proc POTran_PONbr_NotVouched_Goods @parm1 varchar ( 10) as
        Select * from POTran where PONbr = @parm1
            and VouchStage <> 'F'
			and PurchaseType in ('GI','GP','GS','GN','PS','PI','MI','FR')
            Order by PONbr, RcptNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_PONbr_NotVouched_Goods] TO [MSDSL]
    AS [dbo];

