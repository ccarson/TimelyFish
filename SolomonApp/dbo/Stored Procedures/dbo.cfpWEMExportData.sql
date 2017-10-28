
CREATE  Procedure cfpWEMExportData
AS

----------------------------------------------------------------------------------------
--	Purpose: Export data to WEM Database 
--	Author: Sue Matter
--	Date: 8/11/2006
--	Program Usage: 
--	Parms: 
----------------------------------------------------------------------------------------


DECLARE @FileName varchar(50),
        @bcpCommand varchar(2000)

/********** This will create the Grower file *******/

--SET @FileName = REPLACE('\\FILESTORE2\Apps\Solomon\FeedWEM\DataFiles\grower.txt','/','-')
--SET @FileName = REPLACE('\\10.10.12.74\WEM\WEMSpeak\data_io\SueTemp\grower.txt','/','-')
SET @FileName = REPLACE('W:\SueTemp\grower_towem.csv','/','-')

SET @bcpCommand = 'bcp "exec SolomonApp..pXF211GrowerExport" queryout "' 
SET @bcpCommand = @bcpCommand + @FileName + '" -Usa -PMsSQ!2k /c /t,'


EXEC master..xp_cmdshell @bcpCommand


--SET @FileName = REPLACE('\\10.10.12.74\WEM\WEMSpeak\data_io\SueTemp\truck.txt','/','-')
SET @FileName = REPLACE('W:\SueTemp\vehicle_towem.csv','/','-')

SET @bcpCommand = 'bcp "exec SolomonApp..pXF211VehicleExport" queryout "' 
SET @bcpCommand = @bcpCommand + @FileName + '" -Usa -PMsSQ!2k /c /t,'


EXEC master..xp_cmdshell @bcpCommand


--SET @FileName = REPLACE('\\10.10.12.74\WEM\WEMSpeak\data_io\SueTemp\driver.txt','/','-')
SET @FileName = REPLACE('W:\SueTemp\drivers_towem.csv','/','-')

SET @bcpCommand = 'bcp "exec SolomonApp..pXF211DriverExport" queryout "' 
SET @bcpCommand = @bcpCommand + @FileName + '" -Usa -PMsSQ!2k /c /t,'


EXEC master..xp_cmdshell @bcpCommand




