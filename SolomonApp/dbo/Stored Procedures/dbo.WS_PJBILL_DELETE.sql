CREATE PROCEDURE WS_PJBILL_DELETE
@project char(16), @tstamp timestamp
AS
BEGIN
DELETE FROM [PJBILL]
WHERE [project] = @project AND 
[tstamp] = @tstamp;
END
