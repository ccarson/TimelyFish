CREATE PROC [dbo].[pUnAssignedSite] 
		@BegDate smalldatetime,
		@PigFlowID smallint,
		@PhaseID smallint
AS
Select s.ContactID,c.ContactName as SiteName,ft.FacilityTypeDescription
FROM
 dbo.Site s
JOIN  dbo.Contact c on c.ContactID=s.ContactID and c.StatusTypeID<>2
LEFT JOIN  dbo.FacilityType ft on s.FacilityTypeID=ft.FacilityTypeID
WHERE s.ContactID NOT IN
(Select c.ContactID
FROM
SitePigFlow spf
JOIN
(Select Max(EffectiveDate) as EffectiveDate, ContactID FROM SitePigFlow
	WHERE EffectiveDate<=@BegDate and ProductionPhaseID=@PhaseID
	GROUP BY ContactID,ProductionPhaseID) dspf
ON spf.EffectiveDate=dspf.EffectiveDate and spf.ContactID=dspf.ContactID
JOIN  dbo.Contact c on spf.ContactID =c.ContactID
JOIN PigFlow pf on pf.PigFlowID=spf.PigFlowID
JOIN  dbo.Site s on s.ContactID=spf.ContactID
LEFT JOIN FacilityType ft ON ft.FacilityTypeID=s.FacilityTypeID
WHERE spf.PigFlowID=@PigFlowID)

ORDER BY c.ContactName
