 Create Proc Inventory_History_Item2Hist
    @parm1 varchar ( 30),
    @parm2 varchar ( 10),
    @parm3 varchar ( 4)
as
Select * from Item2Hist
    where InvtId = @parm1
      and SiteId = @parm2
      and FiscYr = @parm3
    order by InvtId,SiteId,FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_History_Item2Hist] TO [MSDSL]
    AS [dbo];

