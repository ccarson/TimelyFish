-- ===============================================================
-- Author:		Brian Cesafsky
-- Create date: 07/24/2008
-- Description:	Inserts a record in cft_FSA_OFFICE_CORN_PRODUCER
-- ===============================================================
CREATE PROCEDURE dbo.cfp_FSA_OFFICE_CORN_PRODUCER_DELETE_INSERT
(
    @CornProducerID		varchar(15),
    @FsaOfficeIDs		varchar(4000),
    @CreatedBy			varchar(50)
)
AS
BEGIN
SET NOCOUNT ON;

BEGIN TRAN

DELETE dbo.cft_FSA_OFFICE_CORN_PRODUCER
WHERE CornProducerID = @CornProducerID

INSERT dbo.cft_FSA_OFFICE_CORN_PRODUCER
(
   CornProducerID,
   FsaOfficeID,
   CreatedBy
)
SELECT @CornProducerID,
       Value,
       @CreatedBy
FROM dbo.cffn_SPLIT_STRING(@FsaOfficeIDs,',')

COMMIT TRAN


END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_CORN_PRODUCER_DELETE_INSERT] TO [db_sp_exec]
    AS [dbo];

