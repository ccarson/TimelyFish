-- ===============================================================
-- Author:		Brian Cesafsky
-- Create date: 07/24/2008
-- Description:	Selects all FSA offices for a Corn Producer
-- ===============================================================
CREATE PROCEDURE [dbo].[cfp_FSA_OFFICE_SELECT_BY_CORN_PRODUCER]
(
     @CornProducerID		varchar(15)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT FsaOfficeID
FROM  dbo.cft_FSA_OFFICE_CORN_PRODUCER
WHERE CornProducerID = @CornProducerID
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_SELECT_BY_CORN_PRODUCER] TO [db_sp_exec]
    AS [dbo];

