





-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame Farm Board Sow Data Weekly Summary
-- Parameters: 	@WeekName,LastWeek,PrevWeek 
--		@FarmName,
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
10/3/2017	DDAHLE,				Initial Build.

========================================================================================================
*/
CREATE PROCEDURE [dbo].[CFP_FB_WeeklyFarrowSummaryWithTargets] 
@WeekName nvarchar(4),
@LastWeek nvarchar(4),
@PrevWeek nvarchar(4),
@FarmName nvarchar(30)

AS

create table #Temp
(
	FarmName nvarchar(30),
    EventWeek [nvarchar](4), 
    Metric nvarchar (30),
	ActualAmount decimal (10,4),
	AnimalType  nvarchar (4),
	ScreenOrder int
)
Insert into #Temp 

select   Cast(FARM.Name as nvarchar(30)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('# Farrowed' as nvarchar (30)) as 'Metric'
		,CAST(Count(AE.ID) as decimal (10,4)) as 'ActualAmount'
		,Cast('' as nvarchar (4)) as 'AnimalType'
		,1 as 'ScreenOrder'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
Where wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

 Union

 select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('Total Born' as nvarchar (80)) as 'Metric'
		,CAST(Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as decimal (10,4)) as 'ActualAmount'
		,Cast('' as nvarchar (4)) as 'AnimalType'
		,6 as 'ScreenOrder'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
Where wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

union

select   Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('Avg Total Born' as nvarchar (80)) as 'Metric'
		,CAST(CAST(Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as float)/ CAST(Count(AE.ID) as float) as decimal (10,4)) as 'ActualAmount'
		,Cast('Sow' as nvarchar (4)) as 'AnimalType'
		,7 as 'ScreenOrder'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR > 1
AND wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

 Union

 select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('Avg Total Born' as nvarchar (80)) as 'Metric'
		,CAST(CAST(Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as float)/ CAST(Count(AE.ID) as float) as decimal (10,4)) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (4)) as 'AnimalType'
		,2 as 'ScreenOrder'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR = 1
AND wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

union

select   Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('Avg Liveborn' as nvarchar (80)) as 'Metric'
		,CAST(CAST(Sum(AE.BORNALIVE) as float)/ CAST(Count(AE.ID) as float) as decimal (10,4)) as 'ActualAmount'
		,Cast('Sow' as nvarchar (4)) as 'AnimalType'
		,8 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR > 1
AND wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

 Union

 select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('Avg Liveborn' as nvarchar (80)) as 'Metric'
		,CAST(CAST(Sum(AE.BORNALIVE) as float)/ CAST(Count(AE.ID) as float) as decimal (10,4)) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (4)) as 'AnimalType'
		,3 as 'ScreenOrder'
		
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE 

where AE.PARITYNBR = 1
AND wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

union

select   Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('% Stillborn' as nvarchar (80)) as 'Metric'
		,CAST((CAST(Sum(AE.STILLBORN) as float)/ CAST(Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as float)) as decimal (10,4)) as 'ActualAmount'
		,Cast('Sow' as nvarchar (4)) as 'AnimalType'
		,9 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR > 1
AND wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

 Union

 select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('% Stillborn' as nvarchar (80)) as 'Metric'
		,CAST((CAST(Sum(AE.STILLBORN) as float)/ CAST(Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as float)) as decimal (10,4)) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (4)) as 'AnimalType'
		,4 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR = 1
AND wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

union

select   Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('% Mummified' as nvarchar (80)) as 'Metric'
		,CAST((CAST(Sum(AE.MUMMY) as float)/ CAST(Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as float)) as decimal (10,4)) as 'ActualAmount'
		,Cast('Sow' as nvarchar (4)) as 'AnimalType'
		,10 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR > 1
AND wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by  FARM.NAME,WD.GROUPNAME

 Union

 select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,Cast('% Mummified' as nvarchar (80)) as 'Metric'
		,CAST((CAST(Sum(AE.MUMMY) as float)/ CAST(Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as float)) as decimal (10,4)) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (4)) as 'AnimalType'
		,5 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE 

where AE.PARITYNBR = 1
AND wd.GROUPNAME in (@WeekName, @LastWeek, @PrevWeek)
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME


--Select * from #temp

SELECT	[EventWeek]
      ,wfs.[Metric]
      ,[ActualAmount]
      ,wfs.[AnimalType]
	  ,Cast (FT.[TARGET] as decimal (10,4)) as 'Target'
      ,FT.[TargetType]
	  ,[ScreenOrder]
  FROM #temp wfs
  Join [dbo].[CFV_FB_FarmWeeklyTargets] FT on FT.TARGETNAME = wfs.Metric 
  Where wfs.AnimalType = FT.AnimalType
  and wfs.FarmName = FT.Farm 
  and wfs.EventWeek = FT.groupname
  order by ScreenOrder


Drop table #Temp


