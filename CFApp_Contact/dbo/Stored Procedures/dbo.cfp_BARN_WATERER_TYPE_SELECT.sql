﻿-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 03/01/2009
-- Description:	
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_BARN_WATERER_TYPE_SELECT]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [WatererTypeID]
	  ,[WatererTypeDescription]
	  ,[CreatedDateTime]
	  ,[CreatedBy]
	  ,[UpdatedDateTime]
	  ,[UpdatedBy]
	FROM [dbo].[cft_BARN_WATERER_TYPE]
	ORDER BY 2

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_BARN_WATERER_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

