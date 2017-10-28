 CREATE	PROCEDURE pb_03030 @RI_ID SMALLINT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

DECLARE	@BatNbr CHAR(10)

SELECT	@BatNbr = SUBSTRING(RI_WHERE, CHARINDEX('''', RI_WHERE) + 1,
                            CASE WHEN CHARINDEX( '''', RI_WHERE, CHARINDEX('''', RI_WHERE) + 1) = 0 THEN 0
				 ELSE CHARINDEX( '''', RI_WHERE, CHARINDEX('''', RI_WHERE) + 1) - 1 - CHARINDEX('''', RI_WHERE)
			    END)
FROM	RptRuntime
WHERE	RI_ID = @RI_ID

UPDATE	RptRuntime SET
	ReportTitle = v.Name
FROM	Batch b INNER JOIN vs_Screen v ON v.Number = RTRIM(b.EditScrnNbr) + '00'
WHERE	b.BatNbr = @BatNbr AND b.Module = 'AP' AND RI_ID = @RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pb_03030] TO [MSDSL]
    AS [dbo];

