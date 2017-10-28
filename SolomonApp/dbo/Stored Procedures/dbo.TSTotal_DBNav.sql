 CREATE PROC TSTotal_DBNav
@ETid   varchar (10)
AS
SELECT TSTotal.*, EarnType.*
FROM TSTotal
     LEFT OUTER JOIN EarnType
         ON TSTotal.ETid=EarnType.id
WHERE TSTotal.ETid LIKE @ETid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TSTotal_DBNav] TO [MSDSL]
    AS [dbo];

