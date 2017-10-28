 CREATE PROC [dbo].[CA20720_Pst]
	@ri_id		smallint
as
		delete from WrkCADetail where ri_id = @ri_id

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA20720_Pst] TO [MSDSL]
    AS [dbo];

