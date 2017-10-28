-- ============================================================
-- Author:		Sergey Neskin
-- Create date: 01/09/2008
-- Description:	Updates a FSA_OFFICE_CORN_PRODUCER_RECORD
-- ============================================================
CREATE PROCEDURE dbo.cfp_FSA_OFFICE_CORN_PRODUCER_RECORD_UPDATE
(
	@FsaOfficeCornProducerID int,
	@FsaOfficeID	varchar(15),
    @CornProducerID	varchar(15),
    @FsaPaymentAmount	decimal(18,4),
    @FsaLoanNumber		varchar(100),
    @UpdatedBy		varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_FSA_OFFICE_CORN_PRODUCER
   SET [FsaOfficeID] = @FsaOfficeID,
       [CornProducerID] = @CornProducerID,
       [FsaPaymentAmount] = @FsaPaymentAmount,
       [FsaLoanNumber] = @FsaLoanNumber,
       [UpdatedDateTime] = getdate(),
       [UpdatedBy] = @UpdatedBy
 WHERE FsaOfficeCornProducerID = @FsaOfficeCornProducerID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_CORN_PRODUCER_RECORD_UPDATE] TO [db_sp_exec]
    AS [dbo];

