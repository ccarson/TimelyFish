 --USETHISSYNTAX

CREATE PROCEDURE pb_08751 @RI_ID SMALLINT

AS

DECLARE @RI_Where varchar(1024), @Search varchar(1024), @Pos SMALLINT,
	@BegPerNbr VARCHAR(6), @EndPerNbr VARCHAR(6), @ReportName VARCHAR(10)

SELECT @RI_Where = LTRIM(RTRIM(RI_Where)), @BegPerNbr = BegPerNbr, @EndPerNbr = EndPerNbr, @ReportName = ReportName
FROM RptRunTime
WHERE RI_ID = @RI_ID

SELECT @Search = "(rptcompany.RI_ID = " + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + ")"
IF @ReportName = '08751c'
BEGIN
 Select @Search = @Search  + " AND (PerClosed >= " + @BegPerNbr + " AND PerClosed <= " + @EndPerNbr + ")"
END
ELSE IF @ReportName = '08751i'
BEGIN
	Select @Search = @Search  + " AND (PerPost >= " + @BegPerNbr + " AND PerPost <= " + @EndPerNbr + ")"
END
ELSE
BEGIN
	Select @Search = @Search  + " AND (PerAppl >= " + @BegPerNbr + " AND PerAppl <= " + @EndPerNbr + ")"
END

SELECT @Pos = PATINDEX("%" + @Search + "%", @RI_Where)

UPDATE RptRunTime SET RI_Where = CASE
	WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
		THEN @Search
	WHEN @Pos <= 0
		THEN @Search + " AND (" + @RI_WHERE + ")"
END
WHERE RI_ID = @RI_ID


