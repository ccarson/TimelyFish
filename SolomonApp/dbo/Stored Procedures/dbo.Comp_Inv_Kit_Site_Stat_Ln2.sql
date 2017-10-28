 /****** Object:  Stored Procedure dbo.Comp_Inv_Kit_Site_Stat_Ln2    ******/
Create Proc Comp_Inv_Kit_Site_Stat_Ln2 @parm1 varchar ( 30),@parm2 varchar ( 10),
        @parm3 varchar ( 1),@parm4beg smallint,@parm4end smallint as
        Select * from Component, Inventory where
        	KitID = @parm1 And
		KitSiteID = @parm2 And
        	KitStatus = @parm3 And
		LineNbr Between @parm4beg and @parm4end And
		Inventory.Invtid = Component.CmpnentID
        Order by Component.KitID, Component.KitSiteID, Component.KitStatus,
		 Component.LineNbr, Component.Cmpnentid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Inv_Kit_Site_Stat_Ln2] TO [MSDSL]
    AS [dbo];

