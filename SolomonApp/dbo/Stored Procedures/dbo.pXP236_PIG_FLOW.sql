
--*************************************************************
--	Purpose:Pig Group list based on user parameters
--		
--	Author: Nick Honetschlager
--	Date: 6/12/2013
--	Usage: Pig Group Validation Screen
--*************************************************************

CREATE PROCEDURE [dbo].[pXP236_PIG_FLOW]
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
BEGIN
		SELECT [PigFlowID]
			 , [PigFlowDescription]
		FROM CFApp_PigManagement.dbo.cft_PIG_FLOW (NOLOCK)
		ORDER BY PigFlowDescription asc
END


