--*************************************************************

--	Purpose:Market Totals for a specific date and week
--	Author: Charity Anderson
--	Date: 3/22/2005
--	Usage: Transporation Module
--	Parms: Date, CpnyID, SundayDate,PackerList
--	      
--*************************************************************
Create PROC [dbo].[pCF130PackerTotals]
		(@parm1 as smalldatetime,@parm2 as varchar(3), @parm3 as smalldatetime)

as

Select pt.ContactID,c.ContactName, sum(EstimatedQty) as TotalDay, TotalWeek
from cftPM pm join
cftContact c on pm.DestContactID=c.ContactID

JOIN (Select DestContactID as ContactID,
		isnull(sum(pm.EstimatedQty),0) as TotalWeek
		from cftPM pm 
		where pm.MovementDate between @parm3 and @parm3+6
		and pm.CpnyID=@parm2
		group by pm.DestContactID) as pt on pm.DestContactID=pt.ContactID
where pm.MovementDate=@parm1
		and pm.CpnyID=@parm2 

Group by pt.ContactID,c.ContactName,pt.TotalWeek
order by c.ContactName

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF130PackerTotals] TO [MSDSL]
    AS [dbo];

