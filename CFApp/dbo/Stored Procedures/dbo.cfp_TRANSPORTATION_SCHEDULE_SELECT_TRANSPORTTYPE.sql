-- =============================================
-- Author:		Dave Killion
-- Create date: 11/14/2007	
-- Description:	Returns the transport type id, description, source and destination
-- phase id's. Used for only Market Movements and Trailer movements
-- =============================================
create PROCEDURE [dbo].[cfp_TRANSPORTATION_SCHEDULE_SELECT_TRANSPORTTYPE]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select
	tt.Description
	,pts.trantypeid TransportationTypeID
	,pts.destprodphaseid DestinationProductionPhaseID
	,pts.srcprodphaseid SourceProductionPhaseID
	,Sourceppp.prodtype SourceProductionTypeID
	,Destppp.prodtype DestinationProductionTypeID
from
	[$(SolomonApp)].dbo.cftpigtrantype tt (nolock)
	inner join [$(SolomonApp)].dbo.cftpigtransys pts (nolock) on pts.trantypeid = tt.trantypeid
	left join [$(SolomonApp)].dbo.cftPigProdPhase Sourceppp (nolock) on Sourceppp.PigProdPhaseID = pts.SrcProdPhaseID
	left join [$(SolomonApp)].dbo.cftPigProdPhase Destppp (nolock) on Destppp.PigProdPhaseID = pts.DestProdPhaseID
where 
	(pts.trantypeid like '%M' 
		or pts.trantypeid like '%T'
		or pts.trantypeid like '%C'
		or pts.trantypeid like '%E')
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRANSPORTATION_SCHEDULE_SELECT_TRANSPORTTYPE] TO [db_sp_exec]
    AS [dbo];

