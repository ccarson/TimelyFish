

----------------------------------------------------------------------------------------
--	Purpose: Select the Emergency Loads
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

CREATE   Procedure [dbo].[pXF213FeedCurLoad]
	@MillID AS varchar(6), @Site As varchar(6), @parmdate smalldatetime, @Sort As varchar(1), @parmbio As varchar(1)

AS
Select fl.*, c.*, fo.*, tr.*, c2.*,cmt.*,(mm.OneWayHours*2) As TravelHours, blp.Protocol as Protocol 
From cftFeedLoad fl (Nolock)   -- 20120920 sripley added Nolock hint to eliminate deadlock events
JOIN cftContact c (Nolock)   -- 20120920 sripley added Nolock hint to eliminate deadlock events
ON fl.ContactID=c.ContactID AND ContactTypeID='04'
JOIN cftFeedOrder fo (Nolock)   -- 20120920 sripley added Nolock hint to eliminate deadlock events
on fl.OrdNbr=fo.OrdNbr
JOIN cftSite st (Nolock)   -- 20120920 sripley added Nolock hint to eliminate deadlock events
ON c.ContactID=st.ContactID
LEFT JOIN cftSiteBio stb (nolock) ON st.ContactID=stb.ContactID and st.SiteID = stb.SiteID
LEFT JOIN cftBioLevelProtocol blp (nolock) ON stb.BioSecurityLevel = blp.BioSecurityLevel and blp.Department like 'Feed' and blp.Type like 'NonContact'
LEFT JOIN cftComments cmt (Nolock)   -- 20120920 sripley added Nolock hint to eliminate deadlock events
ON fo.CommentId=cmt.CommentId
LEFT JOIN vCF401Miles mm (Nolock)   -- 20120920 sripley added Nolock hint to eliminate deadlock events
ON fo.ContactID=mm.ContactID AND fo.MillId=mm.MillID
LEFT JOIN cftContact c2 (Nolock)   -- 20120920 sripley added Nolock hint to eliminate deadlock events
ON fl.DriverID=c2.ContactID
LEFT JOIN cftFeedTrDrCab tr (Nolock)   -- 20120920 sripley added Nolock hint to eliminate deadlock events
ON fl.DriverID=tr.DriverID AND fl.TruckID=tr.TruckID AND fl.CabID=tr.CabID
Where fo.CF09=1 AND fl.Rlsed=0
AND fo.MillId = @MillID
AND fl.ContactID LIKE @Site
AND fl.LoadNbr NOT IN (Select fl2.LoadNbr 
from cftFeedLoad fl2 (Nolock)   -- 20120927 sripley added Nolock hint to eliminate deadlock events
JOIN cftFeedOrder p (Nolock)   -- 20120927 sripley added Nolock hint to eliminate deadlock events
on fl2.OrdNbr=p.OrdNbr AND p.DateReq= fl.DateReq AND p.Priority LIKE '%EMER%')
AND fl.DateReq = @parmdate
AND st.FeedOrderComments LIKE (CASE @parmbio
	WHEN '1' THEN
	'%Prewash%'
	ELSE
	'%'
	END)
Order by 
CASE WHEN @Sort='M' THEN CAST(mm.OneWayHours AS Char) END ASC,
CASE WHEN @Sort='I' THEN fl.InvtID END ASC,
CASE WHEN @Sort='D' THEN CAST(mm.OneWayHours As Char) END DESC,
CASE WHEN @Sort='S' THEN c.ContactName END ASC,
CASE WHEN @Sort='L' THEN fl.LoadNbr END ASC,
CASE WHEN @Sort='B' THEN blp.Protocol END ASC,
CASE WHEN @Sort='O' THEN fo.OrdType END ASC,
CASE WHEN @Sort='F' THEN fo.InvtIdOrd END ASC





GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213FeedCurLoad] TO [MSDSL]
    AS [dbo];

