 /****** Object:  Stored Procedure dbo.Budget_Year_All    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE Budget_Year_All
@Parm1 varchar ( 4) AS
SELECT * FROM budget_year WHERE budgetyear LIKE @Parm1 ORDER BY BudgetYear



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Budget_Year_All] TO [MSDSL]
    AS [dbo];

