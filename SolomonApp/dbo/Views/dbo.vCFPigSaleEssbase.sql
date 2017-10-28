
--*************************************************************
--	Purpose:Pig Sale Account Detail
--		
--	Author: Charity Anderson
--	Date: 7/19/2005
--	Usage: EssBase 
--	Parms: None
--*************************************************************
CREATE VIEW vCFPigSaleEssbase 
AS

Select Distinct Week =right(pgActW.PICYear,2) + 'WK' + 
	replicate('0',2-len(rtrim(convert(char(2),rtrim(pgActW.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(pgActW.PICWeek))),
	ps.KillDate,ps.RefNbr,pg.CpnyID as PigCo,g.Description as Gender,ps.SaleBasis as SalesType,
	ps.PMLoadID,mi.OneWayMiles as MilesToPacker,
	mt.Description as LoadType,
	MktServiceman=dbo.GetMktManagerNm(pg.SiteContactID,pg.ActCloseDate,'1/1/1900'),
	p.ContactName as Packer, 
	Case when pd.PrimaryPacker=0 then '' else 'Primary' end as PrimaryPacker,
	pg.TaskID as PigGroup,
	PigGroupAlias=
	rTrim(c.ContactName) + ' Barn ' + rtrim(isnull(pg.BarnNbr,'')) + ' ' + rtrim(isnull(pgr.RoomNbr,''))
	+ ' ' + convert(varchar(10),pg.ActStartDate,101), 
	'MG' + pg.CF03 as MasterGroup,
	MGAlias= rtrim(ms.ContactName) + ' ' + convert(varchar(10),(mg.StartDate),101),
	t.ContactName as Trucker,c.ContactName as Site, ps.BarnNbr as Barn,
	'Actual' as Scenerio,
	psd.Account, psd.Value
	
from cftPigSale ps WITH (NOLOCK)
JOIN Batch WITH (NOLOCK) on ps.BatNbr=Batch.BatNbr and Batch.Module='AR'
LEFT JOIN cftPigSale rev WITH (NOLOCK) on rev.OrigRefNbr=ps.RefNbr
JOIN vCFPigSaleDetailUNION psd on ps.RefNbr=psd.RefNbr
JOIN cftPigGroup pg WITH (NOLOCK) on ps.PigGroupID=pg.PigGroupID
LEFT JOIN cfvPigOffload o on ps.PMLoadID=o.OrigPMID
LEFT JOIN cftPM pm WITH (NOLOCK) on cast(pm.PMID as integer)=o.PMID
LEFT JOIN vCFPigGroupRoomFilter rf on pg.PigGroupID=rf.PigGroupID and rf.GroupCount=1
LEFT JOIN cftPigGroupRoom pgr WITH (NOLOCK) on rf.PigGroupID=pgr.PigGroupID
LEFT JOIN cftContact c WITH (NOLOCK) on pg.SiteContactID=c.ContactID
LEFT JOIN cftPigGenderType g WITH (NOLOCK) on pg.PigGenderTypeID=g.PIgGenderTypeID
LEFT JOIN cfvDayDefinition_WithWeekInfo  pgActW on ps.SaleDate=  pgActW.DayDate
left JOIN cftMarketSaleType mt WITH (NOLOCK) on pm.MarketSaleTypeID=mt.MarketSaleTypeID
left JOIN cftContact p WITH (NOLOCK) on ps.PkrContactID=p.ContactID
LEFT JOIN cftPacker pd WITH (NOLOCK) on ps.PkrContactID=pd.ContactID
LEFT JOIN cftContact t WITH (NOLOCK) on pm.TruckerContactID=t.ContactID
LEFT JOIN cfvMasterGroupActStart mg on mg.MGPigGroupID=pg.CF03
LEFT JOIN cftContact ms on mg.SiteContactID=ms.ContactID
LEFT JOIN vCFContactMilesMatrix mi on ps.SiteContactID=mi.SourceSite and ps.PkrContactID=mi.DestSite

WHERE pg.ActCloseDate>'1/1/1900'          
	and pg.PGStatusID in ('I','X')
	and rev.RefNbr is null and ps.DocType<>'RE'
	and Batch.Rlsed=1
