
/****** Object:  Stored Procedure dbo.pXF120RoadRest    Script Date: 3/6/2006 4:30:36 PM ******/

----------------------------------------------------------------------------------------
--	Purpose: Check for Road Restrictions 
--	Author: Sue Matter
--	Date: 2/28/2006
--	Program Usage: XF120
--	Parms: Site ContactID
----------------------------------------------------------------------------------------
CREATE    PROCEDURE [dbo].[pXF120RoadRest] 
	@parm1 varchar(6)
	AS 
    	SELECT RoadRestr=(Select RoadRestr from cftFOSetup (NOLOCK)), st.RoadRestrictionTons
	From cftSite st WITH (NOLOCK)
	Where st.ContactID = @parm1 AND st.RoadRestrictionTons>0



