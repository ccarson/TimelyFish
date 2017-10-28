 /****** Object:  Stored Procedure dbo.APDoc_VendId_InvcNbr    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APDoc_VendId_InvcNbr @parm1 varchar ( 15), @parm2 varchar ( 15), @parm3 varchar ( 10) as
Select * from APDoc where VendId = @parm1 and InvcNbr = @parm2
and Status <> "V" and RefNbr <> @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_VendId_InvcNbr] TO [MSDSL]
    AS [dbo];

