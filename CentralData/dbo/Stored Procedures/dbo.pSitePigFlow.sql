CREATE PROC [dbo].[pSitePigFlow] 
		@BegDate smalldatetime,
		@PigFlowID smallint,
		@PhaseID smallint
AS
Select spf.SitePigFlowID,c.ContactName as SiteName,c.ContactID, pf.Description as PigFlowName, 
	dspf.EffectiveDate,ft.FacilityTypeDescription, spf.SiteOrderCode
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
WHERE spf.PigFlowID=@PigFlowID
Order by c.ContactName
