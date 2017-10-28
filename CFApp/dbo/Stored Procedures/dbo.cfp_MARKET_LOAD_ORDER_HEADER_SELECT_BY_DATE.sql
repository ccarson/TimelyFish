-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 03/07/2008
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_ORDER_HEADER_SELECT_BY_DATE]
(
	@MovementDate	smalldatetime,
	@ContactID		int,
	@OrderType		char(2)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	BasePrice
	, ContrNbr
	, CustID
	, Descr
	, FirstDelDate
	, LastDelDate
	, LoadQty
	, OrdNbr
	, PkrContactID
	, PSOrdType
	, SaleBasis
	, TrkgPaidFlg
FROM 
	[$(SolomonApp)].dbo.cftPSOrdHdr WITH (NOLOCK) 
Where
	@MovementDate between FirstDelDate and LastDelDate
	And PkrContactID = @ContactID
	And PSOrdType = @OrderType
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_ORDER_HEADER_SELECT_BY_DATE] TO [db_sp_exec]
    AS [dbo];

