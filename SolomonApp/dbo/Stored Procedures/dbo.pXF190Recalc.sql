
/****** Object:  Stored Procedure dbo.pXF190Recalc    Script Date: 11/7/2005 4:18:45 PM ******/

/****** Object:  Stored Procedure dbo.pXF190Recalc    Script Date: 11/4/2005 10:42:47 AM ******/


CREATE      Procedure pXF190Recalc
	 @parmord varchar(10)
As
Select fo.*, bn.*, pg.*, rm.*
From cftFeedOrder fo
JOIN cftOrderType tp ON fo.OrdType=tp.OrdType
JOIN cfvBin bn ON fo.ContactID=bn.ContactID AND fo.BarnNbr=bn.BarnNbr ANd fo.BinNbr=bn.BinNbr
JOIN cftPigGroup pg ON fo.ContactID=pg.SiteContactID AND fo.PigGroupID=pg.PigGroupID
LEFT JOIN cftPigGroupRoom rm ON fo.PigGroupID=rm.PigGroupID AND fo.RoomNbr=rm.RoomNbr
Where ISNULL(fo.PigGroupID,'')<>'' AND fo.CF07=1 AND fo.Status<>'C' AND fo.Status<>'X' 
AND fo.PrtFlg=0 AND tp.User6<>1
AND fo.OrdNbr Like @parmord 
Order by fo.ContactID, fo.PigGroupID, fo.RoomNbr, fo.DateSched, fo.OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF190Recalc] TO [MSDSL]
    AS [dbo];

