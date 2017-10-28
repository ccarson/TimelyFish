--*************************************************************
--	Purpose:View to determine Sites that Share ICAs
--		
--	Author: Charity Anderson
--	Date: 6/28/2005
--	Usage: Transportation Module	 
--	Parms: none
--*************************************************************

CREATE VIEW dbo.vXT100ICAShare

AS
SELECT     s.ContactID as SourceContactID, ICA.ContactID as OtherContactID,
			s.SiteMgrContactID
FROM         dbo.cftSite s 
LEFT JOIN dbo.cftSite ICA on
ICA.ContactID <> s.ContactID AND ICA.SiteMgrContactID = s.SiteMgrContactID
and s.SiteMgrContactID>''

