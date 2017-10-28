 /****** Object:  Stored Procedure dbo.ap03730_pst    Script Date: 4/7/98 12:54:32 PM ******/
--apptable
CREATE PROC ap03730_pst @RI_ID smallint
AS
        DELETE  FROM ap03730_wrk
        WHERE   RI_ID = @RI_ID


