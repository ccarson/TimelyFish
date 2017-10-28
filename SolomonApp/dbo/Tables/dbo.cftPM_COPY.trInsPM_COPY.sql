CREATE TRIGGER trInsPM_COPY ON dbo.cftPM_COPY 
FOR INSERT
AS
Set nocount on
BEGIN TRAN


Update cftPM_COPY
set PMID=replicate('0',6-len(rtrim(convert(char(6),d.ID))))
	 + rtrim(convert(char(6),d.ID)),
PMLoadID=replicate('0',6-len(rtrim(convert(char(6),d.ID))))
	 + rtrim(convert(char(6),d.ID))
FROM cftPM_COPY a
JOIN Inserted d on 
a.ID=d.ID

COMMIT TRAN

set nocount off
