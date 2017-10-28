 /****** Object:  Stored Procedure dbo.Delete_Location    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Delete_Location    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc Delete_Location @parm1 varchar ( 30) as
    Delete location from Location where
                InvtId = @parm1 and
                QtyOnHand = 0.00 and
                QtyAlloc = 0.00



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_Location] TO [MSDSL]
    AS [dbo];

