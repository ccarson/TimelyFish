CREATE Procedure pXFWEMFileCreation
AS

DECLARE @FileName varchar(50),
        @bcpCommand varchar(2000)

/********** This will create the file used for Feed Export to WEM *******/
SET @FileName = REPLACE('\\FILESTORE2\FeedWEM\FeedExport.dat','/','-')


SET @bcpCommand = 'bcp "exec SolomonApp..pXFWEMFile" queryout "' 
SET @bcpCommand = @bcpCommand + @FileName + '" -Usa -PMsSQ!2k /c /t,'


EXEC master..xp_cmdshell @bcpCommand


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXFWEMFileCreation] TO [MSDSL]
    AS [dbo];

