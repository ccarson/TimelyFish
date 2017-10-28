CREATE PROCEDURE dbo.pUpdateDelete
AS UPDATE    dbo.View5
SET              SourceSiteID = 'DEL'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateDelete] TO [MSDSL]
    AS [dbo];

