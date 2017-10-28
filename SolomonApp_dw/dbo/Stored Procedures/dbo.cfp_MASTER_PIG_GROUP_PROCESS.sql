
CREATE PROCEDURE [dbo].[cfp_MASTER_PIG_GROUP_PROCESS]
AS

DECLARE @LogID bigint


----------------------------------------------------------
--DISABLE LOG SHIPPING
----------------------------------------------------------
EXEC cfp_PROCESS_LOG_INSERT 'LOG SHIPPING', 'Disable LogShip Copy', 'SP', @ProcessLogID = @LogID OUTPUT
UPDATE MSDB.dbo.sysjobs
SET Enabled = 0
WHERE [Name] LIKE 'Log Shipping copy for EARTH.SolomonApp_logshipping'

 
EXEC cfp_PROCESS_LOG_UPDATE @LogID

EXEC cfp_PROCESS_LOG_INSERT 'LOG SHIPPING', 'Disable LogShip Restore', 'SP', @ProcessLogID = @LogID OUTPUT
UPDATE MSDB.dbo.sysjobs
SET Enabled = 0
WHERE [Name] LIKE 'Log Shipping Restore for EARTH.SolomonApp_logshipping'


EXEC cfp_PROCESS_LOG_UPDATE @LogID


----------------------------------------------------------
--POPULATE
----------------------------------------------------------
EXEC cfp_PROCESS_LOG_INSERT 'Pig Group Base Source', 'cfp_PIG_GROUP_BASE_SOURCE', 'SP', @ProcessLogID = @LogID OUTPUT

EXEC dbo.cfp_PIG_GROUP_BASE_SOURCE 'N'
-- 2012 sripley, new version requires this Parameter setting
EXEC cfp_PROCESS_LOG_UPDATE @LogID



EXEC cfp_PROCESS_LOG_INSERT 'Pig Group Rollup', 'cfp_PIG_GROUP_ROLLUP', 'SP', @ProcessLogID = @LogID OUTPUT
EXEC dbo.cfp_PIG_GROUP_ROLLUP
EXEC cfp_PROCESS_LOG_UPDATE @LogID

EXEC cfp_PROCESS_LOG_INSERT 'Pig Group Rollup', 'cfp_PIG_GROUP_ROLLUP_CALCS', 'SP', @ProcessLogID = @LogID OUTPUT
EXEC dbo.cfp_PIG_GROUP_ROLLUP_CALCS
EXEC cfp_PROCESS_LOG_UPDATE @LogID

EXEC cfp_PROCESS_LOG_INSERT 'Pig Group Rollup', 'cfp_PIG_GROUP_SOURCE_FARMS', 'SP', @ProcessLogID = @LogID OUTPUT
EXEC dbo.cfp_PIG_GROUP_SOURCE_FARMS
@LOG = N'N'		-- 201304 sripley, modified proc so that it requires a parm.
EXEC cfp_PROCESS_LOG_UPDATE @LogID

EXEC cfp_PROCESS_LOG_INSERT 'Pig Group Rollup', 'cfp_PIG_GROUP_ROLLUP_PIGFLOWS', 'SP', @ProcessLogID = @LogID OUTPUT
EXEC dbo.cfp_PIG_GROUP_ROLLUP_PIGFLOWS
EXEC cfp_PROCESS_LOG_UPDATE @LogID



EXEC cfp_PROCESS_LOG_INSERT 'Pig Group Census', 'cfp_PIG_GROUP_CENSUS', 'SP', @ProcessLogID = @LogID OUTPUT
EXEC dbo.cfp_PIG_GROUP_CENSUS
EXEC cfp_PROCESS_LOG_UPDATE @LogID

EXEC cfp_PROCESS_LOG_INSERT 'Pig Group Census', 'cfp_PIG_GROUP_CENSUS_PIGFLOWS', 'SP', @ProcessLogID = @LogID OUTPUT
EXEC dbo.cfp_PIG_GROUP_CENSUS_PIGFLOWS
EXEC cfp_PROCESS_LOG_UPDATE @LogID


----------------------------------------------------------
--ENABLE LOG SHIPPING
----------------------------------------------------------
EXEC cfp_PROCESS_LOG_INSERT 'LOG SHIPPING', 'Enable LogShip Copy', 'SP', @ProcessLogID = @LogID OUTPUT
UPDATE MSDB.dbo.sysjobs
SET Enabled = 1
WHERE [Name] LIKE 'Log Shipping copy for EARTH.SolomonApp_logshipping'

EXEC cfp_PROCESS_LOG_UPDATE @LogID

EXEC cfp_PROCESS_LOG_INSERT 'LOG SHIPPING', 'Enable LogShip Restore', 'SP', @ProcessLogID = @LogID OUTPUT
UPDATE MSDB.dbo.sysjobs
SET Enabled = 1
WHERE [Name] LIKE 'Log Shipping Restore for EARTH.SolomonApp_logshipping'

EXEC cfp_PROCESS_LOG_UPDATE @LogID
