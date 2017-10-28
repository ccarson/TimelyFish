-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 03/19/2009
-- Description:	Updates a record in cft_PACKER_BYPASS
-- ============================================================
CREATE PROCEDURE dbo.cfp_PACKER_BYPASS_UPDATE
(
		@ContactID					int
		,@PigProdPodID				varchar(3)
		,@FeedRation				varchar(1000)
		,@UpdatedBy					varchar(50)
)
AS
BEGIN

	UPDATE dbo.cft_PACKER_BYPASS
	SET PigProdPodID = @PigProdPodID
		,FeedRation = @FeedRation
		,UpdatedDateTime = GetDate()
		,UpdatedBy = @UpdatedBy
	WHERE ContactID = @ContactID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_BYPASS_UPDATE] TO [db_sp_exec]
    AS [dbo];

