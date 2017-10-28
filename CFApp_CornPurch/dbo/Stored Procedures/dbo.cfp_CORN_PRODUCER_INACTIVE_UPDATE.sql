-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/28/2008
-- Description:	Updates records when a corn producer is set to In-Active
-- =======================================================================
CREATE PROCEDURE dbo.cfp_CORN_PRODUCER_INACTIVE_UPDATE
(
		@CornProducerID		varchar(15)
		,@UpdatedBy			varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_CORN_PRODUCER_FARM
	SET [Active] = 0
	  ,[UpdatedBy] = @UpdatedBy

	WHERE 
	[CornProducerID] = @CornProducerID

UPDATE dbo.cft_QUOTE
SET Active = 0
FROM dbo.cft_QUOTE Q
LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET PT ON PT.QuoteID = Q.QuoteID
WHERE PT.PartialTicketID IS NULL AND Q.CornProducerID = @CornProducerID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_INACTIVE_UPDATE] TO [db_sp_exec]
    AS [dbo];

