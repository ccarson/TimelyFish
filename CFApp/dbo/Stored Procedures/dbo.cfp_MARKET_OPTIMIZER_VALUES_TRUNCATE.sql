/*
-- ========================================================
-- Author:		Doran Dahle
-- Create date: 7/21/2011
-- Description:	Deletes all records from the table
-- ========================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-21  Doran Dahle initial release

===============================================================================
*/
CREATE PROCEDURE [dbo].cfp_MARKET_OPTIMIZER_VALUES_TRUNCATE
AS
BEGIN

--Truncate table dbo.cft_MARKET_OPTIMIZER_VALUES
 Delete from dbo.cft_MARKET_OPTIMIZER_LOAD_VALUES
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_VALUES_TRUNCATE] TO [db_sp_exec]
    AS [dbo];

