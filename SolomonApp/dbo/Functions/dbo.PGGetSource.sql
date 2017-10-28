GRANT EXECUTE
    ON OBJECT::[dbo].[PGGetSource] TO [SE\Analysts]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[PGGetSource] TO [SE\ssis_datareader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[PGGetSource] TO [SE\ssis_datawriter]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PGGetSource] TO [MSDSL]
    AS [dbo];

