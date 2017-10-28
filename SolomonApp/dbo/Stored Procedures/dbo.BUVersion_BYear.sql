 /****** Object:  Stored Procedure dbo.BUVersion_BYear    Script Date: 10/23/98 12:38:58 PM ******/
CREATE PROCEDURE BUVersion_BYear
@Parm1 varchar ( 10), @Parm2 varchar ( 4), @Parm3 varchar ( 10) AS
SELECT * FROM Budget_Version WHERE CpnyId LIKE @parm1 And budgetyear = @Parm2 And budgetledgerid LIKE @Parm3 ORDER BY budgetyear, budgetledgerid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BUVersion_BYear] TO [MSDSL]
    AS [dbo];

