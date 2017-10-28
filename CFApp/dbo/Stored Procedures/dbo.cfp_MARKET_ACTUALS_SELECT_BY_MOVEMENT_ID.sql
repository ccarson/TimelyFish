
-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/03/2008
-- Description:	Returns the actual qty and weight for a load
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_ACTUALS_SELECT_BY_MOVEMENT_ID]
(
	@PigMovementId int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select cftPSDetail.detailtypeid
		   , cftPSDetail.qty ActualQuantity
		   , cftPSDetail.wgtlive ActualWeight
	from [$(SolomonApp)].dbo.cftPigSale cftPigSale WITH (nolock)
		left join [$(SolomonApp)].dbo.cftpigsale cftPigSale_RefNbr WITH (nolock) on cftPigSale_RefNbr.origrefnbr = cftPigSale.refnbr
		join [$(SolomonApp)].dbo.cftpsdetail cftPSDetail WITH (nolock) on cftPigSale.refnbr = cftPSDetail.refnbr
	where cftPigSale_RefNbr.refnbr is null 
	and cftPigSale.doctype <> 'RE' 
	and cftPigSale.pmloadid = @PigMovementId
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_ACTUALS_SELECT_BY_MOVEMENT_ID] TO [db_sp_exec]
    AS [dbo];

