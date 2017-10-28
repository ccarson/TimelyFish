
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all Gl records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GL_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [GlID],
       [GlTypeID],
       [FeedMillID],
       [ExpenseAccount],
       [SubAccount],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GL
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GL_SELECT] TO [db_sp_exec]
    AS [dbo];

