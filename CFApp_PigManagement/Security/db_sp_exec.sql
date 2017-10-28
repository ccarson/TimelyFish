CREATE ROLE [db_sp_exec]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\PigMgmtAppReports];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [07718158D19D4f5f9D23B55DBF5DF1];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [transapp];

