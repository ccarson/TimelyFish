Create proc pXF150LastFeedOrder (@RefDate as smalldatetime)
as 
Select Distinct pgr.RoomNbr,fo.DateSched,pg.* from cftPigGroup pg
LEFT JOIN cftPigGroupRoom pgr on pg.PigGroupID=pgr.PigGroupID  join 
(Select PigGroupID,Max(DateSched) as DateSched from cftFeedOrder 
where DateSched>'10/25/2004'
group by PigGroupID) fo 
on pg.PigGroupID=fo.PigGroupID where pg.PGStatusID='A' 
and fo.DateSched<@RefDate 
Order by fo.DateSched

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF150LastFeedOrder] TO [MSDSL]
    AS [dbo];

