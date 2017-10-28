 CREATE PROCEDURE BR_BRImportSetup_All @parm1 varchar (10)
AS
SELECT *
FROM BRImportSetup where CpnyID like @parm1
ORDER BY CpnyID


