CREATE ROLE [db_sp_exec]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SQLEssbaseSproc];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\DB-prod-PigChampCare-r];

