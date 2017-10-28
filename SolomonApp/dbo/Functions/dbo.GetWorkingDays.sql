

CREATE FUNCTION [dbo].[GetWorkingDays] (@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS


    BEGIN

	RETURN (SELECT
              --Start with total number of days including weekends
                (DATEDIFF(dd,@StartDate,@EndDate)+1)

              --Subtact 2 days for each full weekend
               -(DATEDIFF(wk,@StartDate,@EndDate)*2)

              --If StartDate is a Sunday, Subtract 1
               -(CASE WHEN DATENAME(dw,@StartDate) = 'Sunday'
                      THEN 1
                      ELSE 0
                  END)

              --If EndDate is a Saturday, Subtract 1
               -(CASE WHEN DATENAME(dw,@EndDate) = 'Saturday'
                      THEN 1
                      ELSE 0
                  END)
		)

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingDays] TO PUBLIC
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetWorkingDays] TO [MSDSL]
    AS [dbo];

