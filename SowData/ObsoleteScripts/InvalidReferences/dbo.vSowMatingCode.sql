--*************************************************************
--	Purpose:Commercial Farm mating code for farrow events
--   sows farrowing after a mate at an origin farm are 0
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vSowMatingCode
AS

Select f.FarmID, m.FarmID as Source, f.SowID,f.SortCode, f.EventDate,
MatingSortCode=
Case when m.SowID is null or f.SortCode > 4 then
(Select  Max(SortCode) from SowMatingEvent 
where SortCode<f.SortCode and FarmID=f.FarmID and SowID=f.SowID
Group by SowID
)
else
0
end 
 from 
SowFarrowEvent f
JOIN Sow s on f.FarmID=s.FarmID and f.SowID=s.SowID
LEFT JOIN Sow m on s.Origin is not null and s.Origin=m.FarmID and s.SowID=m.SowID 


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowMatingCode] TO [se\analysts]
    AS [dbo];

