
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the Checkoff record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_CHECKOFF_UPDATE
(
    @CheckoffID	int,
    @FeedMillID	varchar(10),
    @CheckoffTypeID	int,
    @Active	bit,
    @Rate	decimal(20,6),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_CHECKOFF SET
    [FeedMillID] = @FeedMillID,
    [CheckoffTypeID] = @CheckoffTypeID,
    [Active] = @Active,
    [Rate] = @Rate,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE CheckoffID = @CheckoffID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CHECKOFF_UPDATE] TO [db_sp_exec]
    AS [dbo];

