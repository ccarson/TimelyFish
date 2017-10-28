--*************************************************************
--	Purpose:Offloads assigned to a movement
--	Author: Charity Anderson
--	Date: 3/1/2005
--	Usage: Flow Board
--	Parms: SourcePMID
--	      
--*************************************************************

CREATE PROC dbo.pXT100OffloadDestAss
	(@parm1 as int)
	
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm WITH (NOLOCK) 
LEFT JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
JOIN cftPigOffload o WITH (NOLOCK) on pm.ID=o.DestPMID
where o.SrcPMID=@parm1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100OffloadDestAss] TO [SOLOMON]
    AS [dbo];

