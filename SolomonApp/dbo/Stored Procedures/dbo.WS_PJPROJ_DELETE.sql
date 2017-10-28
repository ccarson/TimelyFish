CREATE PROCEDURE WS_PJPROJ_DELETE
@project char(16), @tstamp timestamp
AS
BEGIN
DELETE FROM [PJPROJ]
WHERE [project] = @project AND 
[tstamp] = @tstamp;
End
