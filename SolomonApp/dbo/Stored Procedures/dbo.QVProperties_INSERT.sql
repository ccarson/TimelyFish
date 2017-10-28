
CREATE PROCEDURE QVProperties_INSERT
@QueryViewName char(50),
@QueryViewColumnName char(60),
@AliasColumnName char(60)
AS
BEGIN
INSERT INTO [vs_qvproperties]
([QueryViewName],
[QueryViewColumnName],
[AliasColumnName])
VALUES
(@QueryViewName,
@QueryViewColumnName,
@AliasColumnName);
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[QVProperties_INSERT] TO [MSDSL]
    AS [dbo];

