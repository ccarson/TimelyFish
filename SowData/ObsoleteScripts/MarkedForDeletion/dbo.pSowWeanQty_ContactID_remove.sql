Create proc dbo.[pSowWeanQty_ContactID_remove]
(@parm1 as smalldatetime)
as 
Select  f.ContactID, sum(Qty) as WeanQty 
from SowWeanEvent w
JOIN FarmSetup f on f.FarmID=w.FarmID where WeekOfDate=@parm1
Group by f.ContactID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pSowWeanQty_ContactID_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pSowWeanQty_ContactID_remove] TO [se\analysts]
    AS [dbo];

