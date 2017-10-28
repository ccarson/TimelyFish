--*************************************************************
--	Purpose:Offloads assigned to a movement
--	Author: Charity Anderson
--	Date: 3/1/2005
--	Usage: Flow Board
--	Parms: DestPMID
--	      
--*************************************************************

CREATE PROC dbo.pXT100OffloadSrcAss
	(@parm1 as int)
	
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm WITH (NOLOCK) 
LEFT JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
JOIN cftPigOffload o WITH (NOLOCK) on pm.ID=o.SrcPMID
where o.DestPMID=@parm1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100OffloadSrcAss] TO [SOLOMON]
    AS [dbo];

