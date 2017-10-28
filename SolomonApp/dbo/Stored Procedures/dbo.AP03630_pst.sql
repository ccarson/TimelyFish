 CREATE PROC [dbo].[AP03630_pst]
	@ri_id		smallint
as
	DELETE FROM ap03630mc_wrk WHERE RI_ID = @RI_ID
