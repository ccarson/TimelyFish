






-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame Farm Board Sow Data Daily Breed Summary
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
CREATE PROCEDURE [dbo].[CFP_FB_DailyBreedSummary] 
@GroupName nvarchar(4),
@FarmName nvarchar(30)

AS

create table #BreedTemp
(	
	BreedGroup [nvarchar](4), 
	FarmName nvarchar(30),
	EventDate Datetime,
    BreedType nvarchar (20),
	EventCount int
)

Insert into #BreedTemp 

select ME.GROUPNAME as 'BreedGroup'
		,FARM.NAME as 'Farm'
		,ME.[EVENTDATE] as 'EventDate'
		,PS.NAME as 'BreedType'
		,Count(ME.ID) as 'EventCount'
	


FROM dbo.CFT_ANIMALEVENTS ME 
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Mating'
Join [MobileFrame].[dbo].[CFT_STATUS] PS on ME.PREVSTATUS = PS.STATUSID
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID

Where ME.MATINGNBR=1
AND ME.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1

Group by ME.GROUPNAME,FARM.NAME ,ME.[EVENTDATE], PS.NAME
 
 union

 select ME.GROUPNAME as 'BreedGroup'
		,FARM.NAME as 'Farm'
		,ME.[EVENTDATE] as 'EventDate'
		,'2nd Mating Gilts' as 'BreedType'
		,Count(ME.ID) as 'EventCount'
		


FROM dbo.CFT_ANIMALEVENTS ME 
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Mating'
Join [MobileFrame].[dbo].[CFT_STATUS] PS on ME.PREVSTATUS = PS.STATUSID
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID


Where ME.MATINGNBR > 1 and PS.Name like 'Gilt'
AND ME.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by ME.GROUPNAME,FARM.NAME ,ME.[EVENTDATE]

 union

 select ME.GROUPNAME as 'BreedGroup'
		,FARM.NAME as 'Farm'
		,ME.[EVENTDATE] as 'EventDate'
		,'2nd Mating Sow' as 'BreedType'
		,Count(ME.ID) as 'EventCount'
		


FROM dbo.CFT_ANIMALEVENTS ME 
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Mating'
Join [MobileFrame].[dbo].[CFT_STATUS] PS on ME.PREVSTATUS = PS.STATUSID
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID


Where ME.MATINGNBR > 1 and PS.Name Not like 'Gilt'
AND ME.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by ME.GROUPNAME,FARM.NAME ,ME.[EVENTDATE]

 union

 select ME.GROUPNAME as 'BreedGroup'
		,FARM.NAME as 'Farm'
		,ME.[EVENTDATE] as 'EventDate'
		,'Total Gilts Breed' as 'BreedType'
		,Count(ME.ID) as 'EventCount'
		


FROM dbo.CFT_ANIMALEVENTS ME 
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Mating'
Join [MobileFrame].[dbo].[CFT_STATUS] PS on ME.PREVSTATUS = PS.STATUSID
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID


Where ME.MATINGNBR=1 and PS.Name like 'Gilt'
AND ME.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by ME.GROUPNAME,FARM.NAME ,ME.[EVENTDATE]

 union

 select ME.GROUPNAME as 'BreedGroup'
		,FARM.NAME as 'Farm'
		,ME.[EVENTDATE] as 'EventDate'
		,'Total Sows Breed' as 'BreedType'
		,Count(ME.ID) as 'EventCount'
	


FROM dbo.CFT_ANIMALEVENTS ME 
Join [dbo].[CFT_EVENTTYPE] as ET on ME.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Mating'
Join [MobileFrame].[dbo].[CFT_STATUS] PS on ME.PREVSTATUS = PS.STATUSID
join dbo.CFT_FARMANIMAL fa on ME.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID

Where ME.MATINGNBR = 1 and PS.Name Not like 'Gilt'
AND ME.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and ME.DELETED_BY = -1
and FA.DELETED_BY = -1
Group by ME.GROUPNAME,FARM.NAME ,ME.[EVENTDATE]

select BreedGroup, 
	FarmName,
	EventDate,
    BreedType,
	EventCount
From #BreedTemp

Order by EventDate

Drop table #Breedtemp


