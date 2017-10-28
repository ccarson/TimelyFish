
/* 
16Mar2016  Created by Brian Diehl to support the SSRS Market Manager Performance Report.  This feeds the trend tables on the report.
*/
CREATE Procedure [xx_cfp_MrkMgrPerf_Trend]
    @vLoadType1 varchar(40), @vLoadType2 varchar(40), @vMktMgr varchar(100), @vWks int, @vPacker varchar(40)
AS
BEGIN
	select distinct rtrim(MktMgr) as MktMgr, PicYrWk, WkAvgWeightedStdDev, WkAvgWeightedWgtAvg
	  from (
		select rtrim(MktMgr) as MktMgr, PicYrWk
			, AVG (WghtdStdDev) over (partition by PicYrWk)/AVG (TotalHead) over (partition by PicYrWk) as WkAvgWeightedStdDev
			, AVG (WghtdAvgWgt) over (partition by PicYrWk)/AVG (TotalHead) over (partition by PicYrWk) as WkAvgWeightedWgtAvg
		from (

			select 
				rtrim(sc.ContactName) Site, pd.BarnNbr, pd.PigGroupID, pd.KillDate, 
				Case when pc.ContactName like '%Swift%' and swctr.contrnbr='000010' then 'Swift Light'
					 when pc.ContactName like '%Swift%' and swctr.contrnbr='000023' then 'Swift Heavy'
					 else rtrim(pc.ContactName) end Packer, 
				pd.PMLoadID BarnLoadID, pm.PMID, sum(pd.TotalHead) as TotalHead,
				avg(pd.HotWgt) as HotWgt, 
				avg(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538
					 else pd.HotWgt/pd.YldPct end) LiveWgtAvg, 
				stdev(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538
					 else pd.HotWgt/pd.YldPct end) LiveWgtSTD,
				MG.ContactName MktMgr,
				mst.[Description] LoadType,
				CASE when pd.KillDate >= dateadd(WW,-1,dateadd(d, - datepart(DW, GETDATE()) + 1, GETDATE())) then 0 
					 else ROW_NUMBER() over (order by pd.KillDate ) 
				End as RowID,
				stdev(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538
					 else pd.HotWgt/pd.YldPct end) * SUM(pd.TotalHead) WghtdStdDev,
				avg(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538
					 else pd.HotWgt/pd.YldPct end) * SUM(pd.TotalHead) WghtdAvgWgt,
				RIGHT(RTRIM(cast(cwd.PICYear as varchar)),2) + 'WK' + right('00' + CAST(cwd.PICWeek as varchar), 2) as PicYrWk
			From dbo.cft_PACKER_DETAIL pd
			left join [SolomonApp].dbo.cftWeekDefinition cwd on pd.KillDate between cwd.WeekOfDate and cwd.WeekEndDate
			left join [SolomonApp].dbo.cftContact pc on pd.PkrContactID = pc.ContactID
			left join [SolomonApp].dbo.cftContact sc on pd.SiteContactID = sc.ContactID
			left join [SolomonApp].dbo.cfvCurrentMktSvcMgr mg on pd.SiteContactID=mg.SiteContactID
			left join [SolomonApp].dbo.cftPM pm (nolock) on pd.PMLoadID=pm.PMID
			left join [SolomonApp].dbo.cftMarketSaleType mst on pm.MarketSaleTypeID=mst.MarketSaleTypeID
			left join
				(Select Case when sw.PlantNbr='00092' then '000555' when sw.PlantNbr='00048' then '000554' end 'PlantID', sw.KillDate, 
				sw.TattooNbr, sw.RecordID, ps.ContrNbr
				from [SolomonApp].dbo.cftPSDetSwift sw
				join (select PkrContactId, KillDate, ContrNbr, TattooNbr, sum(HeadCount) headcount 
					  from [SolomonApp].dbo.cfvPIGSALEREV ps
					  where 1=1
					  and ps.PkrContactId in ('000554','000555')
					  and ps.ContrNbr IN ('000023','000010')
					  group by PkrContactId, KillDate, ContrNbr, TattooNbr) ps
					  on ps.PkrContactId = Case Sw.PlantNbr
					  when '00048' then '000554' -- Swift-Marshalltown
					  when '00092' then '000555' --Swift-Worthington
					  end 
					  and ps.KillDate = sw.KillDate
					  and ps.TattooNbr = sw.TattooNbr
				) swctr on pd.CarcassID=swctr.RecordID and pd.PkrContactID=swctr.PlantID         

			Where pd.KillDate between dateadd(WW,-cast(@vWks as int),dateadd(d, - datepart(DW, GETDATE()) + 1, GETDATE())) -- Go back 13 weeks on a Sunday basis
				--  pd.KillDate between dateadd(WW,-13,dateadd(d, - datepart(DW, GETDATE()) + 1, GETDATE())) -- Go back 13 weeks on a Sunday basis
								  and dateadd(d, - datepart(DW, GETDATE()), GETDATE())
			  and mg.ContactName = @vMktMgr 
			  and (mst.[Description] like @vLoadType1 or mst.[Description] like @vLoadType2)
			  and pc.ContactName like @vPacker
			  and pd.PMLoadID in (
									select PMLoadID
									from (
										select PMLoadID
											 , COUNT(*) over (partition by PMLoadID, HotWgt) as cnt_by_wt
										  from dbo.cft_PACKER_DETAIL pd1 
										 where HotWgt between 75 and 300 and
											   LeanPct between 45 and 62 and
											   pd1.KillDate between dateadd(WW,-cast(@vWks as int),dateadd(d, - datepart(DW, GETDATE()) + 1, GETDATE())) -- Go back 13 weeks on a Sunday basis
											   --pd1.KillDate between dateadd(WW,-13,dateadd(d, - datepart(DW, GETDATE()) + 1, GETDATE())) -- Go back 13 weeks on a Sunday basis
															   and GETDATE()
									) keep_Loads
									group by PMLoadID
									having MAX(cast(cnt_by_wt as float))/COUNT(1.0) < .250
								  )
			   and pd.HotWgt between 75 and 300 and pd.LeanPct between 45 and 62
			group by 
				rtrim(sc.ContactName) , pd.BarnNbr, pd.PigGroupID, pd.KillDate, 
				Case when pc.ContactName like '%Swift%' and swctr.ContrNbr='000010' then 'Swift Light'
					 when pc.ContactName like '%Swift%' and swctr.ContrNbr='000023' then 'Swift Heavy'
					 else rtrim(pc.ContactName) end, 
				pd.PMLoadID, pm.PMID, 
				MG.ContactName,
				mst.[Description],
				RIGHT(RTRIM(cast(cwd.PICYear as varchar)),2) + 'WK' + right('00' + CAST(cwd.PICWeek as varchar), 2)
			Having stdev(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538 else pd.HotWgt/pd.YldPct end) between 10.0 and 55.0
			
		) MarketLoads
	) WeightedAvgs
	order by PicYrWk
	
END
