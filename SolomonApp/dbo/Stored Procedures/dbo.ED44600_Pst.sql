 CREATE PROC [dbo].[ED44600_Pst]
	@ri_id		smallint
as
		delete from EDPORcvdWrk where ri_id = @ri_id

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED44600_Pst] TO [MSDSL]
    AS [dbo];

