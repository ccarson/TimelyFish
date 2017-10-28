CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_BASE_SOURCE_PROCESS]
AS

----------------------------------------------------------
--DISABLE LOG SHIPPING
----------------------------------------------------------
UPDATE MSDB.dbo.sysjobs
SET Enabled = 0
WHERE [Name] LIKE 'Log Shipping copy for EARTH.SolomonApp_logshipping'

UPDATE MSDB.dbo.sysjobs
SET Enabled = 0
WHERE [Name] LIKE 'Log Shipping Restore for EARTH.SolomonApp_logshipping'



----------------------------------------------------------
--POPULATE
----------------------------------------------------------

EXEC dbo.cfp_PIG_GROUP_BASE_SOURCE


----------------------------------------------------------
--ENABLE LOG SHIPPING
----------------------------------------------------------
UPDATE MSDB.dbo.sysjobs
SET Enabled = 1
WHERE [Name] LIKE 'Log Shipping copy for EARTH.SolomonApp_logshipping'

UPDATE MSDB.dbo.sysjobs
SET Enabled = 1
WHERE [Name] LIKE 'Log Shipping Restore for EARTH.SolomonApp_logshipping'



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_BASE_SOURCE_PROCESS] TO [db_sp_exec]
    AS [dbo];

