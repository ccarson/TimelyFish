 /****** Object:  Stored Procedure dbo.Inventory_ClassId    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Inventory_ClassId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc Inventory_ClassId @parm1 varchar ( 6) as
    Select * from Inventory where ClassId = @parm1 order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_ClassId] TO [MSDSL]
    AS [dbo];

