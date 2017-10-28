 /****** Object:  Stored Procedure dbo.Delete_POReceipt    Script Date: 4/16/98 7:50:25 PM ******/
Create Proc Delete_POReceipt @parm1 varchar ( 6) as
    Delete from POReceipt where
        (POReceipt.PerClosed <= @parm1 and POReceipt.PerClosed <> '')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_POReceipt] TO [MSDSL]
    AS [dbo];

