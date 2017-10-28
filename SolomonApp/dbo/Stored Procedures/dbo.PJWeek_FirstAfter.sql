 CREATE PROC PJWeek_FirstAfter
@Date smalldatetime
AS
SELECT *
FROM PJWeek
WHERE WE_Date >= @Date
ORDER BY WE_Date ASC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWeek_FirstAfter] TO [MSDSL]
    AS [dbo];

