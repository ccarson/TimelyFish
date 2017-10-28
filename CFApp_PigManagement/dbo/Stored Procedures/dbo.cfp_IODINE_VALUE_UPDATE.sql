-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/27/2009
-- Description:	Updates an Iodine Value record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_IODINE_VALUE_UPDATE]
(
	@IodineID [int] 
	,@TattooID [int] 
	,@KillDate [datetime]
	,@IodineValueNir [decimal](10, 2)
	,@IodineValueBarrowAgee [decimal](10, 2) 
	,@HotCarcassWeight [decimal](10, 2) 
	,@BackFat [decimal](10, 2)
	,@UpdatedBy [varchar](50) 
)
AS
BEGIN
	UPDATE dbo.cft_IODINE_VALUE 
	SET TattooID = @TattooID
		,KillDate = @KillDate
		,IodineValueNir = @IodineValueNir
		,IodineValueBarrowAgee = @IodineValueBarrowAgee
		,HotCarcassWeight = @HotCarcassWeight
		,BackFat = @BackFat
		,UpdatedDateTime = getdate()
		,UpdatedBy = @UpdatedBy
	WHERE [IodineID] = @IodineID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_IODINE_VALUE_UPDATE] TO [db_sp_exec]
    AS [dbo];

