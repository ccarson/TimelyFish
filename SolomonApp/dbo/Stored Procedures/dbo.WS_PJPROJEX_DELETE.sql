CREATE PROCEDURE WS_PJPROJEX_DELETE
@project char(16), @tstamp timestamp
AS
BEGIN
DELETE FROM [PJPROJEX]
WHERE [project] = @project AND 
[tstamp] = @tstamp;
End
