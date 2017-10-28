 /****** Object:  Stored Procedure dbo.Delete_AssyDoc_BatNbr    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.Delete_AssyDoc_BatNbr    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc Delete_AssyDoc_BatNbr @parm1 varchar ( 10) as

    Exec Delete_LotSerT_BatNbr @Parm1

    Delete INTran from INTran where BatNbr = @parm1 and Rlsed = 0

    Delete AssyDoc from AssyDoc where AssyDoc.BatNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_AssyDoc_BatNbr] TO [MSDSL]
    AS [dbo];

