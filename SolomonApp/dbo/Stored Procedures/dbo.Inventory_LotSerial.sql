 /****** Object:  Stored Procedure dbo.Inventory_LotSerial    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Inventory_LotSerial    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Inventory_LotSerial @parm1 varchar ( 30) as
    Select * from Inventory where (lotsertrack = 'SI' or lotsertrack = 'LI') and
    InvtId like @parm1
    order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_LotSerial] TO [MSDSL]
    AS [dbo];

