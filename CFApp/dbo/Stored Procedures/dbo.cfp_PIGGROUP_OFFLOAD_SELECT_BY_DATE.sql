--*************************************************************
--	Purpose:Display all offload records for a specific date
--	Author: Dave Killion
--	Date: 11/28/2007
--	Usage: Market Schedule 
--	Parms: MovementDate
--	      
--*************************************************************

create PROC [dbo].[cfp_PIGGROUP_OFFLOAD_SELECT_BY_DATE]
(
	@movementDate as smalldatetime
)
AS

Select 
      '' DestinationBarnNumber
      ,d.ContactID DestinationContactID
      ,d.ContactName DestinationDescription
      ,'' DestinationRoomNumber
      ,pm.EstimatedQty EstimatedQuantity
      ,pm.SourceBarnNbr SourceBarnNumber
      ,s.ContactID SourceContactID
      ,s.ContactName SourceDescription
      ,pm.SourceRoomNbr SourceRoomNumber
      ,pm.TranSubTypeID TransportTypeID
      ,pm.PMID LinkedSourcePigMovementID
      ,'' PigGroupID
      ,'' ProjectID
      ,'' TaskID
from [$(SolomonApp)].dbo.cftPM pm (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact s (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact d (NOLOCK) on pm.DestContactID=d.ContactID
where 
(pm.MovementDate=@movementDate
and right(rtrim(TranSubTypeID),1)='O')
and not exists
(SELECT * FROM [$(SolomonApp)].dbo.cftPigOffload WHERE SrcPMID = pm.PMID)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIGGROUP_OFFLOAD_SELECT_BY_DATE] TO [db_sp_exec]
    AS [dbo];

