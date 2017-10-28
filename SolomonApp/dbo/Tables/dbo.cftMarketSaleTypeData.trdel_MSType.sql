
create TRIGGER [dbo].[trdel_MSType] ON [dbo].[cftMarketSaleTypeData] 
	instead of delete
	AS
	BEGIN TRAN
	SET NOCOUNT ON

	insert into cftDataAudit
	([AuditEvent]      ,[Lupd_DateTime]      ,[Lupd_Prog]      ,[Lupd_User]      ,[OldValue]      ,[NewValue])
	select 'cftMarketSaleTypeData:reject del ', getdate(),substring(program_name,1,50), substring(login_name,1,10), d.description, d.description
	from sys.dm_exec_sessions
	cross join deleted d
	where session_id = @@spid

	RAISERROR ('Changes to Description are not Allowed', 16, 10);

	COMMIT WORK

