CREATE View vSowGroupEventTempNext
AS
Select *, 
NextGroup=Isnull((Select Top 1 SortCode from SowGroupEventTemp Where SortCode>g.SortCode and SowID=g.SowID and FarmID=g.FarmID
 order by SortCode ASC),999)
 from SowGroupEventTemp g

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowGroupEventTempNext] TO [se\analysts]
    AS [dbo];

