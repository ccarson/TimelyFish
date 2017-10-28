--*************************************************************
--	Purpose:Selection for each date grid
--		
--	Author: Charity Anderson
--	Date: 2/8/2005
--	Usage: FlowBoardModule 
--	Parms: Date, System, Company
--*************************************************************

CREATE PROC dbo.pCF100PMSpecDate
	(@parm1 as smalldatetime,@parm2 as varchar(2), @parm3 as varchar(3))
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm 
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
where pm.MovementDate=@parm1
and PMTypeID='01'
and PMSystemID like @parm2
and CpnyID=@parm3

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100PMSpecDate] TO [MSDSL]
    AS [dbo];

