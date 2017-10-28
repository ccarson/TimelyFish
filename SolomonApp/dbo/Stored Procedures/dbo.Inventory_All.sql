 /****** Object:  Stored Procedure dbo.Inventory_All    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Inventory_All    Script Date: 4/16/98 7:41:51 PM ******/
CREATE Proc [dbo].[Inventory_All] @parm1 varchar ( 30) as
    Select * from Inventory where InvtId like @parm1 order by InvtId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_All] TO [MSDSL]
    AS [dbo];

