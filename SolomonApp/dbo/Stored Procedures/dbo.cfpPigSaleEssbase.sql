--*************************************************************
--	Purpose:Pig Sale Account Detail
--		
--	Author: Charity Anderson
--	Date: 7/19/2005
--	Usage: EssBase 
--	Parms: None
--*************************************************************
CREATE PROC cfpPigSaleEssbase 
AS

BEGIN TRANSACTION
TRUNCATE TABLE cftEssBasePSDetail
Insert into cftEssBasePSDetail Select * from vCFPigSaleDetailUNION
COMMIT WORK

Select Week =right(pgActW.PICYear,2) + 'WK' + rtrim(pgActW.PICWeek),
	ps.KillDate,ps.RefNbr,pg.CpnyID as PigCo,g.Description as Gender,ps.SaleBasis as SalesType,
	mt.Description as LoadType,
	MktServiceman=dbo.GetMktManagerNm(pg.SiteContactID,pg.ActCloseDate,'1/1/1900'),
	MGMktManager=(Select TOP 1 dbo.GetMktManagerNm(mg.SiteContactID,pg.ActCloseDate,'1/1/1900')
				from cftPigGroup mg WITH (NOLOCK)
				where mg.CF03=pg.CF03
				order by ActCloseDate DESC,EstCloseDate DESC),p.ContactName as Packer, 
	Case when pd.PrimaryPacker=0 then '' else 'Primary' end as PrimaryPacker,
	pg.TaskID as PigGroup,
	PigGroupAlias=rTrim(c.ContactName) + ' Barn ' + rtrim(isnull(pg.BarnNbr,'')) + ' ' + rtrim(isnull(pgr.RoomNbr,''))+ ' ' + convert(varchar(10),pg.ActStartDate,101), 
	'MG' + pg.CF03 as MasterGroup,
	MGAlias=(Select TOP 1 rtrim(c.ContactName) + ' ' + convert(varchar(10),(gs.TranDate),101)
				from cftPigGroup mg WITH (NOLOCK)
				JOIN cftContact c WITH (NOLOCK) on mg.SiteContactID=c.ContactID
				LEFT JOIN vCFPigGroupStart gs on mg.PigGroupID=gs.PigGroupID
				where mg.CF03=pg.CF03 and mg.ActStartDate>'1/1/1900'
				order by ActStartDate),
	t.ContactName as Trucker,c.ContactName as Site, ps.BarnNbr as Barn,
	'Actual' as Scenerio,
	psd.Account, psd.Value
	
from cftPigSale ps WITH (NOLOCK)
JOIN Batch WITH (NOLOCK) on ps.BatNbr=Batch.BatNbr and Batch.Module='AR'
LEFT JOIN cftPigSale rev WITH (NOLOCK) on rev.OrigRefNbr=ps.RefNbr
JOIN cftEssBasePSDetail psd on ps.RefNbr=psd.RefNbr
JOIN cftPigGroup pg WITH (NOLOCK) on ps.PigGroupID=pg.PigGroupID
LEFT JOIN cftPM pm WITH (NOLOCK) on ps.PMLoadID=pm.PMID
LEFT JOIN vCFPigGroupRoomFilter rf on pg.PigGroupID=rf.PigGroupID and rf.GroupCount=1
LEFT JOIN cftPigGroupRoom pgr WITH (NOLOCK) on rf.PigGroupID=pgr.PigGroupID
LEFT JOIN cftContact c WITH (NOLOCK) on pg.SiteContactID=c.ContactID
LEFT JOIN cftPigGenderType g WITH (NOLOCK) on pg.PigGenderTypeID=g.PIgGenderTypeID
LEFT JOIN cftWeekDefinition pgActW WITH (NOLOCK) on pg.ActCloseDate between pgActW.WeekOFDate and pgActW.WeekEndDate
left JOIN cftMarketSaleType mt WITH (NOLOCK) on pm.MarketSaleTypeID=mt.MarketSaleTypeID
left JOIN cftContact p WITH (NOLOCK) on ps.PkrContactID=p.ContactID
LEFT JOIN cftPacker pd WITH (NOLOCK) on ps.PkrContactID=pd.ContactID
LEFT JOIN cftContact t WITH (NOLOCK) on pm.TruckerContactID=t.ContactID

WHERE pg.ActCloseDate>'1/1/1900'
	and pg.PGStatusID in ('I','X')
	and rev.RefNbr is null and ps.DocType<>'RE'
	and Batch.Rlsed=1



 