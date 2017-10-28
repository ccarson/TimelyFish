----------------------------------------------------------------------------------------
--	Purpose: Select the Non Emergency Loads
--	Author: Sue Matter
--	Date: 7/20/2006
--	Program Usage: XF213
--	Parms: @Site specific site
--	Parms: @parmdate load requested date
--	Parms: @Sort how the user wants to sort the grid
----------------------------------------------------------------------------------------


/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-01-08  Doran Dahle Added Biosecurity protocol
===============================================================================
*/

CREATE  Procedure [dbo].[pXF213FeedCurLoadH]
	@MillID AS varchar(6),
	@parmSite As varchar(6),
	@parmdate smalldatetime,
        @parmbio As varchar(1)


AS

Select fl.*, c.*, fo.*, tr.*, c2.*,0,(mm.OneWayHours*2) As TravelHours, blp.Protocol as Protocol 

From cftFeedLoad fl (nolock)	-- 201303 nolock hint sripley
JOIN cftContact c (nolock) ON fl.ContactID=c.ContactID AND ContactTypeID='04'	-- 201303 nolock hint sripley
JOIN cftFeedOrder fo (nolock) on fl.OrdNbr=fo.OrdNbr	-- 201303 nolock hint sripley
JOIN vCF401Miles mm  ON fo.ContactID=mm.ContactID AND fo.MillId=mm.MillID	
JOIN cftSite st (nolock) ON c.ContactID=st.ContactID	-- 201303 nolock hint sripley
LEFT JOIN cftSiteBio stb (nolock) ON st.ContactID=stb.ContactID and st.SiteID = stb.SiteID
LEFT JOIN cftBioLevelProtocol blp (nolock) ON stb.BioSecurityLevel = blp.BioSecurityLevel and blp.Department like 'Feed' and blp.Type like 'NonContact'
LEFT JOIN cftContact c2 (nolock) ON fl.DriverID=c2.ContactID	-- 201303 nolock hint sripley
LEFT JOIN cftFeedTrDrCab (nolock) tr ON fl.DriverID=tr.DriverID AND fl.TruckID=tr.TruckID AND fl.CabID=tr.CabID	-- 201303 nolock hint sripley
Where fo.CF09=1 AND fl.Rlsed=0 
AND fo.MillId = @MillID
AND fl.LoadNbr IN (Select fl2.LoadNbr 
from cftFeedLoad fl2
JOIN cftFeedOrder p on fl2.OrdNbr=p.OrdNbr AND fl2.DateReq=fl.DateReq AND p.DateReq= fl.DateReq AND p.Priority LIKE '%EMER%')
AND fl.DateReq = @parmdate
AND fl.ContactID LIKE @parmSite
AND st.FeedOrderComments LIKE (CASE @parmbio
	WHEN '1' THEN
	'%Prewash%'
	ELSE
	'%'
	END)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213FeedCurLoadH] TO [MSDSL]
    AS [dbo];

