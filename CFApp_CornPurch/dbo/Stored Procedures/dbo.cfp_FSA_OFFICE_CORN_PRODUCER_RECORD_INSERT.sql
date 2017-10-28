
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 09/01/2008
-- Description:	Creates new record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_FSA_OFFICE_CORN_PRODUCER_RECORD_INSERT
(
    @FsaOfficeCornProducerID		int		OUT,
    @CornProducerID varchar(15), 
    @FsaOfficeID varchar(15),
    @FsaPaymentAmount decimal(18,4),
    @FsaLoanNumber varchar(100),
    @CreatedBy varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_FSA_OFFICE_CORN_PRODUCER
  (
		CornProducerID,
		FsaOfficeID,
		FsaPaymentAmount,
		FsaLoanNumber,
		CreatedBy,
		CreatedDateTime
  )
  VALUES
  (
		@CornProducerID,
		@FsaOfficeID,
		@FsaPaymentAmount,
		@FsaLoanNumber,
		@CreatedBy,
		getdate()
  )

  SELECT @FsaOfficeCornProducerID = FsaOfficeCornProducerID
  FROM dbo.cft_FSA_OFFICE_CORN_PRODUCER
  WHERE FsaOfficeCornProducerID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_CORN_PRODUCER_RECORD_INSERT] TO [db_sp_exec]
    AS [dbo];

