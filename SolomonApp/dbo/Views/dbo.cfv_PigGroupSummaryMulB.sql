
/****** Object:  View dbo.cfv_PigGroupSummaryMulB    Script Date: 10/5/2005 10:28:55 AM ******/
CREATE         VIEW cfv_PigGroupSummaryMulB
AS
SELECT    gv.Company, gv.PhaseDesc, sd.SiteID, sd.ContactName As SiteName, gv.Description As Status, 
	  gv.GroupID, gv.GroupDesc, gv.Gender, gv.StartDate, CONVERT(NUMERIC(3,0),(ab.WgtdDate/ab.WgtQty)) As AvgBirth
FROM      cfv_PigGroupSummaryBase gv
LEFT JOIN cfv_GroupMAvgBirth ab ON gv.GroupID=ab.PigGroupID
LEFT JOIN cfvSite sd ON gv.SiteContactID=sd.ContactID
Where gv.PigSystemID='01'





