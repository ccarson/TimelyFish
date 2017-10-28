
CREATE PROCEDURE QVProperties_DELETE
@tstamp timestamp
AS
BEGIN
DELETE FROM [vs_qvproperties]
WHERE [tstamp] = @tstamp;
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[QVProperties_DELETE] TO [MSDSL]
    AS [dbo];

