 -- 11250
-- bkb 6/29/99
Create Proc Comp_Kit_Site_Stat_Seq @parm1 varchar ( 30),@parm2 varchar ( 10),
        @parm3 varchar ( 1), @parm4 varchar ( 5) as
        Select Component.*, Inventory.* from Component, Inventory where
        	Component.Kitid = @parm1
		and Component.KitSiteid = @parm2
        	and Component.kitstatus = @parm3
		and Component.Sequence like @parm4
        	and Component.cmpnentid = Inventory.invtid
        	Order by Component.Kitid, Component.KitSiteid, Component.KitStatus, Component.Sequence



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_Site_Stat_Seq] TO [MSDSL]
    AS [dbo];

