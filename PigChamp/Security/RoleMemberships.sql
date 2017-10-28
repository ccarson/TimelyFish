ALTER ROLE [db_owner] ADD MEMBER [care];


GO
ALTER ROLE [db_owner] ADD MEMBER [SE\SQLRepl];


GO
ALTER ROLE [db_backupoperator] ADD MEMBER [care];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_Operator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\Earth~PigChamp~DataReader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SQLReader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\DB-prod-PigChampCare-r];


GO
ALTER ROLE [db_datareader] ADD MEMBER [TimApp];


GO
ALTER ROLE [db_datareader] ADD MEMBER [ApplicationCenter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\teleformservice];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\HealthAssurance];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SSIS_Operator];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\HealthAssurance];

