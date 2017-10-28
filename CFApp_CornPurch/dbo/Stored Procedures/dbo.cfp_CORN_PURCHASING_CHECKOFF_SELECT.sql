
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all Checkoff records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CHECKOFF_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [CheckoffID],
       [FeedMillID],
       [CheckoffTypeID],
       [Active],
       [Rate],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_CHECKOFF
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CHECKOFF_SELECT] TO [db_sp_exec]
    AS [dbo];

