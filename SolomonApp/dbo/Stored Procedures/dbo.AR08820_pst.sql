 CREATE PROC [dbo].[AR08820_pst]
	@ri_id		smallint
as
        DELETE FROM AR08820_wrk WHERE RI_ID = @RI_ID

