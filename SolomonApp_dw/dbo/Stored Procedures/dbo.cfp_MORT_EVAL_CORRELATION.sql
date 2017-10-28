
-- ===================================================================
-- Author:	Brian Diehl
-- Create date: 08/13/2013
-- Description:	Creates data set for Mortality by Eval Score correlation report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_MORT_EVAL_CORRELATION]

AS
BEGIN
	SET NOCOUNT ON

	declare @PicWk1 varchar(6)
	declare @PicWk2 varchar(6)
	declare @PicWk3 varchar(6)
	declare @PicWk4 varchar(6)
	declare @WkDt1 date
	declare @WkDt2 date
	declare @WkDt3 date
	declare @WkDt4 date
	declare @maxWk	int
	
	IF (OBJECT_ID ('tempdb..#Mort_eval')) IS NOT NULL
		DROP TABLE #Mort_eval

	create table #Mort_eval 
	(	ContactId varchar(8)
	,	SiteName varchar(30)
	,	EvalServiceMgr varchar(50)
	,	AssignedSvcMgr varchar(50)
	,	PigFlowDescription varchar(50)
	,	WeekOfDate date
	,	evals integer
	,	EvalScore1 integer
	,	EvalScore2 integer
	,	EvalScore3 integer
	,	EvalScore4 integer
	,	RollupAvgScore decimal (10,2)
	,	AVGMortalityPercent1 decimal(10,2)
	,	AVGMortalityPercent2 decimal(10,2)
	,	AVGMortalityPercent3 decimal(10,2)
	,	AVGMortalityPercent4 decimal(10,2)
	,	RollupAvgMort decimal(10,2)
	,	pigprodphaseid varchar(4)
	,	MaxPicWeek varchar(6)
	,	MaxMinusPicWeek varchar(6)
	,	MinPlusPicWeek varchar(6)
	,	MinPicWeek varchar(6)
	)
	
	select @maxWk = MAX(Row) 
		from (
			select top 4 RIGHT(PicYear,2) + 'WK' + RIGHT('00' + cast(picweek as varchar(2)),2) as PicWk
					, weekofdate
					, ROW_NUMBER() OVER (ORDER BY WeekOfDate) AS Row
			from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
			where WeekOfDate <= (SELECT WeekOfDate from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
                      where cast(convert(varchar,getdate() -9,101) as datetime) between WeekOfDate and WeekEndDate)
            order by WeekOfDate desc
		) as wkDt
			
	select @PicWk1 = PicWk, @WkDt1 = weekofdate
		from (
			select top 4 RIGHT(PicYear,2) + 'WK' + RIGHT('00' + cast(picweek as varchar(2)),2) as PicWk
					, weekofdate
					, ROW_NUMBER() OVER (ORDER BY WeekOfDate) AS Row
			from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
			where WeekOfDate <= (SELECT WeekOfDate from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
                      where cast(convert(varchar,getdate() -9,101) as datetime) between WeekOfDate and WeekEndDate)
            order by WeekOfDate desc
		) as wkDt1 
		where Row=@MaxWk

	select @PicWk2 = PicWk, @WkDt2 = weekofdate
		from (
			select top 4 RIGHT(PicYear,2) + 'WK' + RIGHT('00' + cast(picweek as varchar(2)),2) as PicWk
					, weekofdate
					, ROW_NUMBER() OVER (ORDER BY WeekOfDate) AS Row
			from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
			where WeekOfDate <= (SELECT WeekOfDate from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
                      where cast(convert(varchar,getdate() -9,101) as datetime) between WeekOfDate and WeekEndDate)
            order by WeekOfDate desc
		) as wkDt1 
		where Row=(@MaxWk-1)
		
	select @PicWk3 = PicWk, @WkDt3 = weekofdate
		from (
			select top 4 RIGHT(PicYear,2) + 'WK' + RIGHT('00' + cast(picweek as varchar(2)),2) as PicWk
					, weekofdate
					, ROW_NUMBER() OVER (ORDER BY WeekOfDate) AS Row
			from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
			where WeekOfDate <= (SELECT WeekOfDate from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
                      where cast(convert(varchar,getdate() -9,101) as datetime) between WeekOfDate and WeekEndDate)
            order by WeekOfDate desc
		) as wkDt1 
		where Row=(@MaxWk-2)
		
	select @PicWk4 = PicWk, @WkDt4 = weekofdate 
		from (
			select top 4 RIGHT(PicYear,2) + 'WK' + RIGHT('00' + cast(picweek as varchar(2)),2) as PicWk
					, weekofdate
					, ROW_NUMBER() OVER (ORDER BY WeekOfDate) AS Row
			from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
			where WeekOfDate <= (SELECT WeekOfDate from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
                      where cast(convert(varchar,getdate() -9,101) as datetime) between WeekOfDate and WeekEndDate)
            order by WeekOfDate desc
		) as wkDt1 
		where Row=(@MaxWk-3)
	
	-- Create the recordset of sites with the first weeks eval scores
	Insert into #Mort_eval 
		(	ContactId
		,	SiteName
		,	EvalServiceMgr
		,	AssignedSvcMgr
		,	WeekOfDate
		,	evals
		,	EvalScore1
		,	MaxPicWeek
		,	MaxMinusPicWeek
		,	MinPlusPicWeek )
		select alpha.ContactId, SiteName, ServiceMgr, c.ContactName as AssignedSvcMgr, WeekOfDate, case when EntryDate IS null then 0 else 1 end as evals, 
			   avg(case when evalscore is null then 0 else evalscore end) as EvalScore, 
			   PicWeek, @PicWk2, @PicWk3
		from (
		select weekofdate, weekenddate, entrydate, ct.contactid, ct.contactname as 'SiteName', rTrim(svc.contactname) as 'ServiceMGR', sum(answer+0) as 'EvalScore',
		piggroupid, 
		  right(convert(varchar,picyear),2) +  'WK' + replicate('0', 2 - datalength(convert(varchar,picweek))) + convert(varchar,picweek) as 'PicWeek'
		from
			  (select cwd.weekofdate, weekenddate, contactid, facilitytypeid, fiscalperiod, fiscalyear, picyear, picweek
				 from [$(CentralData)].dbo.[Site] st (NOLOCK)
				 cross join [$(SolomonApp)].dbo.cftWeekDefinition as cwd (NOLOCK)
				 where cwd.WeekOfDate=@WkDt1
					   and facilitytypeid in (2,5,6) and pigsystemid<>1) s
				Inner join [$(CentralData)].dbo.Contact ct (NOLOCK) on ct.contactid=s.contactid and ct.statustypeid=1
				left join [$(SolomonApp)].dbo.cftSiteEval se (NOLOCK) on se.sitecontactid=s.contactid and convert(date,se.entrydate) between s.WeekOfDate and s.WeekEndDate
				Left Join [$(SolomonApp)].dbo.cftPigGroup cpg (NOLOCK) on cpg.sitecontactid = ct.contactid
						   and convert(date,se.entrydate) >= case when cpg.actstartdate ='1900' then cpg.eststartdate else cpg.actstartdate end 
						   and convert(date,se.entrydate) <= case when cpg.actCloseDate = '1900' then cpg.estCloseDate else cpg.ActCloseDate end 
				left join [$(SolomonApp)].[dbo].[cftSiteEvalResults] ser (NOLOCK) on se.eval_id=ser.eval_id
				left join [$(SolomonApp)].dbo.cftContact svc (NOLOCK) on se.SvcMgrContactID = svc.ContactID
						   and svc.ContactID not in (85, 67, 3721) -- Harris, Gifford, Ebert       
		group by weekofdate, weekenddate, entrydate, ct.contactid, ct.contactname, rTrim(svc.contactname),piggroupid,
					   right(convert(varchar,picyear),2) +  'WK' + replicate('0', 2 - datalength(convert(varchar,picweek))) + convert(varchar,picweek)
		) as alpha
		left join (Select t1.SiteContactId, t1.SvcMgrContactID, t1.effectivedate, t2.effectivedate - 1 as endDate
					 from [$(CentralData)].dbo.sitesvcmgrassignment t1 (NOLOCK) 
					 left join [$(CentralData)].dbo.sitesvcmgrassignment t2 (NOLOCK) on t1.sitecontactid=t2.sitecontactid
							   and t2.SiteSvcMgrAssignmentID = 
								   (Select min(SiteSvcMgrAssignmentID) from [$(CentralData)].dbo.sitesvcmgrassignment t3 (NOLOCK) 
									 where t3.sitecontactid=t1.sitecontactid and t3.effectiveDate>t1.effectivedate)
				   ) smc on smc.sitecontactid=alpha.contactid and alpha.weekofdate between smc.effectivedate and case when endDate is null then getdate() else enddate end
		left join [$(CentralData)].dbo.contact as c (NOLOCK) on c.contactid=smc.svcmgrcontactid
		group by alpha.contactid, sitename, servicemgr, c.contactname, weekofdate, case when EntryDate IS null then 0 else 1 end, PicWeek
	-- Update with 2nd weeks eval scores
	update #Mort_eval set #Mort_eval.EvalScore2=upData.evalscore, #Mort_eval.evals=#Mort_eval.evals+upData.evals
	   from (
			select alpha.ContactId, case when EntryDate IS null then 0 else 1 end as evals, 
				   avg(case when evalscore is null then 0 else evalscore end) as EvalScore
			from (
				select entrydate, ct.contactid, sum(answer+0) as 'EvalScore'
				from
					  (select cwd.weekofdate, weekenddate, contactid, facilitytypeid, fiscalperiod, fiscalyear, picyear, picweek
						 from [$(CentralData)].dbo.Site st (NOLOCK)
						 cross join [$(SolomonApp)].dbo.cftWeekDefinition as cwd (NOLOCK)
						 where cwd.WeekOfDate=@WkDt2
							   and facilitytypeid in (2,5,6) and pigsystemid<>1) s
						Inner join [$(CentralData)].dbo.Contact ct (NOLOCK) on ct.contactid=s.contactid and ct.statustypeid=1
						left join [$(SolomonApp)].dbo.cftSiteEval se (NOLOCK) on se.sitecontactid=s.contactid and convert(date,se.entrydate) between s.WeekOfDate and s.WeekEndDate
						left join [$(SolomonApp)].[dbo].[cftSiteEvalResults] ser (NOLOCK) on se.eval_id=ser.eval_id
				group by entrydate, ct.contactid
			) as alpha
			group by alpha.contactid, case when EntryDate IS null then 0 else 1 end
	   ) as upData
	   where #Mort_eval.contactid=upData.contactid
	-- Update with 3rd weeks eval scores
	update #Mort_eval set #Mort_eval.EvalScore3=upData.evalscore, #Mort_eval.evals=#Mort_eval.evals+upData.evals
	   from (
			select alpha.ContactId, case when EntryDate IS null then 0 else 1 end as evals, 
				   avg(case when evalscore is null then 0 else evalscore end) as EvalScore
			from (
				select entrydate, ct.contactid, sum(answer+0) as 'EvalScore'
				from
					  (select cwd.weekofdate, weekenddate, contactid, facilitytypeid, fiscalperiod, fiscalyear, picyear, picweek
						 from [$(CentralData)].dbo.Site st (NOLOCK)
						 cross join [$(SolomonApp)].dbo.cftWeekDefinition as cwd (NOLOCK)
						 where cwd.WeekOfDate=@WkDt3
							   and facilitytypeid in (2,5,6) and pigsystemid<>1) s
						Inner join [$(CentralData)].dbo.Contact ct (NOLOCK) on ct.contactid=s.contactid and ct.statustypeid=1
						left join [$(SolomonApp)].dbo.cftSiteEval se (NOLOCK) on se.sitecontactid=s.contactid and convert(date,se.entrydate) between s.WeekOfDate and s.WeekEndDate
						left join [$(SolomonApp)].[dbo].[cftSiteEvalResults] ser (NOLOCK) on se.eval_id=ser.eval_id
				group by entrydate, ct.contactid
			) as alpha
			group by alpha.contactid, case when EntryDate IS null then 0 else 1 end
	   ) as upData
	   where #Mort_eval.contactid=upData.contactid
	-- Update with 4th week eval scores
	update #Mort_eval set #Mort_eval.EvalScore4=upData.evalscore, #Mort_eval.evals=#Mort_eval.evals+upData.evals
	   from (
			select alpha.ContactId, case when EntryDate IS null then 0 else 1 end as evals, 
				   avg(case when evalscore is null then 0 else evalscore end) as EvalScore
			from (
				select entrydate, ct.contactid, sum(answer+0) as 'EvalScore'
				from
					  (select cwd.weekofdate, weekenddate, contactid, facilitytypeid, fiscalperiod, fiscalyear, picyear, picweek
						 from [$(CentralData)].dbo.Site st (NOLOCK) 
						 cross join [$(SolomonApp)].dbo.cftWeekDefinition as cwd (NOLOCK) 
						 where cwd.WeekOfDate=@WkDt4
							   and facilitytypeid in (2,5,6) and pigsystemid<>1) s
						Inner join [$(CentralData)].dbo.Contact ct (NOLOCK) on ct.contactid=s.contactid and ct.statustypeid=1
						left join [$(SolomonApp)].dbo.cftSiteEval se (NOLOCK) on se.sitecontactid=s.contactid and convert(date,se.entrydate) between s.WeekOfDate and s.WeekEndDate
						left join [$(SolomonApp)].[dbo].[cftSiteEvalResults] ser (NOLOCK) on se.eval_id=ser.eval_id
				group by entrydate, ct.contactid
			) as alpha
			group by alpha.contactid, case when EntryDate IS null then 0 else 1 end
	   ) as upData
	   where #Mort_eval.contactid=upData.contactid	   
	
	-- Now add in mortality information - 1st weeks
	update #Mort_eval set #Mort_eval.AVGMortalityPercent1=upData.AVGMortalityPercent
	from (
		SELECT cast(cft_PIG_GROUP_CENSUS.SiteContactID as int) as ContactID, cft_PIG_GROUP_CENSUS.PICYear_Week
		,	CASE WHEN CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2)) = 0 THEN 0
				ELSE CAST((CAST(SUM(cft_PIG_GROUP_CENSUS.PigDeaths) AS NUMERIC(10,2)) / CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2))) * 100 AS NUMERIC(10,2))
			END AVGMortalityPercent
		FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
		WHERE cft_PIG_GROUP_CENSUS.PICYear_Week = @PicWk1
		GROUP BY cft_PIG_GROUP_CENSUS.SiteContactID, cft_PIG_GROUP_CENSUS.PICYear_Week
	) as upData
	Where #Mort_eval.contactid=upData.ContactId
	-- Add in 2nd weeks mortality
	update #Mort_eval set #Mort_eval.AVGMortalityPercent2=upData.AVGMortalityPercent
	from (
		SELECT cast(cft_PIG_GROUP_CENSUS.SiteContactID as int) as ContactID, cft_PIG_GROUP_CENSUS.PICYear_Week
		,	CASE WHEN CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2)) = 0 THEN 0
				ELSE CAST((CAST(SUM(cft_PIG_GROUP_CENSUS.PigDeaths) AS NUMERIC(10,2)) / CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2))) * 100 AS NUMERIC(10,2))
			END AVGMortalityPercent
		FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
		WHERE cft_PIG_GROUP_CENSUS.PICYear_Week = @PicWk2
		GROUP BY cft_PIG_GROUP_CENSUS.SiteContactID, cft_PIG_GROUP_CENSUS.PICYear_Week
	) as upData
	Where #Mort_eval.contactid=upData.ContactId
	-- Add in 3rd weeks mortality
	update #Mort_eval set #Mort_eval.AVGMortalityPercent3=upData.AVGMortalityPercent
	from (
		SELECT cast(cft_PIG_GROUP_CENSUS.SiteContactID as int) as ContactID, cft_PIG_GROUP_CENSUS.PICYear_Week
		,	CASE WHEN CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2)) = 0 THEN 0
				ELSE CAST((CAST(SUM(cft_PIG_GROUP_CENSUS.PigDeaths) AS NUMERIC(10,2)) / CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2))) * 100 AS NUMERIC(10,2))
			END AVGMortalityPercent
		FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
		WHERE cft_PIG_GROUP_CENSUS.PICYear_Week = @PicWk3
		GROUP BY cft_PIG_GROUP_CENSUS.SiteContactID, cft_PIG_GROUP_CENSUS.PICYear_Week
	) as upData
	Where #Mort_eval.contactid=upData.ContactId
	-- Add in 4th weeks mortality
	update #Mort_eval set #Mort_eval.AVGMortalityPercent4=upData.AVGMortalityPercent
	from (
		SELECT cast(cft_PIG_GROUP_CENSUS.SiteContactID as int) as ContactID, cft_PIG_GROUP_CENSUS.PICYear_Week
		,	CASE WHEN CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2)) = 0 THEN 0
				ELSE CAST((CAST(SUM(cft_PIG_GROUP_CENSUS.PigDeaths) AS NUMERIC(10,2)) / CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2))) * 100 AS NUMERIC(10,2))
			END AVGMortalityPercent
		FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
		WHERE cft_PIG_GROUP_CENSUS.PICYear_Week = @PicWk4
		GROUP BY cft_PIG_GROUP_CENSUS.SiteContactID, cft_PIG_GROUP_CENSUS.PICYear_Week
	) as upData
	Where #Mort_eval.contactid=upData.ContactId
	
	-- Get the average mortality for the 4 week period and set the min PicWeek
	update #Mort_eval set #Mort_eval.RollupAvgMort = (AVGMortalityPercent1 + AVGMortalityPercent2 + AVGMortalityPercent3 + AVGMortalityPercent4 )/4, 
		   #Mort_eval.RollupAvgScore=(#Mort_eval.EvalScore1+#Mort_eval.EvalScore2+#Mort_eval.EvalScore3+#Mort_eval.EvalScore4)/(case when #Mort_eval.evals=0 then 1 else #Mort_eval.evals end),
	       #Mort_eval.minPicWeek=@PicWk4
	
	--select contactid, count(*) from #Mort_eval group by contactid having count(*) > 1
	select * from #Mort_eval

	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MORT_EVAL_CORRELATION] TO [CorpReports]
    AS [dbo];

