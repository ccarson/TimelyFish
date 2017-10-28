


-- =============================================
-- Author:	ddahle
-- Create date: 07/14/2015
-- Description:	select trailer records
-- =============================================
CREATE PROCEDURE [dbo].[cfp_PIG_TRAILER_SELECT]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	  SELECT [Description],
      [PigTrailerID]
  FROM [$(SolomonApp)].[dbo].[cftPigTrailer] (NOLOCK)
  --where [StatusTypeID] = 0
  order by [Description]
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_TRAILER_SELECT] TO [db_sp_exec]
    AS [dbo];

