 CREATE PROC [dbo].[PO04740_Pst]
	@ri_id		smallint
as
		delete from PO04740_WRK where ri_id = @ri_id

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PO04740_Pst] TO [MSDSL]
    AS [dbo];

