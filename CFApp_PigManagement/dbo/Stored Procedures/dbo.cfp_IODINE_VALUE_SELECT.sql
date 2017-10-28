-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/27/2009
-- Description:	Selects iodine values
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_IODINE_VALUE_SELECT]
AS
BEGIN
	SELECT [IodineID]
		 , [TattooID]
		 , [KillDate]
		 , [IodineValueNir]
		 , [IodineValueBarrowAgee]
		 , [HotCarcassWeight]
		 , [BackFat] 
		 , [CreatedDateTime]
		 , [CreatedBy]
		 , [UpdatedDateTime]
		 , [UpdatedBy] 
	FROM [dbo].cft_IODINE_VALUE (NOLOCK)
	ORDER BY KillDate desc
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_IODINE_VALUE_SELECT] TO [db_sp_exec]
    AS [dbo];

