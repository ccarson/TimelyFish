 Create Procedure APVoidCheck_Vendor_BatNbr @parm1 varchar ( 10) As
Select *
from APDoc
	left outer join Vendor
		on APDoc.VendId = Vendor.VendId
Where APDoc.BatNbr = @parm1
And APDoc.DocType <> 'SC'
Order By APDoc.BatNbr, APDoc.RefNbr


