CREATE PROC [dbo].[pUnAssignedSitePigFlow] 
		@BegDate smalldatetime
AS
Select s.ContactID,c.ContactName as SiteName,ft.FacilityTypeDescription
FROM
 dbo.Site s
JOIN  dbo.Contact c on c.ContactID=s.ContactID
LEFT JOIN  dbo.FacilityType ft on s.FacilityTypeID=ft.FacilityTypeID
WHERE s.ContactID NOT IN
(Select spf.ContactID From
SitePigFlow spf 
JOIN
(Select Max(EffectiveDate) as EffectiveDate, ContactID
	FROM SitePigFlow
	WHERE EffectiveDate <=@BegDate
	GROUP BY ContactID) dspf
ON spf.EffectiveDate=dspf.EffectiveDate and spf.ContactID=dspf.ContactID
WHERE spf.PigFlowID is not null)

ORDER BY c.ContactName
