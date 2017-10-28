




-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 12/01/2010
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SOW_BT_FT_INSERT]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_SOW_BT_FT

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_SOW_BT_FT
(	ContactName
	,ContactID
	,Region
	,Service
	,BT
	,Farrow
	,FT
	--,PigFlowDescription
	--,Acct
	--,WeanAgeDays
	--,Qty
	,PicYear
	,PicWeek)

	Select
	
	C.Contactname,
	C.ContactID,
	Case when 
	C.ContactID in (000315,000319,000322,000323,000324,000325,000326,000327,000328,000329,000331,000332,000333,000337,
	000339,000837,000836,000835,004184) then 'MN/CO'
	when C.ContactID in (000340,000342,000344,000345,000347,000349,000336,000338,004183) then 'NE'
	when C.ContactID in (002547,002548,002549,002550,002551,002552,002553,004314,004742) then 'SIA'
	when C.ContactID in (002555,002556,002557,002558,002559,002560,002561,005033) then 'IL'
	when C.ContactID in (002283,000838) then 'M1/M2' 
	when C.ContactID in (000330,000335,002562,002563,007663) then 'MULT' end as 'Region',
	SVC.Service,
	Case when
	C.ContactID in (000838) then 60
	when C.ContactID in (000344) then 68
	when C.ContactID in (000319) then 72
	when C.ContactID in (002553) then 82
	when C.ContactID in (000315) then 110
	when C.ContactID in (000324,000330) then 116
	when C.ContactID in (000323,000326,000328,000331,000322) then 118
	when C.ContactID in (000337,000335) then 119
	when C.ContactID in (000327,000333) then 120
	when C.ContactID in (000325,000329,002562) then 122
	when C.ContactID in (000336) then 123
	when C.ContactID in (002563) then 125
	when C.ContactID in (000836,000835) then 137
	when C.ContactID in (000837) then 140
	when C.ContactID in (002551,002552,002555) then 141
	when C.ContactID in (000347,000349) then 142
	when C.ContactID in (000342,000345) then 143
	when C.ContactID in (002551,002552) then 145
	when C.ContactID in (002560,002561) then 147
	when C.ContactID in (002557) then 149
	when C.ContactID in (000340) then 150
	when C.ContactID in (002556,002558,002559) then 152
	when C.ContactID in (007663) then 170
	when C.ContactID in (004742,002548,002549,002550) then 180
	when C.ContactID in (002283) then 193
	when C.ContactID in (002547) then 207
	when C.ContactID in (004184) then 230
	when C.ContactID in (000332) then 246
	when C.ContactID in (000339) then 252
	when C.ContactID in (004183) then 260
	when C.ContactID in (005033) then 293
	when C.ContactID in (004314) then 300 end as 'BT',
	FRW.Farrow,
	Case when
	C.ContactID in (002547) then 0
	when C.ContactID in (000838) then 51
	when C.ContactID in (000319) then 63
	when C.ContactID in (000344) then 60
	when C.ContactID in (002553) then 73
	when C.ContactID in (000315) then 100
	when C.ContactID in (000323,000324,000325,000326,000327,000328,000329,000331,000333,000336,000337,000322) then 106
	when C.ContactID in (002562,002563) then 110
	when C.ContactID in (000330,000335) then 106
	when C.ContactID in (000837,000836,000835) then 123
	when C.ContactID in (002551,002552) then 126
	when C.ContactID in (002555,000345) then 127
	when C.ContactID in (002556,002557,002558,002559,002560,002561) then 134
	when C.ContactID in (007663) then 154
	when C.ContactID in (000340,000342,000347,000349) then 128
	when C.ContactID in (002283) then 170
	when C.ContactID in (004184) then 201
	when C.ContactID in (004742,002548,002549,002550) then 207
	when C.ContactID in (000332) then 221
	when C.ContactID in (000339) then 224
	when C.ContactID in (004183) then 232
	when C.ContactID in (005033) then 255
	when C.ContactID in (004314) then 265 end as 'FT',
	--WA.PigFlowDescription,
	--WA.Acct,
	--WA.WeanAgeDays,
	--WA.Qty,
	WD.PicYear,
	WD.PicWeek

	from earth.sowdata.dbo.farmsetup FS	-- removed saturn_reference 20130905 - part of the saturn_retirement effort

	left join [$(SolomonApp)].dbo.cftcontact C
	on FS.ContactId = C.Contactid

	cross join [$(SolomonApp)].dbo.cftWeekDefinition WD
	
	--Weekly Services--

	left join (

	Select 
	C.Contactid,
	Count(ME.Sowid) Service,
	WD.PicYear,
	WD.PicWeek
	from earth.sowdata.dbo.SowMatingEvent ME	-- removed saturn_reference 20130905 - part of the saturn_retirement effort
	left join earth.sowdata.dbo.farmsetup FS	-- removed saturn_reference 20130905 - part of the saturn_retirement effort
	on ME.farmid = FS.farmid
	left join [$(SolomonApp)].dbo.cftcontact C
	on FS.contactid = C.contactid
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on ME.weekofdate = WD.weekofdate
	where WD.PicYear>='2009'
	and ME.Matingnbr='1'
	Group by
	C.Contactid,
	WD.PicYear,
	WD.PicWeek) SVC
	on C.Contactid = SVC.Contactid
	and WD.PicYear = SVC.PicYear
	and WD.PicWeek = SVC.PicWeek
	
	--Weekly Farrows--

	left join
	(

	Select 
	C.Contactid,
	Count(FE.Eventid) Farrow,	
	WD.PicYear,
	WD.PicWeek
	from earth.sowdata.dbo.SowFarrowEvent FE	-- removed saturn_reference 20130905 - part of the saturn_retirement effort
	left join earth.sowdata.dbo.farmsetup FS	-- removed saturn_reference 20130905 - part of the saturn_retirement effort
	on FE.farmid = FS.farmid
	left join [$(SolomonApp)].dbo.cftcontact C
	on FS.contactid = C.contactid
--	left join Saturn.earth.sowdata.dbo.WeekDefinition WD	-- removed saturn_reference 20130905 - part of the saturn_retirement effort
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on FE.weekofdate = WD.weekofdate
	Where WD.PicYear>='2009'
	Group by
	C.Contactid,
	WD.PicYear,
	WD.PicWeek) FRW
	on C.Contactid = FRW.Contactid
	and WD.PicYear = FRW.PicYear
	and WD.PicWeek = FRW.PicWeek
	
	--Wean Age--
	
	--left join 
	--(
	
	--Select
	--rtrim(C.ContactName) as 'ContactName',
	--pff.ContactID,
	--pff.PigFlowID,
	--pf.PigFlowDescription,
	--WA.WeekOfDate,
	----pf.PigFlowFromDate,
	----pf.PigFlowToDate,
	--WA.Acct,
	--WA.WeanAgeDays,
	--WA.Qty

	--From (

	--Select 
	--a.FarmID,
	--fs.ContactID, 
	--a.WeekOfDate,
	--Acct='WeanAge' + RTrim(a.weanagedays),
	--RTrim(a.WeanAgeDays2) as 'WeanAgeDays',
	--Qty = Sum(a.NatQty)

	--From (

	--Select 
	--we.farmid, 
	--we.SowID, 
	--we.SowParity, 
	--we.SowGenetics, 
	--we.WeekOfDate, 
	--WeanQty=we.Qty, 
	--FarrowQty=fe.QtyBornAlive, 
	--NatQty=CASE WHEN fe.QtyBornAlive-we.Qty < 0 THEN fe.QtyBornAlive ELSE we.Qty END,
	--WeanAgeDays=CASE WHEN DateDiff(day,fe.EventDate,we.EventDate) < 15 THEN '<=14'
	--WHEN DateDiff(day,fe.EventDate,we.EventDate) > 34 THEN '>=35'
	--ELSE RTrim(convert(varchar(2),DateDiff(day,fe.EventDate,we.EventDate))) END,
	--WeanAgeDays2=RTrim(convert(varchar(2),DateDiff(day,fe.EventDate,we.EventDate)))
	--FROM Saturn.earth.sowdata.dbo.SowWeanEvent we
	--LEFT JOIN Saturn.earth.sowdata.dbo.SowNurseEvent ne -- JOIN TO FILTER OUT SOWS THAT HAD A NURSE ON EVENT (OR EVEN NURSE OFF, but we do not use this currently)
	--ON we.FarmID = ne.FarmID
	--AND we.SowID = ne.SowID
	--AND we.SowParity = ne.SowParity
	--AND ne.SowID Is Null
	--JOIN Saturn.earth.sowdata.dbo.SowFarrowEvent fe  -- JOIN FOR GETTING FARROW DATE
	--ON we.FarmID = fe.FarmID
	--AND we.SowID = fe.SowID
	--AND we.SowParity = fe.SowParity
	--AND we.EventDate >= fe.EventDate
	--JOIN (

	--Select 
	--FarmID, 
	--SowID, 
	--SowParity, 
	--min(SortCode) as SortCode
	--FROM Saturn.earth.sowdata.dbo.SowWeanEvent we
	--WHERE (we.EventType = 'WEAN' OR (we.EventType = 'PART WEAN' and we.Qty < 3))
	--AND we.Qty > 0 
	--Group by 
	--FarmID, 
	--SowID, 
	--SowParity) fw 
	--on we.FarmID=fw.FarmID 
	--and we.SowID=fw.SowID 
	--and we.SowParity=fw.SowParity 
	--and we.SortCode=fw.SortCode
	--WHERE (we.EventType = 'WEAN' OR (we.EventType = 'PART WEAN' and we.Qty < 3))
				
	--AND we.Qty > 0  -- NURSE OFF's are recorded as a WEAN of 0 qty

	--) a
	
	--left join Saturn.earth.sowdata.dbo.FarmSetup fs
	--on a.FarmID = fs.FarmID 
	
	--Group by 
	
	--a.FarmID, 
	--fs.ContactID,
	--a.WeekOfDate, 
	--a.WeanAgeDays,
	--a.WeanAgeDays2) WA
	
	--left join [$(SolomonApp)].dbo.cftContact C
	--on WA.ContactID = C.ContactID
	
	--left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_FARM pff
	--on WA.ContactID = pff.ContactID
	
	--left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf
	--on pff.PigFlowID = pf.PigFlowID
	
	--Where WA.WeekOfDate >= '1/1/2009'
	--and WA.WeekOfDate between ISNULL(pf.PigFlowFromDate,'1/1/3000') and ISNULL(pf.PigFlowToDate,'1/1/3000')
	--and pf.PigFlowID <> 0) WA
	--on C.ContactID = WA.ContactID
	--and WD.WeekOfDate = WA.WeekOfDate

	Where FS.Status = 'A'
	and WD.PicYear >= '2009'

	Order by
	C.Contactname,
	WD.PicYear,
	WD.PicWeek
	
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_BT_FT_INSERT] TO [db_sp_exec]
    AS [dbo];

