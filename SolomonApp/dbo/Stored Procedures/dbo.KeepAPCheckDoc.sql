 /****** Object:  Stored Procedure dbo.KeepAPCheckDoc    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure KeepAPCheckDoc As
Select * From APDoc Where
BatNbr = '' and
Status = 'T'
and Acct <> ''
and Sub <> ''
and RefNbr <> ''
and DocType Not In ('MC', 'SC') Order By VendId, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[KeepAPCheckDoc] TO [MSDSL]
    AS [dbo];

