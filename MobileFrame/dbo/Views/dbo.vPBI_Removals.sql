


CREATE VIEW [dbo].[vPBI_Removals]
AS

-- ===================================================================
-- Author:	John Maas
-- Create date: 08/09/2017
-- Description:	This view provides valuable data for Removal Events
/*************************
** Change History
**************************
** PR   Date			Author			Description 
** --   --------		-------			------------------------------------
** 1    08/09/2017		John Maas		CREATED
** 2	08/28/2017		John Maas		Modified Removal Reasons, added DeathCnt and CullCnt, removed WksBack
**
*******************************/
-- ===================================================================

select	et.EVENTNAME							as [RemovalType],
		re.REMOVALREASONID,
		etr.EVENTTYPE							as [RemovalDecision],
		etr.EVENTNAME							as [RemovalReason],
		AT.TAGNBR								as [SowID],
		re.GROUPNAME							as [BreedWeek],
		f.NAME									as [RemovalFarm],
		re.EVENTDATE							as [RemovalDate],
		wd.GROUPNAME							as [RemovalWeek],
		g.NAME									as [SowGenetics],
		re.PARITYNBR,
		1										as [RemovalCnt],
		case
			when et.EVENTNAME in ('Death','Euth')
				then 1
			else 0
		end										as [DeathCnt],
		case
			when et.EVENTNAME in ('Cull')
				then 1
			else 0
		end										as [CullCnt],
		CONVERT(VARCHAR(10),re.EVENTDATE, 101)	as [CharDate],
		left(DATENAME(weekday,re.EVENTDATE),3)	as [DayName],
		DATEPART(dw,re.EVENTDATE)				as [DayOfWeek]
from	dbo.CFT_ANIMALEVENTS re
		inner join	dbo.CFT_EVENTTYPE et 
			on et.ID=re.EVENTTYPEID 
				and et.DELETED_BY=-1 
				and et.EVENTTYPE='Removal' 
				and re.DELETED_BY = -1
		left join dbo.CFT_ANIMALTAG at 
			on AT.ANIMALID=re.ANIMALID 
				and AT.PRIMARYTAG=1 
				and AT.DELETED_BY = -1
		left join dbo.CFT_ANIMAL a 
			on a.ID=re.ANIMALID 
				and a.DELETED_BY=-1
		left join dbo.CFT_GENETICS g 
			on g.ID=a.GENETICSID 
				and g.DELETED_BY=-1
		left join dbo.CFT_FARMANIMAL fa 
			on fa.ANIMALID=re.ANIMALID 
				and fa.DELETED_BY=-1
		inner join dbo.CFT_FARM f 
			on f.ID=fa.FARMID 
				and f.DELETED_BY=-1
		left join dbo.CFT_EVENTTYPE etr 
			on etr.REASONID=re.REMOVALREASONID 
				and etr.DELETED_BY=-1
				and etr.EVENTTYPE like 'RR-%'
		left join dbo.CFT_WEEKDEFINITION wd 
			on re.EVENTDATE between wd.WEEKOFDATE and wd.WEEKENDDATE
--where datediff(wk,wd.WEEKENDDATE,getdate())<= @WksBack




