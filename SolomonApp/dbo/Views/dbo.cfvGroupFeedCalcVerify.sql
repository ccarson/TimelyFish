
/****** Object:  View dbo.cfvGroupFeedCalcVerify    Script Date: 10/27/2005 10:08:01 PM ******/

/****** Object:  View dbo.cfvGroupFeedCalcVerify    Script Date: 10/27/2005 10:02:47 PM ******/

/****** Object:  View dbo.cfvGroupFeedCalcVerify    Script Date: 10/27/2005 8:04:38 PM ******/

/****** Object:  View dbo.cfvGroupFeedCalcVerify    Script Date: 10/27/2005 7:59:44 PM ******/

CREATE     VIEW cfvGroupFeedCalcVerify
As

SELECT fo.ContactID, c.ContactName, fo.PigGroupID, fo.RoomNbr, fo.InvtIdOrd, 
	OrdQtyDel = Sum(fo.QtyDel),
	OrdQtyOpen = Sum(fo.QtyOrd*2000),
        NoOrds = Count(OrdNbr),
	TotalPigs = Sum(fo.PGQty),
	pg.PriorFeedQty,
	fd.AdvToNextStageLbs,
	fd.CummLbsHead 
	FROM cftFeedOrder fo
	JOIN cftContact c ON fo.ContactID = c.ContactID
	JOIN cftPigGroup pg ON fo.PigGroupID = pg.PigGroupID
	JOIN cfvFeedPlanDefDet fd ON fo.PigGroupID=fd.PigGroupID AND fo.InvtIDOrd=fd.InvtID AND fo.RoomNbr=fd.RoomNbr
	Where ISNULL(fo.PiggroupID,'')<>'' AND fo.Status <> 'X'
	GROUP BY fo.ContactID, c.ContactName, fo.PigGroupID, fo.PGQty, fo.InvtIdOrd, fo.RoomNbr, fd.CummLbsHead, fd.AdvToNextStageLbs, pg.PriorFeedQty






