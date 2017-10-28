

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 09/09/2011
-- Description:	Populates the Data Warehouse table.
-- ===================================================================

CREATE PROCEDURE [dbo].[cfp_SHOW_HIERARCHY]
(
	@Root	char(10)
)
AS
BEGIN
		SET NOCOUNT ON
		DECLARE @SourcePigGroupID char(10), @PigGroupID char(10)
		
		SET @PigGroupID = (Select PigGroupID From  dbo.cft_PIG_INV_TRAN Where Source = @Root)
		
		SET @SourcePigGroupID = (Select Min(Source) From  dbo.cft_PIG_INV_TRAN Where PigGroupID = @Root) 
		
		WHILE @SourcePigGroupID is Not Null
		BEGIN
				EXEC  dbo.cfp_SHOW_HIERARCHY @SourcePigGroupID
				SET @SourcePigGroupID = (Select Distinct Top 1 Source From  dbo.cft_PIG_INV_TRAN Where PigGroupID = @Root) 
				--and Source > @SourcePigGroupID)
		END
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SHOW_HIERARCHY] TO [db_sp_exec]
    AS [dbo];

