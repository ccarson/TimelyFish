ALTER ROLE [db_owner] ADD MEMBER [SE\SMatter];


GO
ALTER ROLE [db_owner] ADD MEMBER [SE\SQLSvcEarthNew];


GO
ALTER ROLE [db_owner] ADD MEMBER [SE\sqlagtsvcearthnew];


GO
ALTER ROLE [db_securityadmin] ADD MEMBER [se\ITAdmins];


GO
ALTER ROLE [db_backupoperator] ADD MEMBER [se\ITAdmins];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_CornPurch];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\scribeservice];


GO
ALTER ROLE [db_datareader] ADD MEMBER [innovationmanager];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SSIS_operator];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SSIS_CornPurch];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\scribeservice];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [innovationmanager];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ITDevelopers];

