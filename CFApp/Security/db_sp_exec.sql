CREATE ROLE [db_sp_exec]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\Earth~CFApp~DataWriter];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [master];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [TransApp];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [CorpReports];

