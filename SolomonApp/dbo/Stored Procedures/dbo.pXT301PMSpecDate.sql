

--*************************************************************
--	Purpose:Service Market Selection for each date 
--		
--	Author: Charity Anderson
--	Date: 3/31/2005
--	Usage: Service Market Module 
--	Parms: Date, UserName, Company
--  Update: Added order by PMID DDahle 11/23/2011
--*************************************************************

CREATE PROC [dbo].[pXT301PMSpecDate]
	(@parm1 as smalldatetime,@parm2 as varchar(10), @parm3 as varchar(3))
AS
DECLARE @UserID as varchar(11)
SET @UserID=rtrim(@parm2) + '%'
Select pm.*,s.ContactName as Source, d.ContactName as Destination

from cftPM pm WITH (NOLOCK) 
LEFT JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
where pm.MovementDate=@parm1
and PMTypeID='02'
and (dbo.GetMarketSvcManager(pm.SourceContactID,@parm1,'') like @UserID
	or dbo.GetSvcManager(pm.SourceContactID,@parm1,'') like @UserID
	or dbo.GetMarketSvcManager(pm.DestContactID,@parm1,'') like @UserID
	or dbo.GetSvcManager(pm.DestContactID,@parm1,'') like @UserID
	or pm.Crtd_User like @parm2)
and PMSystemID like @parm3
and (Highlight <> 255 and Highlight <> -65536)
order by PMID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT301PMSpecDate] TO [MSDSL]
    AS [dbo];

