
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects Checkoff record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CHECKOFF_SELECT_BY_ID]
(
    @CheckoffID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [FeedMillID],
       [CheckoffTypeID],
       [Active],
       [Rate],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_CHECKOFF
WHERE CheckoffID = @CheckoffID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CHECKOFF_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

