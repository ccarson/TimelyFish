-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 03/19/2009
-- Description:	Inserts a record into cft_PACKER_BYPASS
-- ============================================================
CREATE PROCEDURE dbo.cfp_PACKER_BYPASS_INSERT
(
		@ContactID						int
		,@PigProdPodID					varchar(3)
		,@FeedRation					varchar(1000)
		,@CreatedBy						varchar(50)
)
AS
BEGIN
INSERT INTO [cft_PACKER_BYPASS]
(
	   ContactID
	   ,PigProdPodID
	   ,FeedRation
	   ,CreatedBy
)
VALUES
(
		@ContactID
		,@PigProdPodID
		,@FeedRation
		,@CreatedBy
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_BYPASS_INSERT] TO [db_sp_exec]
    AS [dbo];

