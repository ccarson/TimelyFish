ALTER ROLE [db_owner] ADD MEMBER [SE\SQLRepl];


GO
ALTER ROLE [db_securityadmin] ADD MEMBER [se\ITAdmins];


GO
ALTER ROLE [db_backupoperator] ADD MEMBER [se\ITAdmins];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\Earth~CFApp~DataWriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\Earth~CFApp~DataReader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SQLSvc2];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [master];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [TransApp];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\Earth~CFApp~DataWriter];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [TransApp];

