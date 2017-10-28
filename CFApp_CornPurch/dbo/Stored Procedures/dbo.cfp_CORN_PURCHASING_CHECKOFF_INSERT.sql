
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new Checkoff record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_CHECKOFF_INSERT
(
    @CheckoffID	int	OUT,
    @FeedMillID	varchar(10),
    @CheckoffTypeID	int,
    @Active	bit,
    @Rate	decimal(20,6),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_CHECKOFF
  (
      [FeedMillID],
      [CheckoffTypeID],
      [Active],
      [Rate],
      [CreatedBy]
  )
  VALUES
  (
      @FeedMillID,
      @CheckoffTypeID,
      @Active,
      @Rate,
      @CreatedBy
  )

  SELECT @CheckoffID = CheckoffID
  FROM dbo.cft_CHECKOFF
  WHERE CheckoffID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CHECKOFF_INSERT] TO [db_sp_exec]
    AS [dbo];

