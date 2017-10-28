





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
CREATE PROCEDURE [dbo].[CFP_FB_DailyFarrow] 
@GroupName nvarchar(4),
@FarmName nvarchar(30)

AS

create table #Dailytemp
(
	FarmName nvarchar(30),
	SowID [nvarchar](12),
    EventWeek [nvarchar](4), 
	EventDate Datetime,
	BornAlive int,
	Stillborn int,
	Mummy int,
	AnimalType  nvarchar (4),
)

Insert into #Dailytemp 

select Distinct  
		Cast(FARM.Name as nvarchar(30)) as 'FarmName' 
		,CAST(ATP.[TAGNBR] as nvarchar(12)) as SowID
		,CAST(WD.GROUPNAME as nvarchar(4)) as 'EventWeek'
		,AE.[EVENTDATE] as 'EventDate'
		,AE.BORNALIVE	as 'BornAlive'
		,AE.STILLBORN	as 'Stillborn'
		,AE.MUMMY		as 'Mummies'
		,Case When AE.PARITYNBR > 1 then 'Sow' Else 'Gilt' End as 'AnimalType'

FROM dbo.CFT_ANIMALEVENTS AE 
Join [dbo].[CFT_EVENTTYPE] as ET on AE.[EVENTTYPEID] = ET.ID AND ET.[EVENTNAME] like 'Farrowing'
join dbo.CFT_FARMANIMAL fa on AE.ANIMALID=FA.ANIMALID
join dbo.CFT_FARM FARM on farm.ID=fa.FARMID
Join [dbo].[CFT_WEEKDEFINITION] WD on AE.EVENTDATE Between WD.WEEKOFDATE and WD.WEEKENDDATE
CROSS APPLY (Select Top 1 [TAGNBR] From [MobileFrame].[dbo].[CFT_ANIMALTAG] AS ATP WITH (NOLOCK) Where
						 AE.ANIMALID  = ATP.[ANIMALID] AND ATP.[PRIMARYTAG] = 1 AND ATP.[ISCURRENT] = 1) ATP
where wd.GROUPNAME = @GroupName
and farm.NAME = @FarmName
and AE.DELETED_BY = -1
and FA.DELETED_BY = -1
--Group by FARM.NAME,WD.GROUPNAME, AE.EVENTDATE

 
Select * from #Dailytemp order by SowID


Drop table #Dailytemp 


