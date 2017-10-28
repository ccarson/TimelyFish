/*
-- ================================================================================
-- Author:		Doran Dahle
-- Create date: 07/21/2011
-- Description:	Returns the WT/ADG values for the given week
-- ================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-21  Doran Dahle initial release

===============================================================================
*/

CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_WEIGHT_PREDICTOR_SELECT_BY_WEEK]
(
	@WeekNbr				int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	   [WT]
      ,[ADG]
  FROM [dbo].[cft_MARKET_OPTIMIZER_WEIGHT_PREDICTOR]
	WHERE WK = @WeekNbr
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_WEIGHT_PREDICTOR_SELECT_BY_WEEK] TO [db_sp_exec]
    AS [dbo];

