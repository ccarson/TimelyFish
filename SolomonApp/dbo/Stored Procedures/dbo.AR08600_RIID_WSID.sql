 /****** Object:  Stored Procedure dbo.AR08600_RIID_WSID    Script Date: 4/7/98 12:54:32 PM ******/
--apptable
CREATE PROC AR08600_RIID_WSID @RI_ID smallint
AS
        SELECT * FROM ar08600_wrk WHERE RI_ID = @RI_ID and WSID <> 0


