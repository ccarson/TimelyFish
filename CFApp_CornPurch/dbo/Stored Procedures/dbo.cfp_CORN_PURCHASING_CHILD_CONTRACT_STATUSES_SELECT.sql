
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 08/31/2008
-- Description:	Selects child contract statuses by contract id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CHILD_CONTRACT_STATUSES_SELECT]
(
    @ContractID		int
)
AS
BEGIN
SET NOCOUNT ON;

	DECLARE @SequenceNumber int
	DECLARE @FeedMillID char(10)

	SELECT @SequenceNumber = C.SequenceNumber, @FeedMillId = C.FeedMillId
	FROM cft_CONTRACT C
	WHERE C.ContractID = @ContractID AND C.SubsequenceNumber IS NULL


	SELECT DISTINCT ContractStatusID
	FROM dbo.cft_CONTRACT C 
	WHERE FeedMillID = @FeedMillID 
	      AND SequenceNumber = @SequenceNumber 
		  AND C.SubsequenceNumber IS NOT NULL

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CHILD_CONTRACT_STATUSES_SELECT] TO [db_sp_exec]
    AS [dbo];

