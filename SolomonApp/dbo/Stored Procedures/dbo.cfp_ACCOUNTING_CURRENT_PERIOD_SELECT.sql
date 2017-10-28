-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 09/17/2008
-- Description:	
-- =======================================================================
CREATE PROCEDURE [dbo].[cfp_ACCOUNTING_CURRENT_PERIOD_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PerNbr
	FROM GLSetup (NOLOCK)
END
