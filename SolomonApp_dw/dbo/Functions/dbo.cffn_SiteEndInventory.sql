
-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 2/29/2012
-- Description:	Site Weekly Inventory
-- ===================================================================
	CREATE FUNCTION dbo.cffn_SiteEndInventory
(
 @SiteID varchar(10)
,@WeekEndDate smalldatetime
)

RETURNS @tblSiteEndInventory TABLE
(
	--Columns returned by the function
	SiteID char(10),
	WeekEndDate smalldatetime,
	EndInventory numeric,
	DaysToFill numeric 
)

AS
--Returns the PigGroupID, Source Site ID, and Sow Source Percent for the specifiec PigGroup
BEGIN

BEGIN

DECLARE @InventoryTable table
(     SiteID char(10)
,	  WeekEndDate smalldatetime
,	  EndInventory int)

INSERT INTO @InventoryTable (SiteID, WeekEndDate, EndInventory)

	Select 
	right(rtrim(pg.ProjectID),4) as 'SiteID', 
	dw.WeekEndDate,
	SUM(t.Qty * t.InvEffect) as 'EndInventory'
	From [$(SolomonApp)].dbo.cftPigGroup pg
	inner join [$(SolomonApp)].dbo.cftPGInvTran t 
	on pg.PigGroupID = t.PigGroupID
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw
	on t.TranDate = dw.DayDate
	Where 
	t.Reversal !=1 
	and right(rtrim(pg.ProjectID),4) = RTRIM(@SiteID)
	Group by 
	right(rtrim(pg.ProjectID),4),
	dw.WeekEndDate
	Order by
	right(rtrim(pg.ProjectID),4), 
	dw.WeekEndDate

DECLARE @EndInventory table
(     SiteID char(10)
,     WeekEndDate smalldatetime
,     EndInventory char(10)
,     DaysToFill numeric
,	  LoopNumber numeric)

INSERT INTO @EndInventory (SiteID, WeekEndDate, EndInventory, DaysToFill, LoopNumber)

	Select 
	IT.SiteID,
	IT.WeekEndDate,
	IT.EndInventory,
	0,
	1
	
	from @InventoryTable IT
	
	Where IT.WeekEndDate = (Select MIN(WeekEndDate) from @InventoryTable)

WHILE (1=1)
BEGIN

INSERT INTO @EndInventory (SiteID, WeekEndDate, EndInventory, DaysToFill, LoopNumber)

	Select 
	EI.SiteID,
	DateAdd(day,7,EI.WeekEndDate),
	SUM(EI.EndInventory + Case when IT.EndInventory is null then 0 else IT.EndInventory end),
	Case when SUM(EI.EndInventory + Case when IT.EndInventory is null then 0 else IT.EndInventory end) = 0
	then 0 else CAST(DateAdd(day,7,EI.WeekEndDate) - FD.WeekEndDate as int) end,
	MAX(EI.LoopNumber) + 1
	
	from (Select EI.SiteID, EI.WeekEndDate, EI.EndInventory, EI.LoopNumber from @EndInventory EI
	Where EI.LoopNumber = (Select MAX(LoopNumber) from @EndInventory)) EI
	
	left join @InventoryTable IT
	on DateAdd(day,7,EI.WeekEndDate) = IT.WeekEndDate
	
	left join (Select SiteID, WeekEndDate from @EndInventory 
	Where LoopNumber = (
	Select Top 1 LoopNumber from @EndInventory where EndInventory = 0 order by WeekEndDate desc)) FD
	on EI.SiteID = FD.SiteID 
	
	Group by
	EI.SiteID,
	DateAdd(day,7,EI.WeekEndDate),
	FD.WeekEndDate
	
 IF 
 (Select Max(WeekEndDate) from @EndInventory) = @WeekEndDate
 
 --(Select Max(LoopNumber) from @EndInventory) = 386

            BREAK
      ELSE
            CONTINUE
            
END

INSERT INTO @tblSiteEndInventory (SiteID, WeekEndDate, EndInventory, DaysToFill)

	Select SiteID, WeekEndDate, EndInventory, DaysToFill
	from @EndInventory

	END;
	RETURN;
END
