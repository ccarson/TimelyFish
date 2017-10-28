 CREATE PROC PJWeek_LastBefore
@Date smalldatetime
AS
SELECT *
FROM PJWeek
WHERE WE_Date <= @Date
ORDER BY WE_Date DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWeek_LastBefore] TO [MSDSL]
    AS [dbo];

