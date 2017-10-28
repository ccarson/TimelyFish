 Create Procedure APDoc_DocTyp_RfNbr_Open_Rlsd_ @parm1 varchar ( 4), @parm2 varchar ( 10) as
Select *
from APDoc
	left outer join Vendor
		on APDoc.VendId = Vendor.VendId
Where
APDoc.DocType IN ('AC', 'AD', 'VO')
and APDoc.CuryId = @parm1
and APDoc.RefNbr LIKE  @parm2
and APDoc.OpenDoc  =  1
and APDoc.Rlsed    =  1
and APDoc.Selected =  1
Order by APDoc.OpenDoc, APDoc.Rlsed, APDoc.Selected, APDoc.Status, APDoc.RefNbr, APDoc.DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_DocTyp_RfNbr_Open_Rlsd_] TO [MSDSL]
    AS [dbo];

