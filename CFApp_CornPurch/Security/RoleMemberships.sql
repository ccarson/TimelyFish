ALTER ROLE [db_owner] ADD MEMBER [SE\SQLRepl];


GO
ALTER ROLE [db_securityadmin] ADD MEMBER [se\ITAdmins];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_backupoperator] ADD MEMBER [se\ITAdmins];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\Analysts];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CornPurchApp];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\sqlreportsaturntest];


GO
ALTER ROLE [db_datareader] ADD MEMBER [master];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\Earth~CFApp_CornPurch~DataReader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [07718158D19D4f5f9D23B55DBF5DF1];


GO
ALTER ROLE [db_datareader] ADD MEMBER [ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_CornPurch];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [master];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [07718158D19D4f5f9D23B55DBF5DF1];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [ssis_datawriter];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SSIS_CornPurch];

