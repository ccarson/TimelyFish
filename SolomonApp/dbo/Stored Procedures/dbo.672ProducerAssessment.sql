--*************************************************************
--	Purpose:Feed Order Producer Assessment by Site and Date Range 
--		
--	Author: Charity Anderson
--	Date: 6/15/2005
--	Usage: Feed Order Producer Assessment Report
--	Parms: SiteName,BegDate,EndDate
--*************************************************************

CREATE PROC [dbo].[672ProducerAssessment]
		(@parm1 as char(30))

AS
SET @parm1=rtrim(@parm1) + '%'
Select c.ContactName as Site  ,v.RespPty,v.IssueType,(v.QtyDel/2000) as Tons,
v.DateDel 

FROM
vCF685SystemFOIssues v
LEFT JOIN cftContact c on v.Site=c.ContactID


where c.ContactName like @parm1
--and v.DateDel between @parm2 and @parm3
and v.RespPty='F'
