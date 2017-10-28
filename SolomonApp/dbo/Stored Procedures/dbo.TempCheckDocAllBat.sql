 /****** Object:  Stored Procedure dbo.TempCheckDocAllBat    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure TempCheckDocAllBat As
Select * From APDoc (NOLOCK) Where
BatNbr = '' and
RefNbr = '' and
DocType = 'CK' and
Status = 'T'
Order By APDoc.VendId, APDoc.InvcNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TempCheckDocAllBat] TO [MSDSL]
    AS [dbo];

