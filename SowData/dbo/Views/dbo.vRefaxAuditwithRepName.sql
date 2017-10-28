CREATE VIEW [dbo].[vRefaxAuditwithRepName]
AS
SELECT ra.*, fs.AssignedRepUserName 
from dbo.RefaxAudit ra
JOIN dbo.FarmSetup fs ON ra.FarmID=fs.FarmID

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vRefaxAuditwithRepName] TO [se\analysts]
    AS [dbo];

