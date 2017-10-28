 Create Procedure Vendor_APHist_FiscYr @parm1 varchar ( 15), @parm2 varchar ( 4) as
Select *
from Vendor
	left outer join APHist
		on Vendor.VendId = APHist.VendId
where Vendor.VendId = @parm1 and
	(APHist.FiscYr = @parm2 or APHist.FiscYr = '')
Order by Vendor.VendId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Vendor_APHist_FiscYr] TO [MSDSL]
    AS [dbo];

