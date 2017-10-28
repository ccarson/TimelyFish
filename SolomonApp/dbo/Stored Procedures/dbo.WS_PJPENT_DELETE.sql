CREATE PROCEDURE WS_PJPENT_DELETE
@pjt_entity char(32), @project char(16), @tstamp timestamp
AS
BEGIN
DELETE FROM [PJPENT]
WHERE [pjt_entity] = @pjt_entity AND 
[project] = @project AND 
[tstamp] = @tstamp;
END
