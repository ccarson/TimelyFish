
----------------------------------------------------------------------------------------
--	Purpose: Select Flow name of the entered site at the date entered
--	Author: Doran Dahle
--	Date: 10/01/2014
--	Program Usage: cfv_PM_SAFE_Wgt, Load weight application
--	Parms: @SiteConactID site contact ID
--	Parms: @date requested date

----------------------------------------------------------------------------------------


/*
===============================================================================
Change Log:
Date        Who         Change
----------- ----------- -------------------------------------------------------
10/01/2014  Doran Dahle First Deploy
===============================================================================
*/



CREATE Function [dbo].[getSiteFlow]
	(@SiteContactID as varchar(6), @date as smalldatetime)
RETURNS varchar(100)

AS
BEGIN
DECLARE @ContactID as INT
Set @ContactID = CONVERT(INT, @SiteContactID)
 
RETURN (select top 1 rg.reporting_group_description 
FROM CFApp_PigManagement.dbo.cft_PIG_FLOW pf (NOLOCK)
JOIN [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (NOLOCK)  on pf.[PigFlowID] = pff.[PigFlowID]
join cfapp_pigmanagement.dbo.cft_pig_flow_reporting_group rg (nolock)
	on rg.reportinggroupid = pf.reportinggroupid
where @date between pf.pigflowfromdate and isnull(pf.[PigFlowToDate],getdate())
and pff.ContactID = @ContactID
and rg.reportinggroupid <> 0)

END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getSiteFlow] TO [MSDSL]
    AS [dbo];

