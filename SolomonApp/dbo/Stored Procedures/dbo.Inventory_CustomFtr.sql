 /****** Object:  Stored Procedure dbo.Inventory_CustomFtr    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Inventory_CustomFtr    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc Inventory_CustomFtr @parm1 varchar ( 30) as
        Select * from Inventory where InvtID LIKE @parm1 and
                CustomFtr = 1
                order by InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_CustomFtr] TO [MSDSL]
    AS [dbo];

