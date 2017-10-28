CREATE VIEW dbo.vSiteManager 
AS
Select s.ContactName as ServiceManager, c.ContactName as Site
from (Select max(EffectiveDate) as EffectiveDate, SvcMgrContactID, SiteContactID from SiteSvcMgrAssignment
	where EffectiveDate<=getdate() group by SvcMgrContactID, SiteContactID ) as sma
join Contact s on sma.SvcMgrContactID=s.ContactID 
JOIN Contact c on sma.SiteContactID=c.ContactID
