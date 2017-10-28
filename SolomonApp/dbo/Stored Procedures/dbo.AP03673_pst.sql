 CREATE PROC [dbo].[AP03673_pst]
	@ri_id		smallint
as
       DELETE FROM AP03673_Wrk WHERE RI_ID = @RI_ID	
