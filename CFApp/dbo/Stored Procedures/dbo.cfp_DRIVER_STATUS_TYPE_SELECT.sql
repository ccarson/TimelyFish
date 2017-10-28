-- =============================================
-- Author:        Dave Killion
-- Create date: 11/8/2007
-- Description:   Returns all records from cft_DRIVER_STATUS_TYPE
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_STATUS_TYPE_SELECT]

AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

SELECT [StatusID]
      ,[StatusDescription]
  FROM [dbo].[cft_DRIVER_STATUS_TYPE] (NOLOCK)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_STATUS_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

