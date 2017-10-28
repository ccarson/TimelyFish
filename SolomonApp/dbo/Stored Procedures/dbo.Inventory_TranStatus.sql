 /****** Object:  Stored Procedure dbo.Inventory_TranStatus    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Inventory_TranStatus    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Inventory_TranStatus @parm1 varchar ( 2) as
    Select * from Inventory where TranStatusCode = @parm1
    order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_TranStatus] TO [MSDSL]
    AS [dbo];

