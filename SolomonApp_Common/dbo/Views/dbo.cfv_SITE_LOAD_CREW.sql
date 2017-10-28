-- drop view cfv_SITE_LOAD_CREW
CREATE VIEW dbo.cfv_SITE_LOAD_CREW
AS
SELECT
s.LoadCrewID,
s.ContactID SiteContactID,
c.LoadCrewName,
s.AssignedFromDate,
case when s.AssignedToDate is null then '12/31/2020'
else s.AssignedToDate end AssignedToDate
FROM [$(CFApp)].dbo.cft_LOAD_CREW_SITES s
LEFT JOIN [$(CFApp)].dbo.cft_LOAD_CREW c
ON c.LoadCrewID = s.LoadCrewID
