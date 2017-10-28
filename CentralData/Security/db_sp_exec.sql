CREATE ROLE [db_sp_exec]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [db_sp_exec] ADD MEMBER [CorpReports];

