CREATE PROCEDURE WS_PJPROJMX_DELETE
@acct char(16), @pjt_entity char(32), @project char(16), @tstamp timestamp
AS
BEGIN
DELETE FROM [PJPROJMX]
WHERE [acct] = @acct AND 
[pjt_entity] = @pjt_entity AND 
[project] = @project AND 
[tstamp] = @tstamp;
END
