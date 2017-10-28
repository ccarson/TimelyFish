
-- =============================================
-- Author:	mdawson
-- Create date: 11/8/2007
-- Description:	Updates Site Wash Schedule Record
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SITE_WASH_UPDATE] 
(
	@SiteWashID				int,
	@ContactID				int,
	@WashFromEffectDate		datetime,
	@WashToEffectDate		datetime,
	@UpdatedBy				varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_SITE_WASH
	SET 
		ContactID = @ContactID,
		WashFromEffectDate = @WashFromEffectDate,
		WashToEffectDate = @WashToEffectDate,
		UpdatedBy = @UpdatedBy,
		UpdatedDateTime = getdate()
	WHERE SiteWashID = @SiteWashID
END







GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_WASH_UPDATE] TO [db_sp_exec]
    AS [dbo];

