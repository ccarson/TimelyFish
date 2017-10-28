
CREATE  TRIGGER [dbo].[trUpd_MSType] ON [dbo].[cftMarketSaleTypeData] 
	FOR UPDATE
	AS
	BEGIN TRAN
	SET NOCOUNT ON

	insert into cftDataAudit
	([AuditEvent]      ,[Lupd_DateTime]      ,[Lupd_Prog]      ,[Lupd_User]      ,[OldValue]      ,[NewValue])
	select 'cftMarketSaleTypeData:reject chg ', getdate(),substring(program_name,1,50), substring(login_name,1,10), d.description, i.description
	from sys.dm_exec_sessions
	cross join inserted  i
	cross join deleted d
	where session_id = @@spid

	if update(description)
		begin
			update [dbo].[cftMarketSaleTypeData]
			set description = d.description
			from inserted i
			join deleted d on d.marketsaletypeid = i.marketsaletypeid
			
			RAISERROR ('Changes to Description are not Allowed', 16, 10);
		end

	COMMIT WORK

