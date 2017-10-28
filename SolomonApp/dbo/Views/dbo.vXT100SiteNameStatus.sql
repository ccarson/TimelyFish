--*************************************************************
--	Purpose:Site Name with Status
--	Author: Charity Anderson
--	Date: 12/12/2005
--	Usage: Pig Flow 
--	Parms: 
--	      
--*************************************************************
CREATE VIEW dbo.vXT100SiteNameStatus	
AS

Select c.ContactId, 
ContactName=
Case when Len(rtrim(ContactName)) > 23 then ShortName else ContactName end,
	s.SolomonProjectID
	from cftSite s 
		JOIN cftContact c on c.ContactId = s.ContactId
	where c.StatusTypeID=1 
