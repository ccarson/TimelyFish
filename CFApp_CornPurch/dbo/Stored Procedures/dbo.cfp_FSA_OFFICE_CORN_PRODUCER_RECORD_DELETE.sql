
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 09/01/2008
-- Description:	Deletes record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_FSA_OFFICE_CORN_PRODUCER_RECORD_DELETE
(
    @FsaOfficeCornProducerID	int
)
AS
BEGIN
  SET NOCOUNT ON

  DELETE dbo.cft_FSA_OFFICE_CORN_PRODUCER
  WHERE FsaOfficeCornProducerID = @FsaOfficeCornProducerID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_CORN_PRODUCER_RECORD_DELETE] TO [db_sp_exec]
    AS [dbo];

