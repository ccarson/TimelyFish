Create Proc Location_SiteID_InvtId
@parm1 varchar ( 10), 
@parm2 varchar ( 30) as
Select InvtId, Sum(QtyAlloc), Sum(QtyAvail), SiteId, WhseLoc, '' 
from Location 
where SiteID = @parm1 
	and InvtId = @parm2
group by SiteID, WhseLoc, InvtID

