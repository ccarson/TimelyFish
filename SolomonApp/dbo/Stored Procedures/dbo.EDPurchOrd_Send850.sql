 CREATE Proc EDPurchOrd_Send850 As
Select A.PONbr From PurchOrd A Inner Join EDPurchOrd B On A.PONbr = B.PONbr Where Exists (Select *
From EDVOutbound Where Trans = '850' And VendId = A.VendId) And B.LastEDIDate = '01/01/1900' And
A.Status = 'O'


