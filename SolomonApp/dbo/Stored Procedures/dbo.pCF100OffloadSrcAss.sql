--*************************************************************
--	Purpose:Offloads assigned to a movement
--	Author: Charity Anderson
--	Date: 3/1/2005
--	Usage: Flow Board
--	Parms: DestPMID
--	      
--*************************************************************

CREATE PROC dbo.pCF100OffloadSrcAss
	(@parm1 as int)
	
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm 
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
JOIN cftPigOffload o on pm.ID=o.SrcPMID
where o.DestPMID=@parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100OffloadSrcAss] TO [MSDSL]
    AS [dbo];

