
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects Gl record by feed mill id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GL_SELECT_BY_FEED_MILL]
(
    @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GlTypeID],
       [GlID],
       [ExpenseAccount],
       [SubAccount],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GL
WHERE FeedMillID = @FeedMillID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GL_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];

