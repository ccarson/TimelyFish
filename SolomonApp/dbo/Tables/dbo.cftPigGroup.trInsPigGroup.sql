



create TRIGGER [dbo].[trInsPigGroup] ON [dbo].[cftPigGroup] 
FOR insert
AS
BEGIN TRAN
SET NOCOUNT ON

if (select count(1) from cftpiggroup where piggroupid = '') > 0
begin
insert into cftDataAudit
([AuditEvent]      ,[Lupd_DateTime]      ,[Lupd_Prog]      ,[Lupd_User]      ,[OldValue]      ,[NewValue])
select 'cftpiggroup:  Blank insrted', getdate(),substring(program_name,1,50), substring(login_name,1,10), I.piggroupid, ''
from sys.dm_exec_sessions
cross join inserted I
where session_id = @@spid

delete 
FROM [SolomonApp].[dbo].cftpiggroup_deltlog 
where [PigGroupID] = ''

delete 
FROM [SolomonApp].[dbo].[cftPigGroup] 
where [PigGroupID] = ''

RAISERROR ('Insert removed, piggroupid was blank', 16, 10);

end

COMMIT WORK



