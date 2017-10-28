 /****** Object:  Stored Procedure dbo.DeleteTempCheckDoc    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure DeleteTempCheckDoc As
Delete From APDoc Where
BatNbr = '' and
RefNbr = '' and
DocType = 'CK' and
Status = 'T'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteTempCheckDoc] TO [MSDSL]
    AS [dbo];

