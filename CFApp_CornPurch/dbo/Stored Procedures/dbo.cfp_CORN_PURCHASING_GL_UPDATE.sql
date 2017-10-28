
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the Gl record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GL_UPDATE]
(
    @GlID	int,
    @GlTypeID	int,
    @FeedMillID	varchar(10),
    @ExpenseAccount	varchar(50),
    @SubAccount	varchar(50),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GL SET
    [GlTypeID] = @GlTypeID,
    [FeedMillID] = @FeedMillID,
    [ExpenseAccount] = @ExpenseAccount,
    [SubAccount] = @SubAccount,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GlID = @GlID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GL_UPDATE] TO [db_sp_exec]
    AS [dbo];

