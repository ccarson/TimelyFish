CREATE VIEW vFirstOriginGroupEvent
as 
Select e.FarmID, e.SowID,r.PrimaryReason as DestFarm, Min(e.SortCode) as FirstGroup 
from SowGroupEvent e
JOIN Sow s on e.FarmID=s.FarmID and e.SowID=s.SowID
JOIN SowRemoveEvent r on e.FarmID=r.FarmId and e.SowID=r.SowID and r.RemovalType='TRANSFER'
Group By e.FarmID, e.SowID,r.PrimaryReason



GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vFirstOriginGroupEvent] TO [se\analysts]
    AS [dbo];

