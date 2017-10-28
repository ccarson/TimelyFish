
--*************************************************************
--	Purpose: Joins foreign tables for site address info
--			to create a Health Paper Report
--	Author: Charity Anderson
--	Date:  4/28/2005
--	Usage: XT610 HealthPaper Report
--	Parms:
--*************************************************************
CREATE VIEW [dbo].[cfv_REPORT_INTERSTATE_PIG_MOVEMENTS]
AS
SELECT   Distinct 
sum(pm.EstimatedQty) as EstimatedQty,
pm.CpnyID,
pm.MovementDate,
pm.PMSystemID,
cs.ContactName as SourceFarm,
pm.PigGenderTypeID,
DestFarm= Case when o.SrcPMID is null then
	cd.ContactName
	else rtrim(oc.ContactName) + ' (' + rtrim(cd.ContactName) + ')' end,sa.Address1 as SAdd1,sa.Address2 as SAdd2,
pm.DestContactID,
sa.City as SCity,
sa.State as SState, 
sa.Zip as SZip,
sa.County as SCounty, 
sPremise=isnull(s.PremiseID,'N/A'), 
dPremise=Case when o.SrcPMID is null then
	isnull(d.PremiseID,'N/A')
	else
	isnull(ds.PremiseID,'N/A')
end,
DAdd1=Case when o.SrcPMID is null then
		da.Address1
		else do.Address1
	  end , 
DAdd2=Case when o.SrcPMID is null then
		da.Address2
		else do.Address2
	  end, 
DCity=Case when o.SrcPMID is null then
		da.City
		else do.City
	  end,
DState=Case when o.SrcPMID is null then
		da.State
		else do.State
	  end, 
DZip=Case when o.SrcPMID is null then
		da.Zip
		else do.Zip
	  end, 
DCounty=Case when o.SrcPMID is null then
		da.County
		else do.County
	  end,
DPhone=SolomonApp.dbo.FormatPhone(ISNULL(cftDestPhoneNum.PhoneNbr,'NA')),

dbo.getVetLastVisit_TestDate(pm.SourceContactID, pm.MovementDate) VetVisitDate,

SPhone=SolomonApp.dbo.FormatPhone(ISNULL(cftSourcePhoneNum.PhoneNbr,'NA')),
pt.PigTypeDesc as PigType,
v.ContactID as VetContactID,
v.ContactName as VetName,
vacc.AccreditationNumber,
w.PICWeek,
w.WeekOfDate,
case rtrim(pt.PigTypeDesc)
	when 'Wean' then '15'
	when 'Feeder' then '50'
	when 'Breeder Stock' then '280'
	else 'NA'
end PigWeight
   
, ISNULL(CASE 
			WHEN RTRIM(cs.ContactName) IN ('C060','C061','C062','C063','C064','C065','C066','C067','C068','C069','C070')
				THEN 'Pleasant Hill'
			WHEN RTRIM(cs.ContactName) IN ('C027','C028','C029','C030','C031')
				THEN 'ON'
			WHEN RTRIM(cs.ContactName) IN ('C032','C033','C034','C035','C036','C037','C038')
				THEN 'LDC'
			WHEN RTRIM(cs.ContactName) IN ('C045','C051','C052','C053')
				THEN 'Bloomfield'
			WHEN RTRIM(cs.ContactName) IN ('C054','C055','C056','C058')
				THEN 'Leon'
			ELSE csp.Description END,'') as PodName
,	pm.PMLoadID as LoadNumber
,	pm.PMID as IndLoadNumber
,	right(convert(varchar,pm.LoadingTime, 108),8) as LoadingTime
,	s.SiteID as SourceSiteID
,	pm.SourceContactID
,	ISNULL(snais.NaisDisplayID, 'N/A') as SourceNAIS
,	d.SiteID as DestSiteID
,	ISNULL(dnais.NaisDisplayID, 'N/A') as DestNAIS
,	trucker.ContactName as Trucker
,	SolomonApp.dbo.GetSvcManagerNm(pm.SourceContactID,pm.MovementDate,'') as ServiceManager
,	SolomonApp.dbo.FormatPhone(ISNULL(cftVetPhoneNum.PhoneNbr,'5077945310')) as VetPhoneNbr
,	cftVetAddress.Address1 as VetAddress1
,	cftVetAddress.Address2 as VetAddress2
,	cftVetAddress.City as VetCity
,	cftVetAddress.State as VetState
,	cftVetAddress.Zip as VetZip
FROM         dbo.cftPM pm
		LEFT JOIN cftContact cd ON pm.DestContactID=cd.ContactID
		LEFT JOIN cftSite s on pm.SourceContactID=s.ContactID
		LEFT JOIN CFApp_PigManagement.dbo.cft_SITE_NAIS snais on s.siteid = snais.siteid and snais.Active = 1
		LEFT JOIN cftSite d on pm.DestContactID=d.ContactID
		LEFT JOIN CFApp_PigManagement.dbo.cft_SITE_NAIS dnais on d.siteid = dnais.siteid and dnais.Active = 1
		LEFT JOIN cftContactAddress dca ON dca.ContactID=cd.ContactID and dca.AddressTypeID=1
		LEFT JOIN cftAddress da ON dca.AddressID = da.AddressID
		LEFT JOIN cftContact cs ON pm.SourceContactID=cs.ContactID
		LEFT JOIN cfv_CURRENT_SITE_PODS csp ON csp.ContactID = pm.SourceContactID
		LEFT JOIN cftContactAddress sca ON sca.ContactID=cs.ContactID and sca.AddressTypeID=1
		LEFT JOIN cftAddress sa ON sa.AddressID=sca.AddressID
		LEFT JOIN cftContact v ON cast(v.ContactID as int) = dbo.getVetLastVisit_VetContactID(pm.SourceContactID, pm.MovementDate)
		LEFT JOIN (select ContactID, AccreditationState, max(isnull(AccreditationExpirationDate,'1/1/1900')) AccreditationExpirationDate
			from CFApp_Contact.dbo.cft_CONTACT_ACCREDITATION group by ContactID, AccreditationState) vacc_max
			on vacc_max.contactid = v.ContactID and vacc_max.AccreditationState = sa.State
		LEFT JOIN CFApp_Contact.dbo.cft_CONTACT_ACCREDITATION vacc ON vacc.ContactID = vacc_max.ContactID AND vacc.AccreditationState = vacc_max.AccreditationState and isnull(vacc.AccreditationExpirationDate,'1/1/1900') = isnull(vacc_max.AccreditationExpirationDate,'1/1/1900')
        LEFT JOIN dbo.cftPigType pt ON pm.PigTypeID = pt.PigTypeID
		LEFT JOIN dbo.cftPigOffload o on pm.PMID=o.SrcPMID
		LEFT JOIN cftPM op on o.DestPMID=op.PMID
		LEFT JOIN cftContact oc ON op.DestContactID=oc.ContactID
		LEFT JOIN cftSite ds ON ds.ContactID=op.DestContactID
		LEFT JOIN cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
		LEFT JOIN cftContactAddress doa ON doa.ContactID=oc.ContactID and doa.AddressTypeID=1
		LEFT JOIN cftAddress do ON doa.AddressID = do.AddressID
		LEFT JOIN cftContactPhone SMainPhone ON SMainPhone.ContactID = s.ContactID AND SMainPhone.PhoneTypeID = '001'
		LEFT JOIN cftContactPhone SHomePhone ON SHomePhone.ContactID = s.ContactID AND SHomePhone.PhoneTypeID = '002'
		LEFT JOIN cftContactPhone SCellPhone ON SCellPhone.ContactID = s.ContactID AND SCellPhone.PhoneTypeID = '003'
		LEFT JOIN cftPhone cftSourcePhoneNum ON cftSourcePhoneNum.PhoneID = COALESCE(SMainPhone.PhoneID,SHomePhone.PhoneID,SCellPhone.PhoneID)
		LEFT JOIN cftContactPhone DMainPhone ON DMainPhone.ContactID = d.ContactID AND DMainPhone.PhoneTypeID = '001'
		LEFT JOIN cftContactPhone DHomePhone ON DHomePhone.ContactID = d.ContactID AND DHomePhone.PhoneTypeID = '002'
		LEFT JOIN cftContactPhone DCellPhone ON DCellPhone.ContactID = d.ContactID AND DCellPhone.PhoneTypeID = '003'
		LEFT JOIN cftContactPhone DOMainPhone ON DOMainPhone.ContactID = op.DestContactID AND DOMainPhone.PhoneTypeID = '001'
		LEFT JOIN cftContactPhone DOHomePhone ON DOHomePhone.ContactID = op.DestContactID AND DOHomePhone.PhoneTypeID = '002'
		LEFT JOIN cftContactPhone DOCellPhone ON DOCellPhone.ContactID = op.DestContactID AND DOCellPhone.PhoneTypeID = '003'
		LEFT JOIN cftPhone cftDestPhoneNum ON cftDestPhoneNum.PhoneID = COALESCE(DMainPhone.PhoneID,DHomePhone.PhoneID,DCellPhone.PhoneID,DOMainPhone.PhoneID,DOHomePhone.PhoneID,DOCellPhone.PhoneID)
		LEFT JOIN cftContactPhone VOfficePhone ON vOfficePhone.ContactID = v.ContactID AND VOfficePhone.PhoneTypeID = '018' --office
		LEFT JOIN cftContactPhone VMainPhone ON vMainPhone.ContactID = v.ContactID AND VMainPhone.PhoneTypeID = '001' --main
		LEFT JOIN cftContactPhone VHomePhone ON vHomePhone.ContactID = v.ContactID AND VHomePhone.PhoneTypeID = '002' --home
		LEFT JOIN cftContactPhone VCellPhone ON vCellPhone.ContactID = v.ContactID AND VCellPhone.PhoneTypeID = '003' --cell
		LEFT JOIN cftPhone cftVetPhoneNum ON cftVetPhoneNum.PhoneID = COALESCE(VOfficePhone.PhoneID,VMainPhone.PhoneID,VHomePhone.PhoneID,VCellPhone.PhoneID)
		LEFT JOIN cftContactAddress VPhysAddress ON VPhysAddress.ContactID = v.ContactID AND VPhysAddress.AddressTypeID = '01'
		LEFT JOIN cftContactAddress VMailAddress ON VMailAddress.ContactID = v.ContactID AND VMailAddress.AddressTypeID = '02'
		LEFT JOIN cftAddress cftVetAddress ON cftVetAddress.AddressID = COALESCE(VPhysAddress.AddressID,VMailAddress.AddressID)
		LEFT JOIN cftContact trucker ON pm.TruckerContactID = trucker.ContactID

WHERE  
(pm.TattooFlag<>0 or op.TattooFlag<>0)
and pm.Highlight<>255
and left(pm.TranSubTypeID,1)<>'O'
and pm.PigTypeID not in ('01', '04', '05', '07', '09', '10', '11')
and sa.State <> da.State
Group by
pm.CpnyID,pm.MovementDate,pm.PMSystemID,pm.DestContactID,pm.SourceContactID,

cs.ContactName,pm.PigGenderTypeID, cd.ContactName,sa.Address1,sa.Address2,pm.DestContactID,
sa.City,sa.State, sa.Zip,sa.County, da.Address1, da.Address2,
da.City, da.State, da.Zip, da.County,
do.Address1, do.Address2,
do.City, do.State, do.Zip, do.County,
pt.PigTypeDesc,v.ContactID,v.ContactName,vacc.AccreditationNumber,w.PICWeek,w.WeekOfDate,
o.SrcPMID, oc.ContactName,pm.TranSubTypeID,op.DestContactID,s.PremiseID, d.PremiseID, ds.PremiseID, 
ISNULL(CASE 
			WHEN RTRIM(cs.ContactName) IN ('C060','C061','C062','C063','C064','C065','C066','C067','C068','C069','C070')
				THEN 'Pleasant Hill'
			WHEN RTRIM(cs.ContactName) IN ('C027','C028','C029','C030','C031')
				THEN 'ON'
			WHEN RTRIM(cs.ContactName) IN ('C032','C033','C034','C035','C036','C037','C038')
				THEN 'LDC'
			WHEN RTRIM(cs.ContactName) IN ('C045','C051','C052','C053')
				THEN 'Bloomfield'
			WHEN RTRIM(cs.ContactName) IN ('C054','C055','C056','C058')
				THEN 'Leon'
			ELSE csp.Description END,'')
,	pm.PMLoadID
,	pm.PMID
,	right(convert(varchar,pm.LoadingTime, 108),8)
,	s.SiteID
,	snais.NaisDisplayID
,	d.SiteID
,	dnais.NaisDisplayID
,	trucker.ContactName
,	SolomonApp.dbo.GetSvcManagerNm(pm.SourceContactID,pm.MovementDate,'')
,	cftSourcePhoneNum.PhoneNbr
,	cftDestPhoneNum.PhoneNbr
,	cftVetPhoneNum.PhoneNbr
,	cftVetAddress.Address1
,	cftVetAddress.Address2
,	cftVetAddress.City
,	cftVetAddress.State
,	cftVetAddress.Zip
