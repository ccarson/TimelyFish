 /****** Object:  Stored Procedure dbo.POReceipt_bbatchqtytot    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POReceipt_bbatchqtytot @parm1 varchar ( 10) As
Select sum(rcptctrlqty) From POReceipt
   Where POReceipt.BatNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_bbatchqtytot] TO [MSDSL]
    AS [dbo];

