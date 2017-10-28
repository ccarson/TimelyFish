/*
-- =========================================================
-- Author:		Doran Dahle	
-- Create date: 11/09/2011
-- Description:	Used with inventory Issues screen to set a default site
-- =========================================================

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-11-209 Doran Dahle initial release

===============================================================================
*/
CREATE PROC [dbo].[CFP_All_ItemSite]
	@parm1 as varchar(10)
AS
SELECT distinct SiteId, Name FROM vi_SiteWithInvtFlag (NOLOCK) where CpnyID = 'CFF' AND SiteID LIKE @parm1 order by SiteId

