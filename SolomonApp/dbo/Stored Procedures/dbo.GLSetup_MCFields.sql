 /****** Object:  Stored Procedure dbo.GLSetup_MCFields    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROC GLSetup_MCFields AS
SELECT Central_Cash_Cntl, CpnyId, CpnyName, MCActive, Mult_Cpny_Db FROM GLSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLSetup_MCFields] TO [MSDSL]
    AS [dbo];

