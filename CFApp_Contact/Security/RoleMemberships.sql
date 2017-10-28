ALTER ROLE [db_datareader] ADD MEMBER [CornPurchApp];


GO
ALTER ROLE [db_securityadmin] ADD MEMBER [se\ITAdmins];


GO
ALTER ROLE [db_backupoperator] ADD MEMBER [se\ITAdmins];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\PigMgmtAppReports];


GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [SE\PigMgmtAppReports];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\Analysts];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\Earth~CFApp_Contact~DataReader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\DB-CFApp_Contact-DataReader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_CornPurch];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SSIS_CornPurch];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_owner] ADD MEMBER [SE\SQLRepl];

