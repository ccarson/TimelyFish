

/****** Sue Matter:  Used on Actice Site Report    Script Date: 10/6/2004 2:04:49 PM ******/
-- 2012-07-11 smr added (nolock) to tables 
CREATE  View [dbo].[cfv_GroupRation]
AS
Select f.PigGroupID, Max(f.InvtIdDel) As LastRation from cftFeedOrder f (nolock)
JOIN 
(Select PigGroupID, Max(DateDel)As maxdelivery
From cftFeedOrder (nolock) Where QtyDel>0 AND Status<>'X' Group by PigGroupID) maxdelord 
ON f.PigGroupID=maxdelord.PigGroupID AND f.DateDel=maxdelord.maxdelivery 
Where f.QtyDel>0 AND f.PigGroupID>' '
Group by f.PigGroupID



 
