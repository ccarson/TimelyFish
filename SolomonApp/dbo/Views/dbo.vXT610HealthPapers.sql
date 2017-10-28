
--*************************************************************
--	Purpose: Joins foreign tables for site address info
--			to create a Health Paper Report
--	Author: Charity Anderson
--	Date:  4/28/2005
--	Usage: XT610 HealthPaper Report
--	Parms:
--*************************************************************
CREATE VIEW dbo.vXT610HealthPapers
AS

SELECT   Distinct sum(pm.EstimatedQty) as EstimatedQty,pm.CpnyID,pm.MovementDate,pm.PMSystemID,

cs.ContactName as SourceFarm,pm.PigGenderTypeID,
DestFarm= Case when o.SrcPMID is null then
	cd.ContactName
	else rtrim(oc.ContactName) + ' (' + rtrim(cd.ContactName) + ')' end,sa.Address1 as SAdd1,sa.Address2 as SAdd2,
sa.City as SCity,sa.State as SState, sa.Zip as SZip,sa.County as SCounty, 
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
DPhone=Case when o.SrcPMID is null then
	 (Select min(PhoneNbr) from vCF100ContactPHone where ContactID=pm.DestContactID
			group by pm.DestContactID)
	 else
	 (Select min(PhoneNbr) from vCF100ContactPHone where ContactID=op.DestContactID
			group by op.DestContactID) end,
	 h.VetVisitDate,
SPhone=(Select min(PhoneNbr) from vCF100ContactPHone where ContactID=pm.SourceContactID
			group by pm.SourceContactID),h.Age,
pt.PigTypeDesc as PigType,v.ContactName as VetName,w.PICWeek,w.WeekOfDate,h.Tattoo
   
/* pm.HeadCount, cs.ContactName AS SourceFarm, cd.ContactName AS DestFarm, pm.DateList, sa.Address1 AS srcadd1, sa.Address2 AS srcadd2, 
              sa.City AS srccity, sa.State AS srcstate, sa.Zip AS srczip, sa.County AS srccounty, da.Address1 AS destadd1, da.Address2 AS destadd2, 
              da.City AS destcity, da.State AS deststate, da.Zip AS destzip, da.County AS destcounty, p.PhoneNbr AS destphone, h.VetVisit, h.Tattoo, h.Age, 
              dbo.PigType.Description AS PigType, pm.SundayDate, v.VetName,dp.PhoneTypeID, pm.CompanyID */
FROM         dbo.cftPM pm
		LEFT JOIN cftContact cd ON pm.DestContactID=cd.ContactID
		LEFT JOIN cftSite s on pm.SourceContactID=s.ContactID
		LEFT JOIN cftSite d on pm.DestContactID=d.ContactID
		LEFT JOIN cftContactAddress dca ON dca.ContactID=cd.ContactID and dca.AddressTypeID=1
		LEFT JOIN cftAddress da ON dca.AddressID = da.AddressID
		--LEFT JOIN cftPhone p ON dp.PhoneID=p.PhoneID
		LEFT JOIN cftContact cs ON pm.SourceContactID=cs.ContactID
		LEFT JOIN cftContactAddress sca ON sca.ContactID=cs.ContactID and sca.AddressTypeID=1
		LEFT JOIN cftAddress sa ON sa.AddressID=sca.AddressID
                LEFT JOIN cftHealthService h ON h.ContactID=pm.SourceContactID
		LEFT JOIN cftContact v ON v.ContactID=h.VetContactID     
        LEFT JOIN dbo.cftPigType pt ON pm.PigTypeID = pt.PigTypeID
		LEFT JOIN dbo.cftPigOffload o on pm.PMID=o.SrcPMID
		LEFT JOIN cftPM op on o.DestPMID=op.PMID
		LEFT JOIN cftContact oc ON op.DestContactID=oc.ContactID
		LEFT JOIN cftSite ds ON ds.ContactID=op.DestContactID
		LEFT JOIN cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
		LEFT JOIN cftContactAddress doa ON doa.ContactID=oc.ContactID and doa.AddressTypeID=1
		LEFT JOIN cftAddress do ON doa.AddressID = do.AddressID
		--LEFT JOIN cftPMView vi on pm.PMSystemID=vi.PMViewID

WHERE  
--   ((dp.PhoneTypeID =1 or dp.PhoneTypeID is NULL) AND 
--(sa.State in ('MN','IA','SD','IL','NE')) AND 
(dca.AddressTypeID=1) AND (sca.AddressTypeID=1) 
and (pm.TattooFlag<>0 or op.TattooFlag<>0)
and pm.Highlight<>255
and left(pm.TranSubTypeID,1)<>'O'
Group by
pm.CpnyID,pm.MovementDate,pm.PMSystemID,pm.DestContactID,pm.SourceContactID,

cs.ContactName,pm.PigGenderTypeID, cd.ContactName,sa.Address1,sa.Address2,
sa.City,sa.State, sa.Zip,sa.County, da.Address1, da.Address2,
da.City, da.State, da.Zip, da.County,
do.Address1, do.Address2,
do.City, do.State, do.Zip, do.County,h.VetVisitDate,h.Age,
pt.PigTypeDesc,v.ContactName,w.PICWeek,w.WeekOfDate,h.Tattoo, 
o.SrcPMID, oc.ContactName,pm.TranSubTypeID,op.DestContactID,s.PremiseID, d.PremiseID, ds.PremiseID

