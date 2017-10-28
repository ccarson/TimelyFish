--*************************************************************

--	Purpose:PigGroup Totals for a specific date and week
--	Author: Charity Anderson
--	Date: 3/22/2005
--	Usage: Transporation Module
--	Parms: Date, CpnyID, SundayDate,UserID
--	      
--*************************************************************
Create PROC [dbo].[pXT310PGTotals]
		(@parm1 as smalldatetime,@parm2 as varchar(3), 
		@parm3 as smalldatetime,@parm4 as varchar(10))

as
DECLARE @UserID as varchar(11)
SET @UserID=rtrim(@parm4) + '%'

Select pg.PigGroupID,pg.Description as PigGroupName,
isnull(sum(pm.EstimatedQty),0) as TotalDay, w.TotalWeek
from cftPigGroup pg WITH (NOLOCK) 

	
JOIN (Select SourcePigGroupID,isnull(sum(EstimatedQty),0) as TotalWeek
	from cftPM WITH (NOLOCK) where PMSystemID like @parm2
	and (dbo.GetMarketSvcManager(SourceContactID,@parm1,'') like @UserID
		or dbo.GetSvcManager(SourceContactID,@parm1,'') like @UserID
	or Crtd_User like @parm4)
	and MovementDate between @parm3 and @parm3+6 and PMTypeID='02'
	Group by SourcePigGroupID) as w
on pg.PigGroupID=w.SourcePigGroupID

LEFT JOIN cftPM pm WITH (NOLOCK) on pg.PigGroupID=pm.SourcePigGroupID and pm.MovementDate=@parm1
and pm.PMSystemID like @parm2
and (dbo.GetMarketSvcManager(pm.SourceContactID,@parm1,'') like @UserID
		or dbo.GetSvcManager(pm.SourceContactID,@parm1,'') like @userID
	or pm.Crtd_User like @parm4 and pmTypeID='02')
group by pg.PigGroupID,pg.Description,w.totalWeek
Order by pg.Description
	
	

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT310PGTotals] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT310PGTotals] TO [MSDSL]
    AS [dbo];

