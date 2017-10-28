 Create Proc Comp_Kit_Site_Stat_Ln4 @parm1 varchar ( 30),@parm2 varchar ( 10),
	@parm3 varchar ( 1),@parm4 smallint,@parm5 varchar ( 30) as
	Select Component.*, Inventory.* from Component, Inventory where
	Component.Kitid = @parm1
	and Component.KitSiteid = @parm2
	and Component.kitstatus = @parm3
	and Component.linenbr = @parm4
	and Component.cmpnentid = @parm5
      and Component.cmpnentid = Inventory.invtid
      Order by Component.Kitid,Component.Linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_Site_Stat_Ln4] TO [MSDSL]
    AS [dbo];

