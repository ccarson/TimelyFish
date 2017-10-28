 /****** Object:  Stored Procedure dbo.TempCheckDocAll    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure TempCheckDocAll As
Select * From APDoc Where
RefNbr = '' and
DocType = 'CK' and
Status = 'T'
Order By APDoc.VendId, APDoc.InvcNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TempCheckDocAll] TO [MSDSL]
    AS [dbo];

