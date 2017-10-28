 /****** Object:  Stored Procedure dbo.ap03681_pst    Script Date: 4/7/98 12:54:32 PM ******/
CREATE PROC ap03681_pst @RI_ID smallint            AS
        DELETE FROM ap03681_wrk WHERE RI_ID = @RI_ID


