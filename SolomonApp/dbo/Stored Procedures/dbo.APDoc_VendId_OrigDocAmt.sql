 /****** Object:  Stored Procedure dbo.APDoc_VendId_OrigDocAmt    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APDoc_VendId_OrigDocAmt @parm1 varchar ( 15), @parm2 float, @parm3 varchar ( 10) as
Select * from APDoc where VendId = @parm1
and Status <> "V"
and DocClass = 'N'
and CuryOrigDocAmt = @parm2
and RefNbr <> @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_VendId_OrigDocAmt] TO [MSDSL]
    AS [dbo];

