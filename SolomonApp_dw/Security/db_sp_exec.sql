CREATE ROLE [db_sp_exec]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ANALYSTS];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\DB-prodreport-SolomonApp_dw-r];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [GiltFlow];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SSRS_operator];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SSIS_Operator];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\DB-DevQA-AllDatabases-r];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\SQL Report Server Read Access];

