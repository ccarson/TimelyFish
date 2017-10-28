
/****** Object:  View dbo.cfv_GroupFeed    Script Date: 12/2/2005 7:41:07 AM ******/

/****** Object:  View dbo.cfv_GroupFeed    Script Date: 5/17/2005 1:44:36 PM ******/

/****** Object:  View dbo.cfv_GroupFeed    Script Date: 3/25/2005 11:36:29 AM ******/
/****** Sue Matter:  Used on Actice Site Report    Script Date: 10/6/2004 2:04:49 PM ******/
CREATE View cfv_GroupFeed
AS
Select pg.ProjectID,
       pg.TaskID,
       sum (fo.QtyDel) AS TotalFeed,
       min(fo.DateDel) As FirstOrder,
       max(fo.DateDel) As LastOrder,
       rt.LastRation
  From cftPigGroup pg WITH (NOLOCK)
  JOIN cftFeedOrder fo WITH (NOLOCK) ON pg.PigGroupID=fo.PigGroupID
  LEFT JOIN cfv_GroupRation rt WITH (NOLOCK) ON pg.PigGroupID=rt.PigGroupID
  Where fo.QtyDel>0
  Group by pg.ProjectID, pg.TaskID, rt.LastRation



 

 
