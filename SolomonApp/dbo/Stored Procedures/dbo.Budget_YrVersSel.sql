 /****** Object:  Stored Procedure dbo.Budget_YrVersSel    Script Date: 10/23/98 12:38:58 PM ******/
CREATE PROCEDURE Budget_YrVersSel
@Parm1 varchar ( 10), @Parm2 varchar ( 4), @Parm3 varchar ( 10), @Parm4 varchar ( 24) AS
SELECT * FROM Budget WHERE CpnyID = @Parm1 AND BudgetYear = @Parm2 AND budgetledgerid = @Parm3 AND bdgtsegment LIKE @Parm4 ORDER BY budgetyear, budgetledgerid, bdgtsegment



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Budget_YrVersSel] TO [MSDSL]
    AS [dbo];

