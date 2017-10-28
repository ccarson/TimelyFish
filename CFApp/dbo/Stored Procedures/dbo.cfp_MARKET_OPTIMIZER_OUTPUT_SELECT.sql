-- ===============================================================================
-- Author:		Brian Cesafsky
-- Create date: 01/21/2007
-- Description:	Selects all records from the cft_MARKET_OPTIMIZER_OUTPUT table
-- ===============================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-26  Doran Dahle Added EstimatedWgt
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_OUTPUT_SELECT]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT 
	loadID
	, day
	, packer
	, EstimatedWgt
FROM 
	dbo.cft_MARKET_OPTIMIZER_OUTPUT (NOLOCK)
Order By loadID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_OUTPUT_SELECT] TO [db_sp_exec]
    AS [dbo];

