
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Updates the Commodity record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMODITY_UPDATE]
(
    @CommodityID	tinyint,
    @Name		varchar(50),
    @Description	varchar(1000),
    @Active		bit,
    @IsDefault		bit,
    @UpdatedBy		varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON


  -- do not allow both to make default commodity not default and not active


  IF @ISDefault = 1 AND @Active = 0 BEGIN

  
    RAISERROR('Default Commodity can not be inactive!',16,1)
    RETURN

  END

  DECLARE @WasDefault bit

  SELECT @WasDefault = IsDefault
  FROM dbo.cft_COMMODITY
  WHERE CommodityID = @CommodityID

  IF @WasDefault = 1 AND @IsDefault = 0 BEGIN

    RAISERROR('There must be one default active Commodity !',16,1)
    RETURN

  END


  UPDATE dbo.cft_COMMODITY SET
    Name = @Name,
    Description = @Description,
    Active = @Active,
    IsDefault = @IsDefault,
    UpdatedBy = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE CommodityID = @CommodityID

  IF @IsDefault = 1 BEGIN -- if commodity is updated to default, reset previous default commodity

    UPDATE dbo.cft_COMMODITY
    SET IsDefault = 0
    WHERE CommodityID <> @CommodityID
 
  END 

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMODITY_UPDATE] TO [db_sp_exec]
    AS [dbo];

