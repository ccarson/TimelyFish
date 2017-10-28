
/****** Object:  View dbo.cfv_PigGroupSummary    Script Date: 11/7/2005 5:00:19 PM ******/

/****** Object:  View dbo.cfv_PigGroupSummary    Script Date: 10/4/2005 4:09:56 PM ******/

/****** Object:  View dbo.cfv_PigGroupSummary    Script Date: 9/26/2005 2:23:44 PM ******/
CREATE       VIEW cfv_PigGroupSummary
AS
SELECT    gv.Company, gv.PhaseDesc, gv.FacilityType, gv.Description As Status, gv.GroupID, gv.GroupDesc, gv.Gender, dbo.PGGetRoom(gv.GroupID) AS RoomNbr, gv.StartDate, gv.PrePig, gv.DaysIn, 
	  gv.StartWgt, gv.StartQty, gv.CurrentInv,
	  gv.Mortality, gv.FeedDays, dbo.PGGetSource(gv.GroupID) AS Source, gv.FeedIn, gv.LastFeed, gv.LastRation,
          mk.ProjCloseOut AS TopDate,
          mk.ProjCloseOut AS CloseDate,
	 -- CONVERT(CHAR(10),DateAdd(day, -21, DateAdd(day,((270-gv.StartWgt)/td.ADG),gv.StartDate)),101) As TopDate, 
	 -- CONVERT(CHAR(10),DateAdd(day,((270-gv.StartWgt)/td.ADG),gv.StartDate),101) As CloseDate, 
	 gv.NoSold, gv.AvgSaleWgt, gv.SiteContactID, gv.ContactName, gv.Pod, gv.PigSystemID As SystemID, gv.CF04
--Change this 7/25/2005 to use premarket calculated close SM
--	  CONVERT(CHAR(10),DateAdd(day, -21, mk.ProjCloseOut),101) As TopDate, 
--	  CONVERT(CHAR(10),mk.ProjCloseOut,101) As CloseDate, gv.NoSold, gv.AvgSaleWgt, gv.SiteContactID, gv.ContactName, gv.CF04
FROM      cfv_PigGroupSummaryBase gv
LEFT JOIN cftPigPreMkt mk ON gv.GroupID=mk.PigGroupID
LEFT JOIN cftPGTopClose2 td ON gv.Gender=td.GenderTypeID AND CONVERT(NUMERIC(2,0),DatePart(month, gv.StartDate))=td.BegStDate 
--LEFT JOIN cftPigPreMkt mk ON gv.GroupID=mk.PigGroupID



