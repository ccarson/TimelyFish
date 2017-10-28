--*************************************************************
--	Purpose:Offloads with Offload as a Source
--	Author: Charity Anderson
--	Date: 3/1/2005
--	Usage: Flow Board
--	Parms: MovementDate
--	      
--*************************************************************

CREATE PROC dbo.pXT100OffloadSrc
	(@parm1 as smalldatetime,@parm2 as int, @parm3 as varchar(3))
	
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm 
LEFT JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
LEFT JOIN cftPigOffload o on pm.id=o.DestPMID and o.SrcPMID=@parm2
where pm.MovementDate=@parm1 
and o.DestPMID is null
and left(TranSubTypeID,1)='O'
--and PMTypeID='01'
--and CpnyID=@parm3
--and pm.ID not in (Select DestPMID from cftPigOffload where SrcPMID=@parm2)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100OffloadSrc] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100OffloadSrc] TO [MSDSL]
    AS [dbo];

