-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/27/2009
-- Description:	Creates an Iodine Value record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_IODINE_VALUE_INSERT]
(	
	@TattooID [int] 
	,@KillDate [datetime]
	,@IodineValueNir [decimal](10, 2)
	,@IodineValueBarrowAgee [decimal](10, 2) 
	,@HotCarcassWeight [decimal](10, 2) 
	,@BackFat [decimal](10, 2)
	,@CreatedBy [varchar](50) 
)
AS
BEGIN
	INSERT INTO dbo.cft_IODINE_VALUE
	(
		TattooID
		,KillDate
		,IodineValueNir
		,IodineValueBarrowAgee
		,HotCarcassWeight
		,BackFat
		,CreatedBy
	)
	VALUES 
	(
		@TattooID
		,@KillDate
		,@IodineValueNir
		,@IodineValueBarrowAgee
		,@HotCarcassWeight
		,@BackFat
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_IODINE_VALUE_INSERT] TO [db_sp_exec]
    AS [dbo];

