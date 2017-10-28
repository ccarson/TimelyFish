
CREATE Procedure [dbo].[xx_cfp_MrkMgrPerf]
    @vLoadType1 varchar(40), @vLoadType2 varchar(40), @vMktMgr varchar(100), @vWks int, @vPacker varchar(40)
/* 
16Mar2016  Created by Brian Diehl to support the SSRS Market Manager Performance Report.  This feeds the detail charts and tables on the report.
*/
AS
BEGIN

	select
		rtrim(Site) as site, rtrim(PigGroupID) as PigGroupID, KillDate, rtrim(Packer) as Packer, 
					 rtrim(BarnNbr) as BarnNbr, BarnLoadID, rtrim(PMID) as PMLoadID, TotalHead, 
					 CAST( HotWgt AS decimal( 4, 1 ) ) HotWgt, 
					 CAST( LiveWgtAvg AS decimal( 5, 2 ) ) LiveWgtAvg, 
					 CAST( LiveWgtSTD AS decimal( 5, 2 ) ) LiveWgtSTD,
					 rtrim(MktMgr) as MktMgr, rtrim(LoadType) as LoadType, RowID
		, MAX (RowID) over (PARTITION by MktMgr) MaxSetSize
		, CASE when RowID = 0 then 'Green' 
		  else
			  case RowID/(case when Ceiling(MAX (RowID) over (PARTITION by MktMgr) / 6) = 0 then 1 else Ceiling(MAX (RowID) over (PARTITION by MktMgr) / 6) end) 
				when 0 then 'cornsilk'-- 'LightSteelBlue'
				when 1 then 'wheat'-- 'SlateBlue'
				when 2 then 'tan'-- 'RoyalBlue'
				when 3 then 'goldenrod'-- 'MediumBlue'
				when 4 then 'peru'-- 'Salmon'
				when 5 then 'sienna'-- 'Red'
				when 6 then 'brown'-- 'FireBrick'
				else 'Silver'
			  end  -- http://ascii-code.com/html-color-names.php
						end
		  as Color
		, CAST( Case when Rowid = 0 then
			 AVG (WghtdStdDev) over (partition by RowId)/AVG (TotalHead) over (partition by RowId)
		  Else 0
		  End as decimal( 5, 2 ) ) AS PrWkAvgWeightedStdDev
		, CAST( Case when Rowid = 0 then
			 AVG (WghtdAvgWgt) over (partition by RowId)/AVG (TotalHead) over (partition by RowId)
		  Else 0
		  End AS decimal( 4, 1 ) ) as PrWkAvgWeightedWgtAvg
	from (

		select 
			rtrim(sc.ContactName) Site, pd.BarnNbr, pd.PigGroupID, pd.KillDate, 
			Case when pc.ContactName like '%Swift%' and swctr.ContrNbr='000010' then 'Swift Light'
				 when pc.ContactName like '%Swift%' and swctr.ContrNbr='000023' then 'Swift Heavy'
				 else rtrim(pc.ContactName) end Packer, 
			pd.PMLoadID BarnLoadID, pm.PMID, sum(pd.TotalHead) as TotalHead,
			avg(pd.HotWgt) as HotWgt, 
			avg(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538 else pd.HotWgt/pd.YldPct end) LiveWgtAvg, 
			stdev(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538 else pd.HotWgt/pd.YldPct end) LiveWgtSTD,
			MG.ContactName MktMgr,
			mst.[Description] LoadType,
			CASE when pd.KillDate >= dateadd(WW,-1,dateadd(d, - datepart(DW, GETDATE()) + 1, GETDATE())) then 0 
				 else ROW_NUMBER() over (order by pd.KillDate ) 
			End as RowID,
			stdev(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538
				 else pd.HotWgt/pd.YldPct end) * SUM(pd.TotalHead) WghtdStdDev,
			avg(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538
				 else pd.HotWgt/pd.YldPct end) * SUM(pd.TotalHead) WghtdAvgWgt
		From dbo.cft_PACKER_DETAIL pd
		left join [SolomonApp].dbo.cftContact pc on pd.PkrContactID = pc.ContactID
		left join [SolomonApp].dbo.cftContact sc on pd.SiteContactID = sc.ContactID
		left join [SolomonApp].dbo.cfvCurrentMktSvcMgr mg on pd.SiteContactID=mg.SiteContactID
		left join [SolomonApp].dbo.cftPM pm (nolock) on pd.PMLoadID=pm.PMID
		left join [SolomonApp].dbo.cftMarketSaleType mst on pm.MarketSaleTypeID = mst.MarketSaleTypeID
		left join
			(Select Case when sw.PlantNbr='00092' then '000555' when sw.PlantNbr='00048' then '000554' end 'PlantID', sw.KillDate, 
			sw.TattooNbr, sw.RecordID, ps.ContrNbr
			from [SolomonApp].dbo.cftPSDetSwift sw
			join (select PkrContactId, KillDate, ContrNbr, TattooNbr, SUM(HeadCount) headcount 
				  from [SolomonApp].dbo.cfvPIGSALEREV ps
				  where 1=1
				  and ps.PkrContactId in ('000554','000555')
				  and ps.ContrNbr in ('000023','000010')
				  group by PkrContactId, KillDate, ContrNbr, TattooNbr) ps
				  on ps.PkrContactId = Case Sw.PlantNbr
				  when '00048' then '000554' -- Swift-Marshalltown
				  when '00092' then '000555' --Swift-Worthington
				  end 
				  and ps.KillDate = sw.KillDate
				  and ps.tattoonbr = sw.TattooNbr
			) swctr on pd.CarcassID=swctr.RecordID and pd.PkrContactID=swctr.PlantID         

		Where pd.KillDate between dateadd(WW,-cast(@vWks as int),dateadd(d, - datepart(DW, GETDATE()) + 1, GETDATE())) -- Go back 13 weeks on a Sunday basis
	--	      pd.KillDate between dateadd(WW,-13,dateadd(d, - datepart(DW, GETDATE()) + 1, GETDATE())) -- Go back 13 weeks on a Sunday basis
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
			Case when pc.ContactName like '%Swift%' and swctr.contrnbr='000010' then 'Swift Light'
				 when pc.ContactName like '%Swift%' and swctr.contrnbr='000023' then 'Swift Heavy'
				 else rtrim(pc.ContactName) end, 
			pd.PMLoadID, pm.PMID, 
			MG.ContactName,
			mst.[Description]
		Having stdev(Case when pc.ContactName like '%Triumph%' then pd.HotWgt/.7538 else pd.HotWgt/pd.YldPct end) between 10.0 and 55.0
		
	) MarketLoads

	order by KillDate
	
END
