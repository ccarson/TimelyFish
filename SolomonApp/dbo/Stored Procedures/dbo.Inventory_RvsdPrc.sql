 /****** Object:  Stored Procedure dbo.Inventory_RvsdPrc    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Inventory_RvsdPrc    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Inventory_RvsdPrc @parm1 varchar ( 30) as
    Select * from Inventory where RvsdPrc = 1 and
        InvtId like @parm1
        order by InvtId, RvsdPrc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_RvsdPrc] TO [MSDSL]
    AS [dbo];

