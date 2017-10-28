 /****** Object:  Stored Procedure dbo.BUSetup_All    Script Date: 11/4/99 12:38:58 PM ******/
CREATE PROCEDURE BUSetup_All
@Parm1 varchar ( 10) AS
SELECT * FROM BUSetup WHERE CpnyID Like @Parm1
ORDER BY CpnyID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[BUSetup_All] TO [MSDSL]
    AS [dbo];

