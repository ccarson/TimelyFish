
Create Procedure Vendor_All_w @parm1 varchar ( 15) as
Select vendid, name, status, terms, dfltbox, apacct, apsub, taxid00, taxid01, taxid02, taxid03,
	expacct, expsub, paydatedflt, Vend1099
from Vendor where VendId = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Vendor_All_w] TO [MSDSL]
    AS [dbo];

