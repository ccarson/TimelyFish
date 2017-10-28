 --APPTABLE
--USETHISSYNTAX

CREATE PROCEDURE pb_03680 @RI_ID SMALLINT

AS

DECLARE @RI_Where varchar(1024), @Search varchar(1024), @Pos SMALLINT,
	@BegPerNbr VARCHAR(6), @EndPerNbr VARCHAR(6), @ViewName varchar(30)

SELECT @RI_Where = LTRIM(RTRIM(RI_Where)), @BegPerNbr = BegPerNbr, @EndPerNbr = EndPerNbr,
       @ViewName=Replace(Replace(ReportName,'UMC','DU'),'MC','') --translate the report name into corresponding view name
FROM RptRunTime
WHERE RI_ID = @RI_ID

SELECT @Search = "({vr_" + Rtrim(@ViewName) +".RI_ID} = " + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + 
                  " AND {vr_" + Rtrim(@ViewName) +".cRI_ID} = " + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + ")"

SELECT @Pos = PATINDEX("%" + @Search + "%", @RI_Where)

UPDATE RptRunTime SET RI_Where = CASE
	WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
		THEN @Search
	WHEN @Pos <= 0
		THEN @Search + " AND (" + @RI_WHERE + ")"
END
WHERE RI_ID = @RI_ID


