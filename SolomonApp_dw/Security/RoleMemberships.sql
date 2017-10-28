ALTER ROLE [db_owner] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\JMaas];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ANALYSTS];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\DB-prodreport-SolomonApp_dw-r];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CorpReports];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ITDevelopers];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_datareader] ADD MEMBER [GiltFlow];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSRS_operator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\ssis_datawriter];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SSIS_Operator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\DB-DevQA-AllDatabases-r];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\scribeservice];


GO
ALTER ROLE [db_datareader] ADD MEMBER [scribeservice];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SE\SQL Report Server Read Access];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ANALYSTS];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\SSRS_Prod];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [GiltFlow];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ssis_datareader];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [SE\ssis_datawriter];

