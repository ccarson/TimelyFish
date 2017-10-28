CREATE ROLE [db_sp_exec]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [CornPurchApp];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\PigMgmtAppReports];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SSIS_CornPurch];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [CorpReports];

