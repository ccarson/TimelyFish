

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 1/13/2011
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SOW_FEED_CONSUMPTION_INSERT_remove]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_SOW_FEED_CONSUMPTION

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_SOW_FEED_CONSUMPTION
(	ContactID
	,InvtIDDel
	,BegInv
	,QtyDel
	,EndInv
	,FeedConsumed
	,PicYear_Week)

Select 
	
	DRS.ContactID,
	DRS.InvtIdDel,
	Case when BI.BegInv is null then 0 else BI.BegInv end as BegInv,
	Case when QtyDel.QtyDel is null then 0 else QtyDel.QtyDel end as QtyDel,
	Case when EI.EndInv is null then 0 else EI.EndInv end as EndInv,
	Sum(Case when BI.BegInv is null then 0 else BI.BegInv end + 
	Case when QtyDel.QtyDel is null then 0 else QtyDel.QtyDel end) - 
	Case when EI.EndInv is null then 0 else EI.EndInv end as FeedConsumed,
	DRS.PicYear_Week

	From (Select Distinct 
	SGP.ContactID, 
	InvtID.InvtidDel,
	InvtID.PicYear_Week
	from  dbo.cft_SOW_SOWDAYS_GOODPIGS SGP
	
	left join (Select Distinct 
	left(rtrim(FO.Invtiddel),4) as 'Invtiddel',
	WI.WeekOfDate,
	WI.PicYear_Week 
	from [$(SolomonApp)].dbo.cftFeedOrder FO 
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WI
	on FO.DateDel = WI.DayDate  
	Where left(rtrim(FO.Invtiddel),4) in ('021M','031M')) InvtID
	on SGP.WeekOfDate = InvtID.WeekOfDate) DRS
	
	left join (Select 
	
	QtyDel.ContactID,
	QtyDel.Invtiddel,
	Case When QtyDel.Invtiddel like '%021%' then Sum(QtyDel.Qtydel)
	When LacQty.LactFeed is null then Sum(QtyDel.QtyDel)
	--When LacQty.LactFeed > Sum(QtyDel.QtyDel) then Sum(QtyDel.QtyDel)
	else Sum(QtyDel.QtyDel)-LacQty.LactFeed end as 'Qtydel',
	QtyDel.PicYear_Week
	
	From (Select 
	
	FeedOrd.ContactID,
	left(rtrim(FeedOrd.Invtiddel),4) as 'Invtiddel',
	sum(FeedOrd.Qtydel) Qtydel,
	WeekInfo.PicYear_Week
	
	From [$(SolomonApp)].dbo.cftFeedOrder FeedOrd
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WeekInfo
	on FeedOrd.DateDel = WeekInfo.DayDate

	Where left(rtrim(FeedOrd.Invtiddel),4) in ('021M','031M') 
	and FeedOrd.Status = 'C'
	and FeedOrd.Reversal = '0'
	
	Group by
	FeedOrd.ContactID,
	FeedOrd.Invtiddel,
	WeekInfo.PicYear_Week) QtyDel
	
	left join (Select
	
	IsoDays2.SiteContactID,
	IsoDays2.PicYear_Week,
	Sum(IsoDays2.LactFeed) LactFeed
	
	From (Select
	
	IsoDays.SiteContactID,
	IsoDays.PigGroupID,
	IsoDays.ActStartDate,
	IsoDays.ActCloseDate,
	IsoDays.WeekEndDate,
	IsoDays.PicYear_Week,
	Case When IsoDays.SiteContactID = 000329 then Sum(IsoDays.Qty) * Sum(IsoDays.Isodays) * 8 * 0.5
	else Sum(IsoDays.Qty) * Sum(IsoDays.Isodays) * 8 end as LactFeed
	
	From (Select 
	
	PigGroup.SiteContactID,
	PigGroup.PigGroupID,
	sum(PGTran.Qty) Qty,
	PigGroup.Actstartdate,
	PigGroup.Actclosedate,
	WeekDef.Weekenddate,
	right(WeekDef.PICYear,2) + 'WK' + replicate('0',2-len(rtrim(convert(char(2),rtrim(WeekDef.PICWeek)))))
	+ rtrim(convert(char(2),rtrim(WeekDef.PICWeek))) PicYear_Week,
	
	Case When PigGroup.ActCloseDate = '01/01/1900' and PigGroup.ActStartDate = '01/01/1900' then 0
	
	When PigGroup.ActCloseDate = '01/01/1900' and PigGroup.ActStartDate <= WeekDef.WeekEndDate and PigGroup.ActStartDate >= WeekDef.WeekOfDate 
	then DateDiff(Day,PigGroup.ActStartDate,DateAdd(DD,1,WeekDef.WeekEndDate)) 
	
	when PigGroup.ActCloseDate = '01/01/1900' and PigGroup.ActStartDate <= WeekDef.WeekEndDate and PigGroup.ActStartDate <= WeekDef.WeekOfDate
	then DateDiff(Day,WeekDef.WeekOfDate,DateAdd(DD,1,WeekDef.WeekEndDate)) 
	
	when PigGroup.ActCloseDate >= WeekDef.WeekEndDate and PigGroup.ActStartDate <= WeekDef.WeekEndDate and PigGroup.ActStartDate >= WeekDef.WeekOfDate
	then DateDiff(Day,PigGroup.ActStartDate,DateAdd(DD,1,WeekDef.Weekenddate)) 
	
	when PigGroup.ActCloseDate >= WeekDef.WeekEndDate and PigGroup.ActStartDate <= WeekDef.WeekEndDate and PigGroup.ActStartDate <= WeekDef.WeekOfDate
	then DateDiff(Day,WeekDef.WeekOfDate,DateAdd(DD,1,WeekDef.Weekenddate)) 
	
	when PigGroup.ActCloseDate <= WeekDef.WeekEndDate and PigGroup.ActStartDate <= WeekDef.WeekEndDate and PigGroup.ActStartDate >= WeekDef.WeekOfDate
	then DateDiff(Day,PigGroup.ActStartDate,DateAdd(DD,1,PigGroup.Actclosedate)) 
	
	when PigGroup.ActCloseDate <= WeekDef.WeekEndDate and PigGroup.ActCloseDate >= WeekDef.WeekOfDate and PigGroup.ActStartDate <= WeekDef.WeekEndDate 
	and PigGroup.ActStartDate <= WeekDef.WeekOfDate then DateDiff(Day,WeekDef.WeekOfDate,DateAdd(DD,1,PigGroup.ActCloseDate)) else 0 end Isodays
	
	From [$(SolomonApp)].dbo.cftPigGroup PigGroup
	
	left join [$(SolomonApp)].dbo.cftPGInvTran PGTran
	on PigGroup.Piggroupid=PGTran.Piggroupid
	
	cross join [$(SolomonApp)].dbo.cftWeekDefinition WeekDef
	
	Where PGTran.Trantypeid = 'TI'
	and PGTran.Reversal = '0'
	and PigGroup.SiteContactID in (000322,000323,000324,000325,000326,000327,000328,000329,000331,000332,000333,000339,000330,000335)
	
	Group by
	PigGroup.SiteContactID,
	PigGroup.Piggroupid,
	PigGroup.Actstartdate,
	PigGroup.Actclosedate,
	WeekDef.Weekofdate,
	WeekDef.Weekenddate,
	right(WeekDef.PICYear,2) + 'WK' + replicate('0',2-len(rtrim(convert(char(2),rtrim(WeekDef.PICWeek)))))
	+ rtrim(convert(char(2),rtrim(WeekDef.PICWeek)))) IsoDays
	
	Group by
	IsoDays.SiteContactID,
	IsoDays.PigGroupID,
	IsoDays.ActStartDate,
	IsoDays.ActCloseDate,
	IsoDays.WeekEndDate,
	IsoDays.PicYear_Week) IsoDays2
	
	Group by
	IsoDays2.SiteContactID,
	IsoDays2.PicYear_Week) LacQty
	on QtyDel.ContactID = LacQty.SiteContactID
	and QtyDel.PicYear_Week = LacQty.PicYear_Week
	
	Group by
	QtyDel.ContactID,
	QtyDel.Invtiddel,
	LacQty.LactFeed,
	QtyDel.PicYear_Week) QtyDel
	on DRS.ContactID = QtyDel.ContactID
	and DRS.InvtIDDel = QtyDel.InvtIDDel
	and DRS.PicYear_Week = QtyDel.PicYear_Week
	
	left join (Select 
	
	DRS.Contactname1 as ContactName,
	DRS.ContactID,
	left(rtrim(Barn.Dfltration),4) as Dfltration,
	DateAdd(DD,7,(Cast(Max(Binr.BinReadingDate) as datetime))) as BinReadDate2,
	WeekInfo.PICYear_Week,
	Sum(Binr.Tons*2000) as BegInv
	
	from [$(SolomonApp)].dbo.cftBin Bin
	
	left join  dbo.cfv_SOW_DIVISION_REGION_SITE DRS
	on Bin.ContactID = DRS.ContactID
	
	left join [$(SolomonApp)].dbo.cftBarn Barn
	on Bin.ContactID = Barn.ContactID
	and Bin.BarnNbr = Barn.BarnNbr 
	
	left join [$(SolomonApp)].dbo.cftBinReading Binr
	on Binr.Sitecontactid = Bin.Contactid
	and Binr.Binnbr = Bin.Binnbr
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WeekInfo
	on DateAdd(DD,7,(Cast(Binr.BinReadingDate as datetime))) = WeekInfo.DayDate
	
	Where Barn.FacilityTypeID = '001'
	and (left(rtrim(Barn.dfltration),4) in ('021M','031M')) 
	
	Group by
	DRS.Contactname1,
	DRS.ContactID,
	left(rtrim(Barn.Dfltration),4),
	WeekInfo.PICYear_Week) BI
	on DRS.ContactID = BI.ContactID
	and DRS.InvtIDDel = BI.Dfltration
	and DRS.PicYear_Week = BI.PicYear_Week
	
	left join (Select 
	
	DRS.Contactname1 as ContactName,
	DRS.ContactID,
	left(rtrim(Barn.Dfltration),4) as Dfltration,
	Max(Binr.BinReadingDate) as BinReadDate,
	WeekInfo.PICYear_Week,
	Sum(Binr.Tons*2000) as EndInv
	
	from [$(SolomonApp)].dbo.cftBin Bin
	
	left join  dbo.cfv_SOW_DIVISION_REGION_SITE DRS
	on Bin.ContactID = DRS.ContactID
	
	left join [$(SolomonApp)].dbo.cftBarn Barn
	on Bin.ContactID = Barn.ContactID
	and Bin.BarnNbr = Barn.BarnNbr 
	
	left join [$(SolomonApp)].dbo.cftBinReading Binr
	on Binr.Sitecontactid = Bin.Contactid
	and Binr.Binnbr = Bin.Binnbr
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WeekInfo
	on Binr.BinReadingDate = WeekInfo.DayDate
	
	Where Barn.FacilityTypeID = '001'
	and (left(rtrim(Barn.dfltration),4) in ('021M','031M')) 
	
	Group by
	DRS.Contactname1,
	DRS.ContactID,
	left(rtrim(Barn.Dfltration),4),
	WeekInfo.PICYear_Week) EI
	on DRS.ContactID = EI.ContactID 
	and DRS.InvtIDDel = EI.Dfltration
	and DRS.PicYear_Week = EI.PicYear_Week
	
	Where Case when BI.BegInv is null then 0 else BI.BegInv end +
	Case when QtyDel.QtyDel is null then 0 else QtyDel.QtyDel end +
	Case when EI.EndInv is null then 0 else EI.EndInv end > 0
	
	Group by
	DRS.ContactID,
	DRS.InvtIdDel,
	BI.BegInv,
	QtyDel.QtyDel,
	EI.EndInv,
	DRS.PicYear_Week
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_FEED_CONSUMPTION_INSERT_remove] TO [db_sp_exec]
    AS [dbo];

