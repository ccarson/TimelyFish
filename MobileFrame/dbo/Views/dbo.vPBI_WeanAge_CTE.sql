


CREATE VIEW [dbo].[vPBI_WeanAge_CTE]
AS

-- ===================================================================
-- Author:	John Maas
-- Create date: 08/29/2017
-- Description:	This view provides valuable data for Wean Events, Lactation Lengths and Wean Ages to match PigChamp calculations.
/*************************
** Change History
**************************
** PR   Date			Author			Description 
** --   --------		-------			------------------------------------
** 1    08/29/2017		John Maas		CREATED
**
*******************************/
-- ===================================================================
--1st CTE for Wean Events
WITH WeanOrder_CTE
	(ANIMALID,
	EVENTTYPEID,
	EVENTDATE,
	PARITYNBR,
	EVENTNBR,
	QTY,
	WeanOrder)
AS (
	select	ae.ANIMALID,
			ae.EVENTTYPEID,
			ae.EVENTDATE,
			ae.PARITYNBR,
			ae.EVENTNBR,
			ae.QTY,
			ROW_NUMBER()
				OVER(PARTITION BY ae.ANIMALID,ae.PARITYNBR 
				ORDER BY ae.EVENTTYPEID,ae.ANIMALID,ae.PARITYNBR,ae.EVENTNBR) AS WeanOrder
	from dbo.CFT_ANIMALEVENTS ae
	inner join dbo.CFT_EVENTTYPE et
		on et.ID=ae.EVENTTYPEID
			and et.DELETED_BY=-1
			and et.EVENTTYPE='Piglet'
			and et.EVENTNAME='Wean'
		where ae.DELETED_BY = -1
		),
--Now the 2nd CTE for Final Wean Dates
FinalWeanDate_CTE	
	(ANIMALID,
	PARITYNBR,
	FinalWeanDate)
AS (
	select	ae.ANIMALID,
			ae.PARITYNBR
			,MAX(ae.EVENTDATE)	as [FinalWeanDate]
	from dbo.CFT_ANIMALEVENTS ae
	inner join dbo.CFT_EVENTTYPE et
		on et.ID=ae.EVENTTYPEID
			and et.DELETED_BY=-1
			and et.EVENTTYPE='Piglet'
			and et.EVENTNAME='Wean'
		where ae.DELETED_BY = -1
	group by ae.ANIMALID,ae.PARITYNBR
	),
--Now the 3rd CTE for Farrow Dates
FarrowDate_CTE
	(ANIMALID,
	PARITYNBR,
	EVENTDATE)
AS (
	select	ae.ANIMALID,
			ae.PARITYNBR,
			ae.EVENTDATE
	from dbo.CFT_ANIMALEVENTS ae
	inner join dbo.CFT_EVENTTYPE et
		on et.ID=ae.EVENTTYPEID
			and et.DELETED_BY=-1
			and et.EVENTNAME='Farrowing'
	left join dbo.CFT_ANIMALTAG at
		on AT.ANIMALID=ae.ANIMALID
			and AT.PRIMARYTAG=1
			and AT.DELETED_BY = -1
		where ae.DELETED_BY = -1)

select	wo1.ANIMALID,
		et.EVENTTYPE,
		et.EVENTNAME,
		wd.GROUPNAME,
		wo1.EVENTDATE							as [WeanDate],
		CONVERT(VARCHAR(10),wo1.EVENTDATE, 101)	as [CharDate],
		left(DATENAME(weekday,wo1.EVENTDATE),3)	as [DayName],
		DATEPART(dw,wo1.EVENTDATE)				as [DayOfWeek],
		wo1.PARITYNBR,
		wo1.WeanOrder,
		f.NAME									as [WeanFarm],
		AT.TAGNBR								as [SowID],
		case
			when wo1.EVENTDATE=fwd.FinalWeanDate
				then 'CompleteWean'
			else 'PartWean'
			end									as [WeanType],
		1										as [TotalWeanCnt],
		case
			when wo1.EVENTDATE=fwd.FinalWeanDate
				then 1
			else 0
			end									as [FinalWeanCnt],
		case
			when wo1.EVENTDATE<>fwd.FinalWeanDate
				then 1
			else 0
			end									as [PartWeanCnt],
		case
			when wo1.WeanOrder>1
				then 1
			else 0
			end									as [NurseWeanCnt],
		case
			when wo1.QTY=0
				then 1
			else 0
			end									as [NoLitterWeanCnt],
		wo1.QTY									as [WeanQTY],
		datediff(d,fd.EVENTDATE,wo1.EVENTDATE)	as [LactationLength],
		case
			when wo1.EVENTDATE=fwd.FinalWeanDate
				then datediff(d,fd.EVENTDATE,wo1.EVENTDATE)
			else 0
			end									as [LactationLengthCompleteWeans],
		case
			when wo1.WeanOrder=1
				then datediff(d,fd.EVENTDATE,wo1.EVENTDATE)
			else datediff(d,wo2.EVENTDATE,fwd.FinalWeanDate)
			end									as [LactationDays],
		case
			when wo1.WeanOrder=1
				then datediff(d,fd.EVENTDATE,wo1.EVENTDATE) * wo1.QTY
			else datediff(d,wo2.EVENTDATE,fwd.FinalWeanDate) * wo1.QTY
			end									as [SumPigletAges]
from	WeanOrder_CTE as wo1
		left join WeanOrder_CTE as wo2
			on wo1.ANIMALID=wo2.ANIMALID
				and wo1.PARITYNBR=wo2.PARITYNBR
				and wo1.WeanOrder=wo2.WeanOrder+1
		left join dbo.CFT_ANIMALTAG at
			on AT.ANIMALID=wo1.ANIMALID
				and AT.PRIMARYTAG=1
				and AT.DELETED_BY = -1
		inner join dbo.CFT_EVENTTYPE et
			on et.ID=wo1.EVENTTYPEID
				and et.DELETED_BY=-1
		left join FinalWeanDate_CTE as fwd
			on fwd.ANIMALID=wo1.ANIMALID
				and fwd.PARITYNBR=wo1.PARITYNBR
		left join FarrowDate_CTE as fd
			on fd.ANIMALID=wo1.ANIMALID
				and fd.PARITYNBR=wo1.PARITYNBR
		left join dbo.CFT_ANIMAL a
			on a.ID=wo1.ANIMALID
				and a.DELETED_BY=-1
		left join dbo.CFT_GENETICS g
			on g.ID=a.GENETICSID
				and g.DELETED_BY=-1
		left join dbo.CFT_FARMANIMAL fa
			on fa.ANIMALID=wo1.ANIMALID
				and fa.DELETED_BY=-1
		left join dbo.CFT_FARM f
			on f.ID=fa.FARMID
				and f.DELETED_BY=-1
		left join dbo.CFT_WEEKDEFINITION wd
			on wo1.EVENTDATE between wd.WEEKOFDATE and wd.WEEKENDDATE
				and wd.DELETED_BY=-1
--where datediff(wk,wd.WEEKENDDATE,getdate())<= @WksBack


