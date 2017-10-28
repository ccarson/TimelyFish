
CREATE PROCEDURE [dbo].[pXP135GetSourceValue]
      @parm1 as varchar(16)
AS
Select top 1 pd.* 
-- 20120927 sripley  added nolock hints to remove blocking
from cftSite st (nolock) 
JOIN cftSitePod sp (nolock)  ON st.ContactID=sp.ContactID
JOIN cftPigProdPod pd (nolock)  on sp.PodID=pd.PodID
Where st.SolomonProjectID=@parm1
order by sp.[EffectiveDate] desc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135GetSourceValue] TO [MSDSL]
    AS [dbo];

