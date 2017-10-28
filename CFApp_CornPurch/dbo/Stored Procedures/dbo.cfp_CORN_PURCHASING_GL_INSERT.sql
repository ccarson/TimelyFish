
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new Gl record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GL_INSERT]
(
    @GlID	int	OUT,
    @GlTypeID	int,
    @FeedMillID	varchar(10),
    @ExpenseAccount	varchar(50),
    @SubAccount	varchar(50),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GL
  (
      [GlTypeID],
      [FeedMillID],
      [ExpenseAccount],
      [SubAccount],
      [CreatedBy]
  )
  VALUES
  (
      @GlTypeID,
      @FeedMillID,
      @ExpenseAccount,
      @SubAccount,
      @CreatedBy
  )

  SELECT @GlID = GlID
  FROM dbo.cft_GL
  WHERE GlID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GL_INSERT] TO [db_sp_exec]
    AS [dbo];

