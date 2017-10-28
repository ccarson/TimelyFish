

-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/21/2008
-- Updated date: 2/1/2013 by BMD - added additional information
-- Description:	replaces a bulk of work in a query used in the Agronomy database that pulls up Manure App Summary Report
-- =============================================
CREATE View [dbo].[cfv_AGRONOMY_MANURE_APPLICATION_PLAN_SUMMARY]
AS

SELECT
	ManureApplicationPlan.ManureApplicationPlanID
,	ManureApplicationPlan.ApplicationPlanStatus
,	ApplicationSeasons.ApplicationSeasonDescription
,	ManureApplicationPlan.ApplicationYear
,	CFFContact.ShortName 'CFFContact'
,	OperatorContact.ContactName 'FieldOperator'
,   operatorAddress.address1 'FieldOperatorAddress'
,   operatorAddress.city 'FieldOperatorCity'
,   operatorAddress.state 'FieldOperatorState'
,   operatorAddress.zip 'FieldOperatorZip'
,	Field.FieldName
,   Field.county
,   Field.township
,   Field.sectionnbr
,   Field.Range
,	SiteContact.ContactName 'Site'
,   siteaddress.address1 'SiteAddress'
,   siteaddress.city 'SiteCity'
,   siteaddress.state 'SiteState'
,   siteaddress.zip 'SiteZip'
,	FirstManureStructureDescription.Description 'StructureType'
,	ApplicationFirmContact.ContactName 'ApplicationFirm'
,   ApplicationFirmAddress.address1 'ApplicationFirmAddress'
,   ApplicationFirmAddress.city 'ApplicationFirmCity'
,   ApplicationFirmAddress.state 'ApplicationFirmState'
,   ApplicationFirmAddress.zip 'ApplicationFirmZip'
,	MIN(ManureMovementDetail.MovementDate) 'StartDate'
,	MAX(ManureMovementDetail.MovementDate) 'EndDate'
,	SumManureApplicationPlanQty.Qty 'GallonsApplied'
,	ManureApplicationPlan.ActualAcresCovered
,   ManureApplicationPlan.ActualAppRatePerAcre
,	ApplicationFirmInvoiceTotal.InvoiceTotal
,	MilesMatrixSiteToField.OneWayMiles
,	ManureValue.TotalManureValue
,   ManureSample.DateSampled 'SampleDate'
,	ManureApplicationPlan.SampleDescription
,   round(NSampleDetail.[AnalyteValue],0) 'Sample_N'
,   round(P2O5SampleDetail.[AnalyteValue],0) 'Sample_P2O5'
,   round(K2OSampleDetail.[AnalyteValue],0) 'Sample_K2O'
,	ManureApplicationPlan.PreviousCropID
,	ManureApplicationPlan.PlannedCropID
,	ManureApplicationPlan.YieldGoal
,	Nitrogen.NitAvailPer1000
,	Nitrogen.NitAvailPerAcre
,	Phosphorous.PhosAvailPer1000
,	Phosphorous.PhosAvailPerAcre
,	Potassium.PotAvailPer1000
,	Potassium.PotAvailPerAcre
,	ManureApplicationMethod.Description 'PlanApplicationMethod'


FROM	dbo.ManureApplicationPlan ManureApplicationPlan (NOLOCK)
LEFT OUTER JOIN dbo.ApplicationSeasons ApplicationSeasons (NOLOCK)
	ON	ApplicationSeasons.ApplicationSeasonID = ManureApplicationPlan.ApplicationSeasonID
Left Outer Join dbo.Sample ManureSample (NOLOCK)
    on  ManureApplicationPlan.manuresampleid=ManureSample.sampleid
Left Outer Join dbo.ManureApplicationPlanAnalyteDetail NSampleDetail (NOLOCK)
    on  ManureApplicationPlan.ManureApplicationPlanId=NSampleDetail.ManureApplicationPlanId and NSampleDetail.analyteid in (3)
Left Outer Join dbo.ManureApplicationPlanAnalyteDetail P2O5SampleDetail (NOLOCK)
    on  ManureApplicationPlan.ManureApplicationPlanId=P2O5SampleDetail.ManureApplicationPlanId and P2O5SampleDetail.analyteid in (4)
Left Outer Join dbo.ManureApplicationPlanAnalyteDetail K2OSampleDetail (NOLOCK)
    on  ManureApplicationPlan.ManureApplicationPlanId=K2OSampleDetail.ManureApplicationPlanId and K2OSampleDetail.analyteid in (5)
LEFT OUTER JOIN dbo.Contact CFFContact (NOLOCK)
	ON	CFFContact.ContactID = ManureApplicationPlan.CFFContactID
LEFT OUTER JOIN dbo.Contact OperatorContact (NOLOCK)
	ON	OperatorContact.ContactID = ManureApplicationPlan.OperatorContactID
left outer join dbo.ContactAddress operatorContactAddress (NOLOCK)
    on operatorContactAddress.contactid = operatorcontact.contactid  and operatorContactAddress.addresstypeid=1
left outer join dbo.address operatorAddress (NOLOCK)
    on operatorAddress.addressid = operatorContactAddress.addressid
LEFT OUTER JOIN dbo.Field Field (NOLOCK)
	ON	Field.FieldID = ManureApplicationPlan.FieldID
LEFT OUTER JOIN dbo.Contact SiteContact (NOLOCK)
	ON	SiteContact.ContactID = ManureApplicationPlan.SiteContactID
left outer join dbo.contactaddress ContactAddress (NOLOCK)
    ON sitecontact.contactid=contactaddress.ContactID  and contactaddress.AddressTypeID = 1
left outer join dbo.address siteaddress (NOLOCK)
    on siteaddress.addressid=contactaddress.AddressID
LEFT OUTER JOIN dbo.Contact ApplicationFirmContact (NOLOCK)
	ON	ApplicationFirmContact.ContactID = ManureApplicationPlan.ApplicationFirmContactID
left outer join dbo.contactaddress ApplicationFirmContactAddress (NOLOCK)
    on ApplicationFirmContactAddress.contactid=ApplicationFirmContact.contactid and ApplicationFirmContactAddress.addresstypeid = 1
left outer join dbo.address ApplicationFirmAddress (NOLOCK)
    on ApplicationFirmAddress.addressid=ApplicationFirmContactAddress.addressid
INNER JOIN	dbo.ManureMovement ManureMovement (NOLOCK)
	ON	ManureMovement.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
INNER JOIN	dbo.ManureMovementDetail ManureMovementDetail (NOLOCK)
	ON	ManureMovementDetail.ManureMovementID = ManureMovement.ManureMovementID
LEFT OUTER JOIN	dbo.ManureApplicationMethod ManureApplicationMethod (NOLOCK)
	ON	ManureApplicationMethod.ManureApplicationMethodID = ManureApplicationPlan.ApplicationMethodID
LEFT OUTER JOIN dbo.[MilesMatrix-SiteToField] MilesMatrixSiteToField (NOLOCK)
	ON	MilesMatrixSiteToField.SiteContactID = ManureApplicationPlan.SiteContactID
	AND	MilesMatrixSiteToField.FieldID = ManureApplicationPlan.FieldID
--FirstManureStructureDescription...
LEFT OUTER JOIN (SELECT ManureApplicationPlan.ManureApplicationPlanID, 
			MIN(ManureStructureType.ManureStructTypeID) 'minid', 
			ManureStructureType.Description
		FROM dbo.ManureApplicationPlan ManureApplicationPlan (NOLOCK)
		INNER JOIN (SELECT ManureApplicationPlanID, MIN(ManureStructureID) 'ManureStructureID' FROM dbo.ManureApplicationPlanStructureDetail (NOLOCK)
				GROUP BY ManureApplicationPlanID) ManureApplicationPlanStructureDetail_MIN
			ON ManureApplicationPlanStructureDetail_MIN.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
		INNER JOIN dbo.ManureStructure ManureStructure (NOLOCK)
			ON ManureStructure.ManureStructureID = ManureApplicationPlanStructureDetail_MIN.ManureStructureID
		INNER JOIN dbo.ManureStructureType ManureStructureType (NOLOCK)
			ON ManureStructureType.ManureStructTypeID = ManureStructure.ManureStructTypeID
		GROUP BY ManureApplicationPlan.ManureApplicationPlanID, ManureStructureType.Description) FirstManureStructureDescription
	ON FirstManureStructureDescription.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
--SumManureApplicationPlanQty...
LEFT OUTER JOIN (SELECT ManureApplicationPlan.ManureApplicationPlanID, 
			SUM(ManureMovementDetail.Qty) 'Qty' 
		FROM dbo.ManureApplicationPlan ManureApplicationPlan (NOLOCK)
		INNER JOIN dbo.ManureMovement ManureMovement (NOLOCK)
			ON ManureMovement.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
		INNER JOIN dbo.ManureMovementDetail ManureMovementDetail (NOLOCK)
			ON ManureMovementDetail.ManureMovementID = ManureMovement.ManureMovementID
		GROUP BY ManureApplicationPlan.ManureApplicationPlanID) SumManureApplicationPlanQty
	ON SumManureApplicationPlanQty.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
--ApplicationFirmInvoiceTotal...
LEFT OUTER JOIN (SELECT ManureAppInvoiceHeader.ManureApplicationPlanID, 
			SUM(ManureAppInvoiceDetail.ManureAppRate * ManureAppInvoiceDetail.ManureAppDetailQty) 'InvoiceTotal' 
		FROM dbo.ManureApplicationPlan (NOLOCK)
		INNER JOIN dbo.ManureAppInvoiceHeader ManureAppInvoiceHeader (NOLOCK)
			ON ManureAppInvoiceHeader.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
		INNER JOIN dbo.ManureAppInvoiceDetail ManureAppInvoiceDetail (NOLOCK)
			ON ManureAppInvoiceDetail.ManureAppInvoiceHeaderID = ManureAppInvoiceHeader.ManureAppInvoiceHeaderID
		GROUP BY ManureAppInvoiceHeader.ManureApplicationPlanID) ApplicationFirmInvoiceTotal
	ON ApplicationFirmInvoiceTotal.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
--ManureValue...
LEFT OUTER JOIN (SELECT ManureApplicationPlan.ManureApplicationPlanID,
			SUM((ManureMovementDetail.Qty / 1000) * ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga * ManureApplicationPlanAnalyteDetail.MarketValue) 'TotalManureValue' 
		FROM dbo.ManureApplicationPlan (NOLOCK)
		INNER JOIN dbo.ManureApplicationPlanAnalyteDetail ManureApplicationPlanAnalyteDetail (NOLOCK)
			ON ManureApplicationPlanAnalyteDetail.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
		INNER JOIN dbo.ManureMovement ManureMovement (NOLOCK)
			ON ManureMovement.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
		INNER JOIN dbo.ManureMovementDetail ManureMovementDetail (NOLOCK)
			ON ManureMovementDetail.ManureMovementID = ManureMovement.ManureMovementID
		GROUP BY ManureApplicationPlan.ManureApplicationPlanID) ManureValue
	ON ManureValue.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
--Nitrogen...
LEFT OUTER JOIN (SELECT	ManureApplicationPlan.ManureApplicationPlanID, 
			ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga 'NitAvailPer1000', 
			SUM(ManureApplicationPlan.ActualAppRatePerAcre * ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga / 1000) 'NitAvailPerAcre'
		FROM dbo.ManureApplicationPlan ManureApplicationPlan (NOLOCK)
		LEFT OUTER JOIN dbo.ManureApplicationPlanAnalyteDetail ManureApplicationPlanAnalyteDetail (NOLOCK)
			ON ManureApplicationPlanAnalyteDetail.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
		WHERE ManureApplicationPlanAnalyteDetail.AnalyteID = 3
		GROUP BY ManureApplicationPlan.ManureApplicationPlanID, 
			ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga) Nitrogen
	ON Nitrogen.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
--Phosphorous...
LEFT OUTER JOIN (SELECT	ManureApplicationPlan.ManureApplicationPlanID, 
			ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga 'PhosAvailPer1000', 
			SUM(ManureApplicationPlan.ActualAppRatePerAcre * ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga / 1000) 'PhosAvailPerAcre'
		FROM dbo.ManureApplicationPlan ManureApplicationPlan (NOLOCK)
		LEFT OUTER JOIN dbo.ManureApplicationPlanAnalyteDetail ManureApplicationPlanAnalyteDetail (NOLOCK)
			ON ManureApplicationPlanAnalyteDetail.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
		WHERE ManureApplicationPlanAnalyteDetail.AnalyteID = 4
		GROUP BY ManureApplicationPlan.ManureApplicationPlanID, 
			ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga) Phosphorous
	ON Phosphorous.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
--Potassium...
LEFT OUTER JOIN (SELECT	ManureApplicationPlan.ManureApplicationPlanID, 
			ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga 'PotAvailPer1000', 
			SUM(ManureApplicationPlan.ActualAppRatePerAcre * ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga / 1000) 'PotAvailPerAcre'
		FROM dbo.ManureApplicationPlan ManureApplicationPlan (NOLOCK)
		LEFT OUTER JOIN dbo.ManureApplicationPlanAnalyteDetail ManureApplicationPlanAnalyteDetail (NOLOCK)
			ON ManureApplicationPlanAnalyteDetail.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID
		WHERE ManureApplicationPlanAnalyteDetail.AnalyteID = 5
		GROUP BY ManureApplicationPlan.ManureApplicationPlanID, 
			ManureApplicationPlanAnalyteDetail.AnalyteAvailPer1000Ga) Potassium
	ON Potassium.ManureApplicationPlanID = ManureApplicationPlan.ManureApplicationPlanID

GROUP BY
	ManureApplicationPlan.ManureApplicationPlanID
,	ManureApplicationPlan.ApplicationPlanStatus
,	ApplicationSeasons.ApplicationSeasonDescription
,	ManureApplicationPlan.ApplicationYear
,	CFFContact.ShortName
,	OperatorContact.ContactName
,   operatorAddress.address1
,   operatorAddress.city
,   operatorAddress.state
,   operatorAddress.zip 
,	Field.FieldName
,   Field.county
,   Field.township
,   Field.sectionnbr
,   Field.Range
,	SiteContact.ContactName
,   siteaddress.address1
,   siteaddress.city
,   siteaddress.state
,   siteaddress.zip 
,	FirstManureStructureDescription.Description
,	ApplicationFirmContact.ContactName
,   ApplicationFirmAddress.address1
,   ApplicationFirmAddress.city
,   ApplicationFirmAddress.state
,   ApplicationFirmAddress.zip
,	SumManureApplicationPlanQty.Qty
,	ManureApplicationPlan.ActualAcresCovered
,   ManureApplicationPlan.ActualAppRatePerAcre
,	ApplicationFirmInvoiceTotal.InvoiceTotal
,	MilesMatrixSiteToField.OneWayMiles
,	ManureValue.TotalManureValue
,   ManureSample.DateSampled
,	ManureApplicationPlan.SampleDescription
,   round(NSampleDetail.[AnalyteValue],0)
,   round(P2O5SampleDetail.[AnalyteValue],0)
,   round(K2OSampleDetail.[AnalyteValue],0) 
,	ManureApplicationPlan.PreviousCropID
,	ManureApplicationPlan.PlannedCropID
,	ManureApplicationPlan.YieldGoal
,	Nitrogen.NitAvailPer1000
,	Nitrogen.NitAvailPerAcre
,	Phosphorous.PhosAvailPer1000
,	Phosphorous.PhosAvailPerAcre
,	Potassium.PotAvailPer1000
,	Potassium.PotAvailPerAcre
,	ManureApplicationMethod.Description

