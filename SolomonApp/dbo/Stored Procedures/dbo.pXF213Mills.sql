CREATE   Procedure [dbo].[pXF213Mills]
----------------------------------------------------------------------------------------
--	Purpose: Mill PV
--	Author: Sue Matter
--	Date: 7/20/2006
--	Program Usage: XF213
--	Parms: @parmmill Mill Id
----------------------------------------------------------------------------------------

AS
Select *
From cfvMills
--limit the mill selection to SE and IF
Where MillID IN ('001327','001330','005248','011306')

