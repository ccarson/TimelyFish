
CREATE PROCEDURE dbo.pAdd0toSource
AS UPDATE    dbo.Sheet2
SET              Source = '0' + Source
WHERE     (LEN(Source) < 4)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pAdd0toSource] TO [MSDSL]
    AS [dbo];

