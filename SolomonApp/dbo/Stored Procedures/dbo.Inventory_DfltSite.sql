 /****** Object:  Stored Procedure dbo.Inventory_DfltSite    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Inventory_DfltSite    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Inventory_DfltSite @parm1 varchar ( 10) as
    Select * from Inventory where DfltSite = @parm1 order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_DfltSite] TO [MSDSL]
    AS [dbo];

