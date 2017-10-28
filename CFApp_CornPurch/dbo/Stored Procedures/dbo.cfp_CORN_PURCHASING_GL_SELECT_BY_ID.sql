
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects Gl record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GL_SELECT_BY_ID]
(
    @GlID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GlTypeID],
       [FeedMillID],
       [ExpenseAccount],
       [SubAccount],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GL
WHERE GlID = @GlID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GL_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

