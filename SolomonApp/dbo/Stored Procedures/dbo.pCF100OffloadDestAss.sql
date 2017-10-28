--*************************************************************
--	Purpose:Offloads assigned to a movement
--	Author: Charity Anderson
--	Date: 3/1/2005
--	Usage: Flow Board
--	Parms: SourcePMID
--	      
--*************************************************************

CREATE PROC dbo.pCF100OffloadDestAss
	(@parm1 as int)
	
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm 
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
JOIN cftPigOffload o on pm.ID=o.DestPMID
where o.SrcPMID=@parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100OffloadDestAss] TO [MSDSL]
    AS [dbo];

