 Create Proc INTran_BatNbr @parm1 varchar ( 10) as
    Select *
	from INTran
		left outer join Inventory
			on Intran.InvtId = Inventory.InvtId
    where INTran.BatNbr = @parm1
        and INTran.Rlsed = 0
    order by BatNbr, INTran.InvtId, SiteId, WhseLoc, RefNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr] TO [MSDSL]
    AS [dbo];

