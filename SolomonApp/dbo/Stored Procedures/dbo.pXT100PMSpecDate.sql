
--*************************************************************
--	Purpose:Selection for each date grid in flow board
--		
--	Author: Charity Anderson
--	Date: 2/8/2005
--	Usage: FlowBoardModule 
--	Parms: Date, System, Company
--*************************************************************

CREATE PROC dbo.pXT100PMSpecDate
	(@parm1 as smalldatetime,@parm2 as varchar(2), @parm3 as varchar(3))
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm 
LEFT JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
where pm.MovementDate=@parm1
and PMTypeID='01'
and PMSystemID like @parm2
--and CpnyID=@parm3
and (Highlight <> 255 and Highlight <> -65536)
order by PMID


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100PMSpecDate] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100PMSpecDate] TO [MSDSL]
    AS [dbo];

