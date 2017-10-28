







-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame Sow Data Weekly Summary
-- Parameters: 	@GroupName, 
--		@FarmName,
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
09/26/2017	DDAHLE,				Initial Build.

========================================================================================================
*/
CREATE PROCEDURE [dbo].[CFP_REPORT_SOWDATA_WEEKLY_SUMMARY] 
@GroupName nvarchar(20),
@FarmName nvarchar(50),
@Detailed bit

AS

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp
create table #Temp
(
    BreedGroup [nvarchar](20), 
    EventDate DatetIme, 
    EventName varchar(30),
	EventCount int,
)
Insert into #Temp 

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Total Matings' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.GROUPNAME = GE.GROUPNAME
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'MATING'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and ME.MATINGNBR=1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

Union

select GE.GROUPNAME as 'BreedGroup'
--,DATEADD(day, -1, ME.[EVENTDATE]) as 'EventDate'
,ME1.[EVENTDATE] as 'EventDate'
,'Multiple Matings' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.GROUPNAME = GE.GROUPNAME
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'MATING'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID
Cross Apply (select top 1 ME1.EVENTDATE From dbo.CFT_ANIMALEVENTS ME1 
		Join [dbo].[CFT_EVENTTYPE] as ET2 on ME1.[EVENTTYPEID] = ET2.ID AND ET2.[EVENTNAME] like 'MATING'
			where ME1.ANIMALID = ME.ANIMALID AND ME1.GROUPNAME = ME.GROUPNAME AND ME1.MATINGNBR = 1 Order by ME1.EVENTDATE) ME1

Where
GE.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and ME.MATINGNBR = 2
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME1.[EVENTDATE]

Union

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Wean' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.GROUPNAME = GE.GROUPNAME
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'MATING'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.MATINGNBR=1
and ME.PREVSTATUS = 4
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

Union

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Late Wean' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.GROUPNAME = GE.GROUPNAME
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'MATING'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.MATINGNBR=1
and ME.PREVSTATUS = 5
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Returns' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.GROUPNAME = GE.GROUPNAME
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'MATING'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.MATINGNBR=1
and ME.PREVSTATUS = 6
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Opportunity' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.GROUPNAME = GE.GROUPNAME
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'MATING'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.MATINGNBR=1
and ME.PREVSTATUS = 7
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Gilt' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.GROUPNAME = GE.GROUPNAME
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'MATING'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.MATINGNBR=1
and ME.PREVSTATUS = 9
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Abortions' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Abortion'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Preg Test Positive' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Preg Test Positive'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Preg Test Negative' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Preg Test Negative'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

Union

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Observed Heat' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Observed Heat'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Farrowing Litters' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Sow Litters' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR > 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Gilt Litters' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR = 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Total Born' as 'EventName'
,Sum(ME.BORNALIVE + ME.STILLBORN + ME.MUMMY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Sow Total Born' as 'EventName'
,Sum(ME.BORNALIVE + ME.STILLBORN + ME.MUMMY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR > 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Gilt Total Born' as 'EventName'
,Sum(ME.BORNALIVE + ME.STILLBORN + ME.MUMMY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR = 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Total LiveBorn' as 'EventName'
,Sum(ME.BORNALIVE) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Sow LiveBorn' as 'EventName'
,Sum(ME.BORNALIVE) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR > 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Gilt LiveBorn' as 'EventName'
,Sum(ME.BORNALIVE) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR = 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Total Stillborn' as 'EventName'
,Sum(ME.STILLBORN) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Sow Stillborn' as 'EventName'
,Sum(ME.STILLBORN) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR > 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Gilt Stillborn' as 'EventName'
,Sum(ME.STILLBORN) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR = 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Total Mummies' as 'EventName'
,Sum(ME.MUMMY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Sow Mummies' as 'EventName'
,Sum(ME.MUMMY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR > 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Gilt Mummies' as 'EventName'
,Sum(ME.MUMMY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.PARITYNBR = 1
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]


UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Sows Weaned' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Wean'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Litters Weaned' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Wean' and ME.QTY > 0
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Nurse Sows Created' as 'EventName'
,Count(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Nurse On' 
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Piglets Weaned' as 'EventName'
,SUM(ME.QTY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Wean'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Prewean Death' as 'EventName'
,SUM(ME.QTY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Prewean Death'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'PD Day 1-3' as 'EventName'
,SUM(ME.QTY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Prewean Death'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID
CROSS APPLY (Select TOP 1 EVENTDATE, LOCATIONID FROM dbo.CFT_ANIMALEVENTS FE
					 JOIN [MobileFrame].[dbo].[CFT_EVENTTYPE] ETM (NOLOCK) ON FE.EVENTTYPEID = ETM.ID AND ETM.EVENTNAME = 'Farrowing'	
					 where FE.PARITYNBR = ME.PARITYNBR AND FE.ANIMALID = ME.ANIMALID AND FE.[DELETED_BY] = -1) FE

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
AND DATEDIFF(d,FE.EVENTDATE,ME.EVENTDATE) < 4
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'PD Day 4+' as 'EventName'
,SUM(ME.QTY) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Prewean Death'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID
CROSS APPLY (Select TOP 1 EVENTDATE, LOCATIONID FROM dbo.CFT_ANIMALEVENTS FE
					 JOIN [MobileFrame].[dbo].[CFT_EVENTTYPE] ETM (NOLOCK) ON FE.EVENTTYPEID = ETM.ID AND ETM.EVENTNAME = 'Farrowing'	
					 where FE.PARITYNBR = ME.PARITYNBR AND FE.ANIMALID = ME.ANIMALID AND FE.[DELETED_BY] = -1) FE

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
AND DATEDIFF(d,FE.EVENTDATE,ME.EVENTDATE) >= 4
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Gilt Arrival' as 'EventName'
,COUNT(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Arrival'
Join dbo.CFT_ANIMAL a on a.ID = me.ANIMALID
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and a.SEX = 'F'
and ME.PARITYNBR = 0 
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Sow Arrival' as 'EventName'
,Case when COUNT(ME.ID) is Null then 0 else COUNT(ME.ID) END as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Arrival'
Join dbo.CFT_ANIMAL a on a.ID = me.ANIMALID
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and a.SEX = 'F'
and ME.PARITYNBR > 0 
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Female Death' as 'EventName'
,COUNT(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Death'
Join dbo.CFT_ANIMAL a on a.ID = me.ANIMALID
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and a.SEX = 'F'
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Female Euth' as 'EventName'
,COUNT(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Euth'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_ANIMAL a on fa.ANIMALID = a.ID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and a.SEX = 'F'
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Female Cull' as 'EventName'
,COUNT(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Cull'
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_ANIMAL a on fa.ANIMALID = a.ID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and a.SEX = 'F'
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 1
Group by GE.GROUPNAME,ME.[EVENTDATE]

UNION

select GE.GROUPNAME as 'BreedGroup'
,ME.[EVENTDATE] as 'EventDate'
,'Female Removal' as 'EventName'
,COUNT(ME.ID) as 'EventCount'

FROM dbo.CFT_WEEKDEFINITION GE
join dbo.CFT_ANIMALEVENTS ME on ME.EVENTDATE Between GE.WEEKOFDATE and GE.WEEKENDDATE
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] in ('Cull','Euth','Death')
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_ANIMAL a on fa.ANIMALID = a.ID
join dbo.CFT_FARM farm on farm.ID=fa.FARMID

Where
GE.GROUPNAME= @GroupName
and farm.NAME = @FarmName
and a.SEX = 'F'
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
and @Detailed = 0
Group by GE.GROUPNAME,ME.[EVENTDATE];


--Subtract Nurse sows from Wean sows

Update #Temp
set EventCount = Case when ws.EventCount - ns.EventCount <= 0 Then 0 else ws.EventCount - ns.EventCount END
from #Temp ws
Join (select EventCount, EventDate from #Temp ns where ns.EventName like 'Nurse Sows Created') ns on ns.EventDate = ws.EventDate
where ws.EventName like 'Sows Weaned'

DECLARE @startdate datetime
DECLARE @enddate datetime

select top 1 @startdate = G.WEEKOFDATE, @enddate = G.WEEKENDDATE FROM dbo.CFT_WEEKDEFINITION G where G.GROUPNAME = @GroupName 

WHILE @enddate >= @startdate
	BEGIN
	Insert into #Temp 
	select GE.GROUPNAME as 'BreedGroup'
	,@startdate as 'EventDate'
	,'Female Inventory' as 'EventName'
	,COUNT(FA.ID) as 'EventCount'

	FROM dbo.CFT_WEEKDEFINITION GE
	join dbo.CFT_FARMANIMAL FA on FA.[ENTRYDATE] <= @startdate
	join dbo.CFT_ANIMAL a on fa.ANIMALID = a.ID
	join dbo.CFT_FARM farm on farm.ID=fa.FARMID

	Where
	GE.GROUPNAME= @GroupName
	and farm.NAME = @FarmName
	and a.SEX = 'F'
	and A.DELETED_BY = -1
	and FA.DELETED_BY = -1
	and (FA.REMOVALDATE > @startdate OR FA.REMOVALDATE is Null)
	Group by GE.GROUPNAME,GE.WEEKENDDATE;

	Insert into #Temp 
	select GE.GROUPNAME as 'BreedGroup'
	,@startdate as 'EventDate'
	,'BOAR Inventory' as 'EventName'
	,COUNT(FA.ID) as 'EventCount'

	FROM dbo.CFT_WEEKDEFINITION GE
	join dbo.CFT_FARMANIMAL FA on FA.[ENTRYDATE] <= @startdate
	join dbo.CFT_ANIMAL a on fa.ANIMALID = a.ID
	join dbo.CFT_FARM farm on farm.ID=fa.FARMID

	Where
	GE.GROUPNAME= @GroupName
	and farm.NAME = @FarmName
	and a.SEX = 'M'
	and A.DELETED_BY = -1
	and FA.DELETED_BY = -1
	and (FA.REMOVALDATE > @startdate OR FA.REMOVALDATE is Null)
	Group by GE.GROUPNAME,GE.WEEKENDDATE;

	Insert into #Temp 
	select @GroupName as 'BreedGroup'
	,@startdate as 'EventDate'
	,'Pic Day' as 'EventName'
	,DATEDIFF(DAY, '9/27/1971', @startdate) % 1000 as 'EventCount';

	SET @startdate = @startdate + 1
END;
IF OBJECT_ID('tempdb..#Summary') IS NOT NULL DROP TABLE #Summary
create table #Summary
(
	GroupName nvarchar(20)
	,FarmName nvarchar(50)
    ,EventName varchar(30)
	,Sunday int
	,Monday int
	,Tuesday int
	,Wednesday int
	,Thursday int
	,Friday int
	,Saturday int
	,TotalCount int
	,Sort int
);


DECLARE @DayNbr int
SET @DayNbr = 1

Insert into #Summary (EventName
	,GroupName
	,FarmName
	,Sunday
	,Monday 
	,Tuesday
	,Wednesday 
	,Thursday 
	,Friday 
	,Saturday
	,Sort
	,TotalCount) VALUES
	('Pic Day',@GroupName,@FarmName,0,0,0,0,0,0,0,1,0)
	,('Total Matings',@GroupName,@FarmName,0,0,0,0,0,0,0,3,0)
	,('Multiple Matings',@GroupName,@FarmName,0,0,0,0,0,0,0,25,0)
	,('Abortions',@GroupName,@FarmName,0,0,0,0,0,0,0,40,0)
	,('Preg Test Positive',@GroupName,@FarmName,0,0,0,0,0,0,0,45,0)
	,('Preg Test Negative',@GroupName,@FarmName,0,0,0,0,0,0,0,50,0)
	,('Observed Heat',@GroupName,@FarmName,0,0,0,0,0,0,0,55,0)
	,('Farrowing Litters',@GroupName,@FarmName,0,0,0,0,0,0,0,60,0)
	,('Total LiveBorn',@GroupName,@FarmName,0,0,0,0,0,0,0,66,0)
	,('Total Stillborn',@GroupName,@FarmName,0,0,0,0,0,0,0,70,0)
	,('Total Mummies',@GroupName,@FarmName,0,0,0,0,0,0,0,75,0)
	,('Sows Weaned',@GroupName,@FarmName,0,0,0,0,0,0,0,80,0)
	,('Litters Weaned',@GroupName,@FarmName,0,0,0,0,0,0,0,85,0)
	,('Nurse Sows Created',@GroupName,@FarmName,0,0,0,0,0,0,0,90,0)
	,('Piglets Weaned',@GroupName,@FarmName,0,0,0,0,0,0,0,95,0) 
	,('Prewean Death',@GroupName,@FarmName,0,0,0,0,0,0,0,97,0)
	,('Female Inventory',@GroupName,@FarmName,0,0,0,0,0,0,0,100,0)
	,('Gilt Arrival',@GroupName,@FarmName,0,0,0,0,0,0,0,105,0)
	,('Sow Arrival',@GroupName,@FarmName,0,0,0,0,0,0,0,110,0)
	,('Boar Inventory',@GroupName,@FarmName,0,0,0,0,0,0,0,130,0)

IF @Detailed = 1

Insert into #Summary (EventName
	,GroupName
	,FarmName
	,Sunday
	,Monday 
	,Tuesday
	,Wednesday 
	,Thursday 
	,Friday 
	,Saturday
	,Sort
	,TotalCount) VALUES
	('Wean',@GroupName,@FarmName,0,0,0,0,0,0,0,5,0)
	,('Late Wean',@GroupName,@FarmName,0,0,0,0,0,0,0,8,0)
	,('Returns',@GroupName,@FarmName,0,0,0,0,0,0,0,10,0)
	,('Opportunity',@GroupName,@FarmName,0,0,0,0,0,0,0,15,0)
	,('Gilt',@GroupName,@FarmName,0,0,0,0,0,0,0,20,0)
	,('Sow Litters',@GroupName,@FarmName,0,0,0,0,0,0,0,61,0)
	,('Gilt Litters',@GroupName,@FarmName,0,0,0,0,0,0,0,62,0)
	,('Total Born',@GroupName,@FarmName,0,0,0,0,0,0,0,63,0)
	,('Sow Total Born',@GroupName,@FarmName,0,0,0,0,0,0,0,64,0)
	,('Gilt Total Born',@GroupName,@FarmName,0,0,0,0,0,0,0,65,0)
	,('Sow LiveBorn',@GroupName,@FarmName,0,0,0,0,0,0,0,67,0)
	,('Gilt LiveBorn',@GroupName,@FarmName,0,0,0,0,0,0,0,68,0)
	,('Sow Stillborn',@GroupName,@FarmName,0,0,0,0,0,0,0,72,0)
	,('Gilt Stillborn',@GroupName,@FarmName,0,0,0,0,0,0,0,73,0)
	,('Sow Mummies',@GroupName,@FarmName,0,0,0,0,0,0,0,76,0)
	,('Gilt Mummies',@GroupName,@FarmName,0,0,0,0,0,0,0,77,0)
	,('PD Day 1-3',@GroupName,@FarmName,0,0,0,0,0,0,0,98,0)
	,('PD Day 4+',@GroupName,@FarmName,0,0,0,0,0,0,0,99,0)
	,('Female Death',@GroupName,@FarmName,0,0,0,0,0,0,0,115,0)
	,('Female Euth',@GroupName,@FarmName,0,0,0,0,0,0,0,120,0)
	,('Female Cull',@GroupName,@FarmName,0,0,0,0,0,0,0,125,0);

ELSE

Insert into #Summary (EventName
	,GroupName
	,FarmName
	,Sunday
	,Monday 
	,Tuesday
	,Wednesday 
	,Thursday 
	,Friday 
	,Saturday
	,Sort
	,TotalCount) VALUES
	('Female Removal',@GroupName,@FarmName,0,0,0,0,0,0,0,113,0);

select top 1 @startdate = G.WEEKOFDATE, @enddate = G.WEEKENDDATE FROM dbo.CFT_WEEKDEFINITION G where G.GROUPNAME = @GroupName 

WHILE @enddate >= @startdate
	BEGIN
		Update #Summary
		SET Sunday  = (Case when @DayNbr = 1 then TMP.EventCount else ISNull(Sunday,0) end)
			,Monday = (Case when @DayNbr = 2 then TMP.EventCount else ISNull(Monday,0) end)
			,Tuesday = (Case when @DayNbr = 3 then TMP.EventCount else ISNull(Tuesday,0) end)
			,Wednesday = (Case when @DayNbr = 4 then TMP.EventCount else ISNull(Wednesday,0) end)
			,Thursday = (Case when @DayNbr = 5 then TMP.EventCount else ISNull(Thursday,0) end)
			,Friday = (Case when @DayNbr = 6 then TMP.EventCount else ISNull(Friday,0) end)
			,Saturday = (Case when @DayNbr = 7 then TMP.EventCount else ISNull(Saturday,0) end)
	FROM #Summary SM
	Left Join #Temp TMP on SM.EventName = TMP.EventName
	Where TMP.EventDate = @startdate
	SET @startdate = @startdate + 1;
	SET @DayNbr = @DayNbr +1;
END;


Update #Summary
	SET TotalCount = TMP.TotalCount
FROM #Summary SM
Join (Select TMP.EventName, SUM(TMP.EventCount) as TotalCount From #Temp AS TMP Group by TMP.EventName) TMP on SM.EventName = TMP.EventName
Where SM.EventName not in ('Female Inventory','BOAR Inventory','Pic Day');

Update #Summary
	SET TotalCount = sm.Saturday
FROM #Summary SM
Where SM.EventName in ('Female Inventory','BOAR Inventory');
--select * from #Temp 
Select * from #Summary order by sort

Drop table #Temp
Drop table #Summary


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_REPORT_SOWDATA_WEEKLY_SUMMARY] TO [CorpReports]
    AS [dbo];

