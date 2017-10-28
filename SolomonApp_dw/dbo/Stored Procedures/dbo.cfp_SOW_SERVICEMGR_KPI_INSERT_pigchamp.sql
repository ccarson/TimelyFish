




-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 11/22/2010
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SOW_SERVICEMGR_KPI_INSERT_pigchamp]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_SOW_SERVICEMGR_KPI_RESULTS

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_SOW_SERVICEMGR_KPI_RESULTS
(	Site
	,Siteid
	,Contactid
	,SvcMgr
	,SvcMgrID
	,FYPeriod
	,FarrowTarget
	,Farrows
	,ServeFarrow
	,BornAlive
	,PreWeanBA
	,StillBorn
	,Mummy
	,GoodPigs
	,PreWeanGP
	,AmtGoodPigs
	,SowWeaned
	,SowGiltDeath
	,SowDays
	,Amt)
	
	Select 
	
	Contact.Contactname Site,
	Site.Siteid,
	Contact.Contactid,
	SvcMgrC.Contactname SvcMgr,
	SvcMgrC.ContactId SvcMgrID,
	Case when Weekdef.FiscalPeriod < 10 
	then Rtrim(CAST(Weekdef.FiscalYear AS char)) + '0' + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) 
	else Rtrim(CAST(Weekdef.FiscalYear AS char)) + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) end FYPeriod,
	Case when Contact.ContactID = 000315 then 100
	when Contact.ContactID = 000319 then 63
	when Contact.ContactID in (000322,000323,000324,000325,000326,000327,000328,000329,000331,000333,000337,
	000336) then 106
	when Contact.ContactID = 000332 then 221 
	when Contact.ContactID = 000339 then 224 
	when Contact.ContactID in (000837,000836,000835,002555) then 123 
	when Contact.ContactID = 004184 then 201 
	when Contact.ContactID in (000338,007663) then 154 
	when Contact.ContactID = 004183 then 232 
	when Contact.ContactID = 002547 then 0 
	when Contact.ContactID in (002548,002549,002550) then 207 
	when Contact.ContactID in (002551,002552) then 126 
	when Contact.ContactID = 002553 then 73 
	when Contact.ContactID = 004314 then 265 
	when Contact.ContactID = 004742 then 200 
	when Contact.ContactID in (002556,002557,002558,002559,002561) then 134 
	when Contact.ContactID = 002560 then 129 
	when Contact.ContactID = 005033 then 255 
	when Contact.ContactID in (002562,002563) then 110 
	when Contact.ContactID = 002283 then 180 
	when Contact.ContactID = 000838 then 51 
	when Contact.ContactID in (000330,000335) then 115
	when Contact.ContactID in (000340,000342,000347,000349) then 168
	when Contact.ContactID = 000344 then 65 
	when Contact.ContactID = 000345 then 154 else '' end * Weeks.Weeks as FarrowTarget,
	Sum(SowFarrow.Farrows) Farrows,
	Sum(ServeFarrow.ServeFarrow) ServeFarrow,
	Sum(BornAlive.BornAlive) BornAlive,
	PreWeanBA.BornAlive PreWeanBA,
	Sum(StillBorn.StillBorn) StillBorn,
	Sum(Mummy.Mummy) Mummy,
	GoodPigs.GoodPigs GoodPigs,
	PreWeanGP.GoodPigs PreWeanGP,
	AmtGP.AmtGoodPigs,
	Sum(SowWeaned.SowWeaned) SowWeaned,
	Sum(SowGiltDeath.SowGiltDeath) SowGiltDeath,
	Sum(SowDays.SowDays) SowDays,
	SowCost.Amt

	From earth.sowdata.dbo.FarmSetup Farm		-- remove reference to saturn

	cross join [$(SolomonApp)].dbo.cftWeekDefinition WeekDef (nolock)

	left join [$(CentralData)].dbo.Contact Contact (nolock)
	on Farm.ContactID = Contact.ContactID

	left join [$(CentralData)].dbo.Site Site (nolock)
	on Farm.ContactID = Site.ContactID

	--Sows Farrowed--

	left join 
	(Select 
	FS.ContactID,
	SF.WeekOfDate,
	Sum(Qty) Farrows
	from earth.sowdata.dbo.vPM_SowsFarrowed SF		-- remove reference to saturn
	left join earth.sowdata.dbo.FarmSetup FS		-- remove reference to saturn
	on SF.FarmID = FS.FarmID
	Where
	SF.WeekOfDate >= '6/28/2009'
	Group by
	FS.ContactID,
	SF.WeekOfDate) SowFarrow
	on SowFarrow.ContactID = Farm.ContactID
	and SowFarrow.WeekofDate = WeekDef.WeekofDate
	
	--Served to Farrow--
	
	left join 
	(Select 
	FS.ContactID,
	ASF.WeekOfDate,
	Sum(Qty) ServeFarrow
	from earth.sowdata.dbo.vPM_AdjServedtoFarrow ASF		-- remove reference to saturn
	left join earth.sowdata.dbo.FarmSetup FS		-- remove reference to saturn
	on ASF.FarmID = FS.FarmID
	Where
	ASF.WeekOfDate >= '6/28/2009'
	Group by
	FS.ContactID,
	ASF.WeekOfDate) ServeFarrow
	on ServeFarrow.ContactID = Farm.ContactID
	and ServeFarrow.WeekOfDate = WeekDef.WeekOfDate

	--Born Alive--

	left join 
	(Select 
	FS.ContactID,
	PBA.WeekOfDate,
	Sum(Qty) BornAlive
	from earth.sowdata.dbo.vPM_PigsBornAlive PBA		-- remove reference to saturn
	left join earth.sowdata.dbo.FarmSetup FS		-- remove reference to saturn
	on PBA.FarmID = FS.FarmID
	Where
	PBA.WeekOfDate >= '6/28/2009'
	Group by
	FS.ContactID,
	PBA.WeekOfDate) BornAlive
	on BornAlive.ContactID = Farm.ContactID
	and BornAlive.WeekOfDate = WeekDef.WeekOfDate
	
	--Prewean Born Alive--
	
	left join
	(Select
	Contact.ContactID,
	WeekDef.FYPeriod,
	Sum(PBA.Qty) BornAlive
	from 
	(Select distinct
	Case when FiscalPeriod < 10 
	then Rtrim(CAST(FiscalYear AS char)) + '0' + Rtrim(CAST(FiscalPeriod AS char)) 
	else Rtrim(CAST(FiscalYear AS char)) + Rtrim(CAST(FiscalPeriod AS char)) end as FYPeriod,
	WeekEndDate,
	Min(WeekofDate)-84 StartDate,
	Max(WeekEndDate)-21 EndDate
	from [$(SolomonApp)].dbo.cftWeekDefinition 
	group by
	FiscalYear,
	FiscalPeriod,
	WeekEndDate) WeekDef
	left join (select 
	farmid, weekofdate, qty
	from earth.sowdata.dbo.vPM_PigsBornAlive) PBA		-- remove reference to saturn
	on PBA.WeekofDate between WeekDef.StartDate and WeekDef.EndDate
	left join earth.sowdata.dbo.FarmSetup FS 		-- remove reference to saturn
	on PBA.FarmID = FS.FarmID
	left join [$(CentralData)].dbo.Contact Contact (nolock)
	on FS.Contactid = Contact.Contactid
	Where WeekDef.FYPeriod >= 201001
	Group by
	Contact.ContactID,
	WeekDef.FYPeriod) PreWeanBA
	on PreWeanBA.ContactID = Farm.ContactID
	and PreWeanBA.FYPeriod = Case when Weekdef.FiscalPeriod < 10 
	then Rtrim(CAST(Weekdef.FiscalYear AS char)) + '0' + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) 
	else Rtrim(CAST(Weekdef.FiscalYear AS char)) + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) end

	--Still Born--

	left join 
	(Select 
	FS.ContactID,
	SBP.WeekOfDate,
	Sum(Qty) StillBorn
	from earth.sowdata.dbo.vPM_StillBornPigs SBP		-- remove reference to saturn
	left join earth.sowdata.dbo.FarmSetup FS		-- remove reference to saturn
	on SBP.FarmID = FS.FarmID
	Where
	SBP.WeekOfDate >= '6/28/2009'
	Group by
	FS.ContactID,
	SBP.WeekOfDate) StillBorn
	on StillBorn.ContactID = Farm.ContactID
	and StillBorn.WeekOfDate = WeekDef.WeekOfDate

	--Mummies--

	left join 
	(Select 
	FS.ContactID,
	MPB.WeekOfDate,
	Sum(Qty) Mummy
	from earth.sowdata.dbo.vPM_MummifiedPigsBorn MPB		-- remove reference to saturn
	left join earth.sowdata.dbo.FarmSetup FS		-- remove reference to saturn
	on MPB.FarmID = FS.FarmID
	Where
	MPB.WeekOfDate >= '6/28/2009'
	Group by
	FS.ContactID,
	MPB.WeekOfDate) Mummy
	on Mummy.ContactID = Farm.ContactID
	and Mummy.WeekOfDate = WeekDef.WeekOfDate

	--Sows Weaned--

	left join 
	(Select 
	FS.ContactID,
	LWD.WeekOfDate,
	Sum(Qty) SowWeaned
	from earth.sowdata.dbo.vPM_LastWeanDatesQty LWD		-- remove reference to saturn
	left join earth.sowdata.dbo.FarmSetup FS		-- remove reference to saturn
	on LWD.FarmID = FS.FarmID
	Where
	LWD.WeekOfDate >= '6/28/2009'
	Group by
	FS.ContactID,
	LWD.WeekOfDate) SowWeaned
	on SowWeaned.ContactID = Farm.ContactID
	and SowWeaned.WeekOfDate = WeekDef.WeekOfDate

	--Sow and Gilt Deaths--

	left join 
	(Select 
	FS.ContactID,
	SGD.WeekOfDate,
	Sum(Qty) SowGiltDeath
	from earth.sowdata.dbo.vPM_SowAndGiltDeaths SGD		-- remove reference to saturn
	left join earth.sowdata.dbo.FarmSetup FS		-- remove reference to saturn
	on SGD.FarmID = FS.FarmID
	Where
	SGD.WeekOfDate >= '6/28/2009'
	Group by
	FS.ContactID,
	SGD.WeekOfDate) SowGiltDeath
	on SowGiltDeath.ContactID = Farm.ContactID
	and SowGiltDeath.WeekOfDate = WeekDef.WeekOfDate

	--Total Sow Days--

	left join 
	(Select 
	FS.ContactID,
	TSD.WeekOfDate,
	Sum(Qty) SowDays
	from earth.sowdata.dbo.vPM_TotalSowDays TSD		-- remove reference to saturn
	left join earth.sowdata.dbo.FarmSetup FS		-- remove reference to saturn
	on TSD.FarmID = FS.FarmID
	Where
	TSD.WeekOfDate >= '6/28/2009'
	Group by
	FS.ContactID,
	TSD.WeekOfDate) SowDays
	on SowDays.ContactID = Farm.ContactID
	and SowDays.WeekOfDate = WeekDef.WeekOfDate

	--Good Pigs--

	left join 
	(Select 
	Case when C.ContactID = 341 then 340
	when C.ContactID = 343 then 342
	when C.ContactID = 346 then 345
	when C.ContactID = 348 then 347
	when C.ContactID = 350 then 349 else C.ContactID end ContactID,
	WD.FiscalYear,
	WD.FiscalPeriod,
	Sum(G.Qty) GoodPigs
	from [$(SolomonApp)].dbo.cftPMGradeQty G
	left join [$(SolomonApp)].dbo.cftPMTranspRecord T
	on t.RefNbr=G.RefNbr
	left join [$(CentralData)].dbo.Contact C
	on C.ContactID=T.SourceContactID
	left join [$(SolomonApp)].dbo.cftPigGradeCatType CT
	on CT.PigGradeCatTypeID=G.PigGradeCatTypeID
	left join [$(SolomonApp)].dbo.cftPMTranspRecord re
	on (T.refnbr = re.origrefnbr)
	left join [$(SolomonApp)].dbo.cftDayDefinition DD
	on DD.DayDate=T.MovementDate
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekofDate=WD.WeekofDate
	Where
	t.PigTypeID='02'
	and left(T.SubTypeID,1) = 'S'
	and T.doctype <> 're'
	and re.refnbr is null
	and CT.PigGradeCatTypeDesc in ('Standards','Dead before Grade','Dead on truck')
	Group by
	Case when C.ContactID = 341 then 340
	when C.ContactID = 343 then 342
	when C.ContactID = 346 then 345
	when C.ContactID = 348 then 347
	when C.ContactID = 350 then 349 else C.ContactID end,
	WD.FiscalYear,
	WD.FiscalPeriod) GoodPigs
	on Farm.ContactID = GoodPigs.ContactID
	and WeekDef.FiscalYear = GoodPigs.FiscalYear
	and WeekDef.FiscalPeriod = GoodPigs.FiscalPeriod
	
	--PreWean Good Pigs--
	
	left join 
	(Select
	GP.ContactID,
	WeekDef.FYPeriod,
	Sum(GP.GoodPigs) GoodPigs
	from 
	(Select distinct
	Case when FiscalPeriod < 10 
	then Rtrim(CAST(FiscalYear AS char)) + '0' + Rtrim(CAST(FiscalPeriod AS char)) 
	else Rtrim(CAST(FiscalYear AS char)) + Rtrim(CAST(FiscalPeriod AS char)) end as FYPeriod,
	WeekEndDate,
	Min(WeekofDate)-63 StartDate,
	Max(WeekEndDate) EndDate
	from [$(SolomonApp)].dbo.cftWeekDefinition 
	group by
	FiscalYear,
	FiscalPeriod,
	WeekEndDate) WeekDef
	left join (Select 
	Case when C.ContactID = 341 then 340
	when C.ContactID = 343 then 342
	when C.ContactID = 346 then 345
	when C.ContactID = 348 then 347
	when C.ContactID = 350 then 349 else C.ContactID end ContactID,
	WD.WeekofDate,
	Sum(G.Qty) GoodPigs
	from [$(SolomonApp)].dbo.cftPMGradeQty G
	left join [$(SolomonApp)].dbo.cftPMTranspRecord T
	on t.RefNbr=G.RefNbr
	left join [$(CentralData)].dbo.Contact C
	on C.ContactID=T.SourceContactID
	left join [$(SolomonApp)].dbo.cftPigGradeCatType CT
	on CT.PigGradeCatTypeID=G.PigGradeCatTypeID
	left join [$(SolomonApp)].dbo.cftPMTranspRecord re
	on (T.refnbr = re.origrefnbr)
	left join [$(SolomonApp)].dbo.cftDayDefinition DD
	on DD.DayDate=T.MovementDate
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekofDate=WD.WeekofDate
	Where
	t.PigTypeID='02'
	and left(T.SubTypeID,1) = 'S'
	and T.doctype <> 're'
	and re.refnbr is null
	and CT.PigGradeCatTypeDesc in ('Standards','Dead before Grade','Dead on truck')
	Group by
	Case when C.ContactID = 341 then 340
	when C.ContactID = 343 then 342
	when C.ContactID = 346 then 345
	when C.ContactID = 348 then 347
	when C.ContactID = 350 then 349 else C.ContactID end,
	WD.WeekofDate) GP
	on GP.WeekofDate between WeekDef.StartDate and WeekDef.EndDate
	Where WeekDef.FYPeriod >= 201001
	Group by
	GP.ContactID,
	WeekDef.FYPeriod) PreWeanGP
	on PreWeanGP.ContactID = Farm.ContactID
	and PreWeanGP.FYPeriod = Case when Weekdef.FiscalPeriod < 10 
	then Rtrim(CAST(Weekdef.FiscalYear AS char)) + '0' + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) 
	else Rtrim(CAST(Weekdef.FiscalYear AS char)) + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) end
	
	--Amt Good Pigs--

	left join 
	(Select 
	S.SiteID,
	WD.FiscalYear,
	WD.FiscalPeriod,
	Sum(G.Qty) AmtGoodPigs
	from [$(SolomonApp)].dbo.cftPMGradeQty G
	left join [$(SolomonApp)].dbo.cftPMTranspRecord T
	on t.RefNbr=G.RefNbr
	left join [$(CentralData)].dbo.Site S
	on S.ContactID=T.SourceContactID
	left join [$(SolomonApp)].dbo.cftPigGradeCatType CT
	on CT.PigGradeCatTypeID=G.PigGradeCatTypeID
	left join [$(SolomonApp)].dbo.cftPMTranspRecord re
	on (T.refnbr = re.origrefnbr)
	left join [$(SolomonApp)].dbo.cftDayDefinition DD
	on DD.DayDate=T.MovementDate
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekofDate=WD.WeekofDate
	Where
	t.PigTypeID='02'
	and left(T.SubTypeID,1) = 'S'
	and T.doctype <> 're'
	and re.refnbr is null
	and CT.PigGradeCatTypeDesc in ('Standards','Dead before Grade','Dead on truck')
	Group by
	S.SiteID,
	WD.FiscalYear,
	WD.FiscalPeriod) AmtGP
	on Site.SiteID = AmtGP.SiteID
	and WeekDef.FiscalYear = AmtGP.FiscalYear
	and WeekDef.FiscalPeriod = AmtGP.FiscalPeriod

	--Total Dollars--

	left join 
	(Select 
	Right(rtrim(GlTran.Sub),4) Sub,
	GLTran.PerPost,
	Sum(GLTran.DrAmt-GLTran.CrAmt) Amt
	From [$(SolomonApp)].dbo.GLTran GLTran (nolock)
	left join [$(SolomonApp)].dbo.Account Account (nolock)
	on GLTran.Acct = Account.Acct
	left join [$(SolomonApp)].dbo.SubAcct SubAcct (nolock)
	on GLTran.Sub = SubAcct.Sub
	left join [$(SolomonApp)].dbo.SegDef seg (nolock)
	on right(rtrim(GLTran.Sub),4) = seg.ID and seg.SegNumber = 3
	Where 
	GLTran.Rlsed =1
	AND GLTran.PerPost >= 201001
	AND Account.AcctType in ('3I','3E')
	and Left(rtrim(GlTran.Sub),4) in ('1040','1041','1042','2040','2041','2042') 
	Group by
	Right(rtrim(GlTran.Sub),4),
	GlTran.PerPost) SowCost
	on SowCost.Sub = Site.SiteID
	and SowCost.PerPost = Case when Weekdef.FiscalPeriod < 10 
	then Rtrim(CAST(Weekdef.FiscalYear AS char)) + '0' + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) 
	else Rtrim(CAST(Weekdef.FiscalYear AS char)) + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) end

	--Weeks per Period--

	left join 
	(Select FiscalYear, FiscalPeriod, Count(Weekofdate) Weeks
	from [$(SolomonApp)].dbo.cftWeekDefinition 
	group by FiscalYear, FiscalPeriod) Weeks
	on WeekDef.FiscalYear = Weeks.FiscalYear
	and WeekDef.FiscalPeriod = Weeks.FiscalPeriod 

	--Service Manager--

	left join [$(SolomonApp)].dbo.cftSiteSvcMgrAsn SvcMgrS (nolock)
	on Farm.ContactID = SvcMgrS.SiteContactID
	and SvcMgrS.effectivedate =
	(select max(effectivedate)
	from [$(SolomonApp)].dbo.cftsitesvcmgrasn 
	where sitecontactid=farm.contactid
	and effectivedate <= (select max(WeekEndDate)
	from [$(SolomonApp)].dbo.cftWeekDefinition 
	where fiscalyear = weekdef.fiscalyear
	and fiscalperiod = weekdef.fiscalperiod
	group by fiscalyear, fiscalperiod))

	left join [$(CentralData)].dbo.Contact SvcMgrC (nolock)
	on SvcMgrS.SvcMgrContactId = SvcMgrC.ContactID

	Where
	Farm.Status = 'A'
	and Farm.ContactID not in (2286,2287)
	and Case when Weekdef.FiscalPeriod < 10 
	then Rtrim(CAST(Weekdef.FiscalYear AS char)) + '0' + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) 
	else Rtrim(CAST(Weekdef.FiscalYear AS char)) + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) end >= 201001

	Group by
	Contact.Contactname,
	Contact.ContactID,
	Site.SiteID,
	SvcMgrC.Contactname,
	SvcMgrC.ContactId,
	WeekDef.FiscalYear,
	WeekDef.FiscalPeriod,
	Weeks.Weeks,
	PreWeanBA.BornAlive,
	GoodPigs.GoodPigs,
	PreWeanGP.GoodPigs,
	AmtGP.AmtGoodPigs,
	SowCost.Amt

	Order by
	Contact.Contactname,
	WeekDef.FiscalYear,
	WeekDef.FiscalPeriod	
	
END






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SERVICEMGR_KPI_INSERT_pigchamp] TO [db_sp_exec]
    AS [dbo];

