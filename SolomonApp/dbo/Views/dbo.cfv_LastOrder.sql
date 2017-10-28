/****** Object:  View dbo.cfv_LastOrder    Script Date: 12/8/2004 8:27:32 PM ******/

CREATE     View cfv_LastOrder
as
Select pg.ProjectID,
       pg.TaskID,
       Max (fo.DateDel) AS LastFeed
  From cftPigGroup pg
  Left JOIN cftFeedOrder fo ON pg.PigGroupID=fo.PigGroupID
  Group by pg.ProjectID, pg.TaskID



 

 