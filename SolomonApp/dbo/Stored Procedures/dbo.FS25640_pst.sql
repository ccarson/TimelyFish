 CREATE PROC [dbo].[FS25640_pst]
	@ri_id		smallint
as
		delete from WrkDefExpt where ri_id = @ri_id

GO
GRANT CONTROL
    ON OBJECT::[dbo].[FS25640_pst] TO [MSDSL]
    AS [dbo];

