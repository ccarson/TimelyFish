 Create Procedure APDoc_Vendor @parm1 varchar ( 15) as
Select *
from APDoc
	left outer join Vendor
		on APDoc.VendId = Vendor.VendId
Where
APDoc.BatNbr = @parm1 and
APDoc.Rlsed = 0
Order by APDoc.BatNbr, APDoc.RefNbr


