 CREATE PROC [dbo].[AP03625_pst]
	@ri_id		smallint
as
		DELETE FROM ap03625_wrk WHERE RI_ID = @RI_ID
