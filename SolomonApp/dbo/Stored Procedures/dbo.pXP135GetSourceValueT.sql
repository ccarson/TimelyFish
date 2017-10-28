
/****** Object:  Stored Procedure dbo.pXP135GetSourceValueT    Script Date: 2/17/2006 3:56:11 PM ******/


--*************************************************************
--	Purpose:Retrieve default start value by Pod
--	Author: Sue Matter
--	Date: 12/20/2005
--	Usage: Pig Transport Project Charge 
--	Parms: ProjectID
--*************************************************************
CREATE   PROCEDURE pXP135GetSourceValueT
	@parm1 as varchar(16), @parm2 as smalldatetime
AS
Select pd.* 
from cftSite st
JOIN cftSitePod sp ON st.ContactID=sp.ContactID
JOIN cftPigProdPodTemp pd on sp.PodID=pd.PodID
Where st.SolomonProjectID=@parm1 AND pd.CF05<=@parm2 and pd.CF06>=@parm2







GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135GetSourceValueT] TO [MSDSL]
    AS [dbo];

