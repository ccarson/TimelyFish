
CREATE PROCEDURE QVCatalog_DELETE
@QueryViewName char(50),
@tstamp timestamp
AS
BEGIN
DELETE FROM [vs_qvcatalog]
WHERE [QueryViewName] = @QueryViewName AND 
[tstamp] = @tstamp;
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[QVCatalog_DELETE] TO [MSDSL]
    AS [dbo];

