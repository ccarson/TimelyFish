CREATE PROC [dbo].[pSitePigFlowAll] 
		@BegDate smalldatetime
AS
Select spf.SitePigFlowID,pf.OrderCode,c.ContactName as SiteName,c.ContactID, pf.Description as PigFlowName,
	pp.ProductionPhaseDescription as ProductionPhase, pp.ProductionPhaseOrderCode, 
	dspf.EffectiveDate,ft.FacilityTypeDescription, ft.FacilityTypeID, ps.ProductionSystemDescription, 
	ISNULL(spf.SiteOrderCode,1) as SiteOrderCode
FROM
SitePigFlow spf
JOIN
(Select Max(EffectiveDate) as EffectiveDate, ContactID,ProductionPhaseID FROM SitePigFlow
	WHERE EffectiveDate<=@BegDate
	GROUP BY ContactID,ProductionPhaseID) dspf
ON spf.EffectiveDate=dspf.EffectiveDate and spf.ContactID=dspf.ContactID and spf.ProductionPhaseID=dspf.ProductionPhaseID
JOIN  dbo.Contact c on spf.ContactID =c.ContactID
JOIN PigFlow pf on pf.PigFlowID=spf.PigFlowID
JOIN ProductionSystem ps on ps.ProductionSystemID=pf.MovementSystem
JOIN  dbo.Site s on s.ContactID=spf.ContactID
JOIN FacilityType ft ON ft.FacilityTypeID=s.FacilityTypeID
JOIN ProductionPhase pp on pp.ProductionPhaseID=spf.ProductionPhaseID
Order by c.ContactName
