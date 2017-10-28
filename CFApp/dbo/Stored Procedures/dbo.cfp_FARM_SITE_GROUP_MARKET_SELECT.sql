-- =============================================
-- Author:		Dave Killion
-- Create date: 11/29/2007
-- Description:	Returns all available packers based upon
-- the date passed into the stored procedure.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FARM_SITE_GROUP_MARKET_SELECT]
(
	@MovementDate					datetime,
	@LoadID							int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	Select 
		PS.ContrNbr ContractNumber
		,c.ContactName Packer
		,PS.Descr Description
		,ps.OrdNbr OrderNumber
		,ps.PSOrdType OrderType
		,ps.FirstDelDate BeginDeliveryDate
		,ps.LastDelDate EndDeliveryDate
		,ps.PkrContactID ContactID
		,'' ProjectID
		,'' TaskID
		,'' BarnNumber
		,'' RoomNumber
		,'' PigGroupID
		,cft_MARKET_OPTIMIZER.NetLoadAmount
      from 
            [$(SolomonApp)].dbo.cftPSOrdHdr ps WITH (NOLOCK) 
            JOIN [$(SolomonApp)].dbo.cftContact c WITH (NOLOCK) 
                  on c.ContactID=ps.PkrContactID 
                    Left JOIN dbo.cft_MARKET_OPTIMIZER cft_MARKET_OPTIMIZER (NOLOCK)
                                  on cft_MARKET_OPTIMIZER.ContactID = c.ContactID
                                  and cft_MARKET_OPTIMIZER.LoadID = @LoadID
	where 
		@MovementDate between FirstDelDate and LastDelDate
	order by cft_MARKET_OPTIMIZER.NetLoadAmount desc,
			 Packer asc

END






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FARM_SITE_GROUP_MARKET_SELECT] TO [db_sp_exec]
    AS [dbo];

