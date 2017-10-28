 CREATE PROC [dbo].[AR08690_pst]
	@ri_id		smallint
as
        DELETE FROM AR08690_Wrk WHERE RI_ID = @RI_ID

