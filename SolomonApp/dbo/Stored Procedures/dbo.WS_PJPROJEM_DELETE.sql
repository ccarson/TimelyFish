CREATE PROCEDURE WS_PJPROJEM_DELETE
@employee char(10), @project char(16), @tstamp timestamp
AS
BEGIN
DELETE FROM [PJPROJEM]
WHERE [employee] = @employee AND 
[project] = @project AND 
[tstamp] = @tstamp;
END
