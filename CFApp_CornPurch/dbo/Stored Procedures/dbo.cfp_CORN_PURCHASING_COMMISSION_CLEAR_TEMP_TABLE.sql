
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/07/2008
-- Description:	 creates temp table for previewing commissions on commission management screen
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_CLEAR_TEMP_TABLE
AS
BEGIN
SET NOCOUNT ON;

DELETE dbo.cft_COMMISSION_TEMP

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_CLEAR_TEMP_TABLE] TO [db_sp_exec]
    AS [dbo];

