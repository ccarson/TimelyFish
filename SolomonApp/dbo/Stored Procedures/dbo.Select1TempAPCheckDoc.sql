 /****** Object:  Stored Procedure dbo.Select1TempAPCheckDoc    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Select1TempAPCheckDoc @parm1 varchar ( 15), @parm2 varchar ( 15) As
Select * From APDoc
Where APDoc.VendId = @parm1 and
APDoc.InvcNbr = @parm2 and
APDoc.Status = 'T' and
APDoc.Acct = '' and
APDoc.Sub = '' and
APDoc.RefNbr = ''
Order By APDoc.VendId, APDoc.InvcNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Select1TempAPCheckDoc] TO [MSDSL]
    AS [dbo];

