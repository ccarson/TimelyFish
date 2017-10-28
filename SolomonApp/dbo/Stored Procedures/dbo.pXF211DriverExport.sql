CREATE Procedure pXF211DriverExport
AS

----------------------------------------------------------------------------------------
--	Purpose: Select Driver Data for WEM Database 
--	Author: Sue Matter
--	Date: 8/11/2006
--	Program Usage: 
--	Parms: 
----------------------------------------------------------------------------------------


select '"' + ContactID + '",' + '"'+  RTrim(ContactName) + '"' 
from cftFeedDriver

