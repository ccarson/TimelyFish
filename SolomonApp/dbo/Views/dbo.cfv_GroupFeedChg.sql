
/****** Object:  View dbo.cfv_GroupFeedChg    Script Date: 12/2/2005 7:39:28 AM ******/

/****** Object:  View dbo.cfv_GroupFeedChg    Script Date: 5/17/2005 2:00:57 PM ******/

/****** Object:  View dbo.cfv_GroupFeedChg    Script Date: 5/17/2005 1:40:15 PM ******/

/****** Sue Matter:  Used on Group Close Report    Script Date: 3/7/2005 ******/
CREATE    View cfv_GroupFeedChg
AS
Select pg.Project,
       pg.pjt_entity AS TaskID,
       act_amount AS FeedCost,
       act_units As TotalFeed
  From pjptdsum pg WITH (NOLOCK)
  Where pg.acct='PIG FEED ISSUE'
 -- Group by pg.Project, pg.pjt_entity




