





-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame Farm Board Sow Data Daily Summary
-- Parameters: 	@WeekName, 
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
CREATE PROCEDURE [dbo].[CFP_FB_DailyFarrowSummary] 
@GroupName nvarchar(4),
@FarmName nvarchar(30)

AS

create table #Dailytemp
(
	FarmName nvarchar(30),
    EventWeek [nvarchar](4), 
	EventDate Datetime,
    Metric nvarchar (30),
	ActualAmount int,
	AnimalType  nvarchar (6),
	ScreenOrder int
)

Insert into #Dailytemp 

select   Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,AE.[EVENTDATE] as 'EventDate'
		,Cast('# Farrowed' as nvarchar (80)) as 'Metric'
		,Count(AE.ID) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (6)) as 'AnimalType'
		,1 as 'ScreenOrder'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
where AE.PARITYNBR = 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

 Union

select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,AE.[EVENTDATE] as 'EventDate'
		,Cast('# Farrowed' as nvarchar (80)) as 'Metric'
		,Count(AE.ID) as 'ActualAmount'
		,Cast('Sow' as nvarchar (6)) as 'AnimalType'
		,2 as 'ScreenOrder'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
where AE.PARITYNBR > 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

 Union
 
  select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
  		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Total Born' as nvarchar (80)) as 'Metric'
		,Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (6)) as 'AnimalType'
		,3 as 'ScreenOrder'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
where AE.PARITYNBR = 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

Union
 
  select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
  		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Total Born' as nvarchar (80)) as 'Metric'
		,Sum(AE.BORNALIVE + AE.STILLBORN + AE.MUMMY) as 'ActualAmount'
		,Cast('Sow' as nvarchar (6)) as 'AnimalType'
		,4 as 'ScreenOrder'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
where AE.PARITYNBR > 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

Union

 select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
 		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Live Born' as nvarchar (80)) as 'Metric'
		,Sum(AE.BORNALIVE) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (6)) as 'AnimalType'
		,5 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR = 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

union

select   Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Live Born' as nvarchar (80)) as 'Metric'
		,Sum(AE.BORNALIVE) as 'ActualAmount'
		,Cast('Sow' as nvarchar (6)) as 'AnimalType'
		,6 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR > 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

union

select   Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Stillborn' as nvarchar (80)) as 'Metric'
		,Sum(AE.STILLBORN) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (6)) as 'AnimalType'
		,7 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR = 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

 Union

 select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
 		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Stillborn' as nvarchar (80)) as 'Metric'
		,Sum(AE.STILLBORN) as 'ActualAmount'
		,Cast('Sow' as nvarchar (6)) as 'AnimalType'
		,8 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE 

where AE.PARITYNBR > 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

union

select   Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Mummies' as nvarchar (80)) as 'Metric'
		,Sum(AE.MUMMY) as 'ActualAmount'
		,Cast('Sow' as nvarchar (6)) as 'AnimalType'
		,10 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR > 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

 Union

 select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
 		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Mummies' as nvarchar (80)) as 'Metric'
		,Sum(AE.MUMMY) as 'ActualAmount'
		,Cast('Gilt' as nvarchar (6)) as 'AnimalType'
		,9 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE

where AE.PARITYNBR = 1
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

Union

select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
 		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Piglet Deaths' as nvarchar (80)) as 'Metric'
		,Sum(AE.qty) as 'ActualAmount'
		,Cast('Day 1-3' as nvarchar (6)) as 'AnimalType'
		,11 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Prewean Death'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
CROSS APPLY (Select TOP 1 EVENTDATE, LOCATIONID FROM dbo.CFT_ANIMALEVENTS FE
					 JOIN [MobileFrame].[dbo].[CFT_EVENTTYPE] ETM (NOLOCK) ON FE.EVENTTYPEID = ETM.ID AND ETM.EVENTNAME = 'Farrowing'	
					 where FE.PARITYNBR = AE.PARITYNBR AND FE.ANIMALID = AE.ANIMALID AND FE.[DELETED_BY] = -1) FE


where AE.PARITYNBR = 1 AND DATEDIFF(d,FE.EVENTDATE,AE.EVENTDATE) < 4
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

Union

select  Cast(FARM.Name as nvarchar(50)) as 'FarmName' 
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
 		,AE.[EVENTDATE] as 'EventDate'
		,Cast('Piglet Deaths' as nvarchar (80)) as 'Metric'
		,Sum(AE.qty) as 'ActualAmount'
		,Cast('Day 4+' as nvarchar (6)) as 'AnimalType'
		,11 as 'ScreenOrder'
FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Prewean Death'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
CROSS APPLY (Select TOP 1 EVENTDATE, LOCATIONID FROM dbo.CFT_ANIMALEVENTS FE
					 JOIN [MobileFrame].[dbo].[CFT_EVENTTYPE] ETM (NOLOCK) ON FE.EVENTTYPEID = ETM.ID AND ETM.EVENTNAME = 'Farrowing'	
					 where FE.PARITYNBR = AE.PARITYNBR AND FE.ANIMALID = AE.ANIMALID AND FE.[DELETED_BY] = -1) FE


where AE.PARITYNBR = 1 AND DATEDIFF(d,FE.EVENTDATE,AE.EVENTDATE) > 4
AND wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

Select * from #Dailytemp order by ScreenOrder


Drop table #Dailytemp 


