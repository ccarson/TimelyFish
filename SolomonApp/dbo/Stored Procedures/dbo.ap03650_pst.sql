 /****** Object:  Stored Procedure dbo.ap03650_pst    Script Date: 4/7/98 12:54:32 PM ******/
CREATE PROC ap03650_pst @RI_ID smallint
AS
        DELETE FROM ap03650mc_wrk WHERE RI_ID = @RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ap03650_pst] TO [MSDSL]
    AS [dbo];

