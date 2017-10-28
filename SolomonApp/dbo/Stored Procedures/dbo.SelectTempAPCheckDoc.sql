 /****** Object:  Stored Procedure dbo.SelectTempAPCheckDoc    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure SelectTempAPCheckDoc @parm1 varchar ( 15) As
Select * From APDoc
Where APDoc.VendId = @parm1 and
APDoc.Status = 'T' and
APDoc.Acct = '' and
APDoc.Sub = '' and
APDoc.RefNbr = ''
Order By APDoc.VendId, APDoc.InvcNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SelectTempAPCheckDoc] TO [MSDSL]
    AS [dbo];

