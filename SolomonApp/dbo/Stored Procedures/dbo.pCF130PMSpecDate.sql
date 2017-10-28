--*************************************************************
--	Purpose:Market Selection for each date 
--		
--	Author: Charity Anderson
--	Date: 3/16/2005
--	Usage: Market Module 
--	Parms: Date, System, Company
--*************************************************************

CREATE PROC dbo.pCF130PMSpecDate
	(@parm1 as smalldatetime,@parm2 as varchar(2), @parm3 as varchar(3))
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm 
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
where pm.MovementDate=@parm1
and PMTypeID='02'
and PMSystemID like @parm2
and CpnyID=@parm3

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF130PMSpecDate] TO [MSDSL]
    AS [dbo];

