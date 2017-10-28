CREATE ROLE [db_sp_exec]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\sqlsvcsaturn];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\Earth~CFApp_Feed~DataReader];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [CorpReports];

