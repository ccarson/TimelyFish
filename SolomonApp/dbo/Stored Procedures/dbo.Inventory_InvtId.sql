 /****** Object:  Stored Procedure dbo.Inventory_InvtId    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Inventory_InvtId    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Inventory_InvtId @parm1 varchar ( 30) as
        Select * from Inventory where InvtId = @parm1


