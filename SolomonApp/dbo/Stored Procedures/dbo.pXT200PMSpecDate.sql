

--*************************************************************
--    Purpose:Selection for date grid in Internal and Marketing
--          
--    Author: Charity Anderson
--    Date: 2/8/2005
--    Usage: FlowBoardModule 
--    Parms: Date, System, Company
--  Update: Added "order by PMID"  - DDahle 11/23/2011
--  Update: Added "Conflict check"  - DDahle 11/19/2013
--  Update: Removed "Conflict check"  - DDahle 1/2/2014
--  Update: Added "SourceBioSecurity, DestBioSecurity"  - DDahle 1/15/2014
--  Update: Changed to use the cftSiteBio Table for Bio security  - DDahle 11/4/2014
--*************************************************************

CREATE PROC [dbo].[pXT200PMSpecDate]
      (@parm1 as smalldatetime,@parm2 as varchar(2), @parm3 as varchar(3))
AS
Select pm.*
      ,s.ContactName as Source
      ,d.ContactName as Destination
      ,0 as Conflict
      ,rTrim(sb.BioSecurityLevel) + Case When lTrim(rTrim(isnull(sb.Challenge, ''))) = '' Then '' Else ' - '  +sb.Challenge End as SourceBioSecurity
      ,rTrim(db.BioSecurityLevel) + Case When lTrim(rTrim(isnull(db.Challenge, ''))) = '' Then '' Else ' - '  +db.Challenge End as DestBioSecurity

from cftPM pm 
LEFT JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
LEFT Join [SolomonApp].[dbo].[cftSiteBio] sb on pm.SourceContactID = sb.ContactID
LEFT Join [SolomonApp].[dbo].[cftSiteBio] db on pm.DestContactID = db.ContactID
where pm.MovementDate=@parm1
and PMTypeID='01'
and PMSystemID like @parm2
order by PMID






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT200PMSpecDate] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT200PMSpecDate] TO [MSDSL]
    AS [dbo];

