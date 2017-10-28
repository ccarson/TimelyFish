
/****** Object:  View dbo.cfv_PigGroupSummary    Script Date: 12/20/2004 3:12:36 PM ******/

/****** Object:  View dbo.cfv_PigGroupSummary    Script Date: 12/15/2004 9:26:56 AM ******/
/****** Sue Matter:  Used on CF663 Active Site Report    Script Date: 11/19/2004 2:10:22 PM ******/

CREATE      VIEW cfv_PigGroupSummary_All
AS
SELECT    gv.Company, gv.PhaseDesc, gv.FacilityType, gv.Description As Status, gv.GroupID, gv.GroupDesc, gv.Gender, dbo.PGGetRoom(gv.GroupID) AS RoomNbr, gv.StartDate, gv.PrePig, gv.DaysIn, 
	  gv.StartWgt, gv.StartQty, gv.CurrentInv,
	  gv.Mortality, gv.FeedDays, dbo.PGGetSource(gv.GroupID) AS Source, gv.FeedIn, gv.LastFeed, gv.LastRation,
	  CONVERT(CHAR(10),DateAdd(day, td.TopDays, gv.StartDate),101) As TopDate, CONVERT(CHAR(10),DateAdd(day, td.CloseDays, gv.StartDate),101) As CloseDate, gv.NoSold, gv.AvgSaleWgt, gv.SiteContactID, gv.ContactName
FROM      cfv_PigGroupSummary_BALL gv
LEFT JOIN cftPGTopClose td ON gv.Gender=td.GenderTypeID AND CONVERT(NUMERIC(2,0),DatePart(month, DateAdd(day, 125, gv.StartDate)))=td.BegStDate AND gv.StartWgt>=td.StartWgt AND gv.StartWgt<=td.EndWgt


