



--*************************************************************
--	Purpose:Selection for each date grid
--		
--	Author: Charity Anderson
--	Date: 3/24/2005
--	Usage: Marketing 
--	Parms: Date, System, Company
--  Update: Added "order by PMID"  - DDahle 11/23/2011
--*************************************************************

--*************************************************************
--    Purpose:Selection for each date grid
--          
--    Author: Charity Anderson
--    Date: 3/24/2005
--    Usage: Marketing 
--    Parms: Date, System, Company
--  Update: Added "order by PMID"  - DDahle 11/23/2011
--  Update: Added "BioSecurityLevel" - NHonetschlager 1/15/14
--*************************************************************

CREATE PROC [dbo].[pXT300PMSpecDate_20150121]
      (@parm1 as smalldatetime,@parm2 as varchar(2), @parm3 as varchar(3))
AS
Select pm.*,s.ContactName as Source, d.ContactName as Destination, st.BioSecurityLevel

from cftPM pm WITH (NOLOCK) 
LEFT JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
LEFT JOIN [CentralData].[dbo].[Site] st WITH (NOLOCK) on pm.SourceContactID=st.ContactID
where pm.MovementDate=@parm1
and PMTypeID='02'
and PMSystemID like @parm2
order by PMID
--and CpnyID=@parm3




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT300PMSpecDate_20150121] TO [SOLOMON]
    AS [dbo];

