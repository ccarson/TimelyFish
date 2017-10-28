
create TRIGGER [dbo].[trins_MSType] ON [dbo].[cftMarketSaleTypeData] 
	instead of insert
	AS
	BEGIN TRAN
	SET NOCOUNT ON

	insert into cftDataAudit
	([AuditEvent]      ,[Lupd_DateTime]      ,[Lupd_Prog]      ,[Lupd_User]      ,[OldValue]      ,[NewValue])
	select 'cftMarketSaleTypeData:reject ins ', getdate(),substring(program_name,1,50), substring(login_name,1,10), i.description, i.description
	from sys.dm_exec_sessions
	cross join inserted  i
	where session_id = @@spid

	RAISERROR ('Changes to Description are not Allowed', 16, 10);

	COMMIT WORK

