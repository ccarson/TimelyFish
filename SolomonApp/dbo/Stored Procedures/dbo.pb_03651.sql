 --- 9/3/98 - CSS TR#A-001905 Removed EndPer references.  03651 only requests BegPer

--APPTABLE
--USETHISSYNTAX

CREATE PROCEDURE pb_03651 @RI_ID SMALLINT

AS

DECLARE @RI_Where varchar(1024), @Search varchar(1024), @Pos SMALLINT,
	@BegPerNbr VARCHAR(6), @EndPerNbr VARCHAR(6)

SELECT @RI_Where = LTRIM(RTRIM(RI_Where)), @BegPerNbr = BegPerNbr
FROM RptRunTime
WHERE RI_ID = @RI_ID

SELECT @Search = "({vr_03651.Period} = '" + @BegPerNbr + "' AND {vr_03651.cRI_ID} = " + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + ")"

SELECT @Pos = PATINDEX("%" + @Search + "%", @RI_Where)

UPDATE RptRunTime SET RI_Where = CASE
	WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
		THEN @Search
	WHEN @Pos <= 0
		THEN @Search + " AND (" + @RI_WHERE + ")"
END
WHERE RI_ID = @RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pb_03651] TO [MSDSL]
    AS [dbo];

