 /****** Object:  Stored Procedure dbo.BUDistType_All    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE BUDistType_All
@Parm1 varchar ( 8) AS
SELECT * FROM Budget_Dist_Type WHERE DistType LIKE @Parm1 ORDER BY DistType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BUDistType_All] TO [MSDSL]
    AS [dbo];

