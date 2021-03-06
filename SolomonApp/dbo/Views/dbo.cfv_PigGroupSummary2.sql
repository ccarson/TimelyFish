﻿CREATE   VIEW cfv_PigGroupSummary2
AS
SELECT    gv.Company, gv.PhaseDesc, gv.FacilityType, gv.Description As Status, gv.GroupID, gv.GroupDesc, gv.Gender, dbo.PGGetRoom(gv.GroupID) AS RoomNbr, gv.StartDate, gv.PrePig, gv.DaysIn, 
	  gv.StartWgt, gv.StartQty, gv.CurrentInv,
	  gv.Mortality, gv.FeedDays, dbo.PGGetSource(gv.GroupID) AS Source, gv.FeedIn, gv.LastFeed, gv.LastRation,
	  CONVERT(CHAR(10),DateAdd(day, -21, DateAdd(day,((270-gv.StartWgt)/td.ADG),gv.StartDate)),101) As TopDate, 
	  CONVERT(CHAR(10),DateAdd(day,((270-gv.StartWgt)/td.ADG),gv.StartDate),101) As CloseDate, gv.NoSold, gv.AvgSaleWgt, gv.SiteContactID, gv.ContactName
--	  CONVERT(CHAR(10),DateAdd(day, -21, mk.ProjCloseOut),101) As TopDate, 
--	  CONVERT(CHAR(10),mk.ProjCloseOut,101) As CloseDate, gv.NoSold, gv.AvgSaleWgt, gv.SiteContactID, gv.ContactName
FROM      cfv_PigGroupSummaryBase gv
LEFT JOIN cftPGTopClose2 td ON gv.Gender=td.GenderTypeID AND CONVERT(NUMERIC(2,0),DatePart(month, gv.StartDate))=td.BegStDate 
--LEFT JOIN cftPigPreMkt mk ON gv.GroupID=mk.PigGroupID

