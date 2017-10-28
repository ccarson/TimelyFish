-- ====================================================
-- Author:		Brian Cesafsky
-- Create date: 04/28/2008
-- Description:	Returns all farms for a corn producer
-- ====================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_FARM_SELECT]
(
	@CornProducerID		varchar(15)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT CornProducerFarm.CornProducerFarmID
	    ,CornProducerFarm.ContactID
		,CornProducerFarm.CornProducerID
		,CornProducerFarm.RoadRestrictionWeight
		,CornProducerFarm.Active
		,CornProducerFarm.Comments
		,Vendor.Name 'ContactName'
FROM dbo.cft_CORN_PRODUCER_FARM CornProducerFarm
LEFT JOIN dbo.cft_VENDOR Vendor (NOLOCK)
	ON RTRIM(Vendor.VendID) = RTRIM(CornProducerFarm.CornProducerID)
WHERE CornProducerFarm.CornProducerID = @CornProducerID
ORDER BY CornProducerFarm.Active, Vendor.Name
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_FARM_SELECT] TO [db_sp_exec]
    AS [dbo];

