-- ====================================================================
-- Author:		Brian Cesafsky
-- Create date: 10/23/2008
-- Description:	Deletes all records from cft_UNSETTLED_DRYING_CHARGE
-- ====================================================================
CREATE PROCEDURE dbo.cfp_UNSETTLED_DRYING_CHARGE_DELETE
AS
BEGIN

DELETE FROM dbo.cft_UNSETTLED_DRYING_CHARGE

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_UNSETTLED_DRYING_CHARGE_DELETE] TO [db_sp_exec]
    AS [dbo];

