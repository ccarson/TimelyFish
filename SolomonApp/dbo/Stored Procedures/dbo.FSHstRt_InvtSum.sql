 Create Proc FSHstRt_InvtSum @parm1beg varchar ( 10), @parm1end varchar ( 10), @parm2beg varchar ( 24), @parm2end varchar ( 24) as
Select Sum(ItemSite.TotCost), Sum(ItemSite.BMITotCost)
from Inventory, ItemSite
where Inventory.InvtId = ItemSite.InvtId
and   (Inventory.InvtAcct between @parm1beg and @parm1end)
and   (Inventory.InvtSub  between @parm2beg and @parm2end)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FSHstRt_InvtSum] TO [MSDSL]
    AS [dbo];

