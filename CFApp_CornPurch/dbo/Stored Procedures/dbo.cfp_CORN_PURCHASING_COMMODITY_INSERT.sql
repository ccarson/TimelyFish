
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Creates new Commodity record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMODITY_INSERT]
(
    @Name		varchar(50),
    @Description	varchar(1000),
    @Active		bit,
    @IsDefault		bit,
    @CreatedBy		varchar(50)
)
AS
BEGIN

  SET NOCOUNT ON

  DECLARE @CommodityID int


  IF @ISDefault = 1 AND @Active = 0 BEGIN

  
    RAISERROR('Default Commodity can not be inactive!',16,1)
    RETURN

  END


  INSERT dbo.cft_COMMODITY
  (
      [Name],
      [Description],
      [Active],
      [IsDefault],
      [CreatedBy]
  )
  VALUES
  (
      @Name,
      @Description,
      @Active,
      @IsDefault,
      @CreatedBy
  )

  SELECT @CommodityID = CommodityID
  FROM dbo.cft_COMMODITY
  WHERE CommodityID = SCOPE_IDENTITY()

  IF @IsDefault = 1 BEGIN

    UPDATE dbo.cft_COMMODITY
    SET IsDefault = 0
    WHERE CommodityID <> @CommodityID
 
  END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMODITY_INSERT] TO [db_sp_exec]
    AS [dbo];

