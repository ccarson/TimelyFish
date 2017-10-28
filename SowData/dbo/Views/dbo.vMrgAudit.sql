CREATE VIEW [dbo].[vMrgAudit]
AS

SELECT     dbo.MrgAudit.*, dbo.FarmSetup.AssignedRepUserName AS RepName
FROM         dbo.MrgAudit INNER JOIN
                      dbo.FarmSetup ON dbo.MrgAudit.FarmID = dbo.FarmSetup.FarmID

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vMrgAudit] TO [se\analysts]
    AS [dbo];

