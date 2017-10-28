CREATE PROCEDURE CF345p_cftFeedOrder_Hold @parm1 varchar (10), @parm2 varchar (6), @parm3 smalldatetime as 

       UPDATE cftFeedOrder  SET cftFeedOrder.user6 = @parm1, cftFeedOrder.user5 = 'Hold', cftFeedOrder.prtflg = '2'

	FROM cftFeedOrder f
     	JOIN cftOrderStatus s ON f.Status = s.Status
  	JOIN cftOrderType t ON f.OrdType = t.OrdType
        LEFT JOIN cftPigGroup p ON f.PigGroupId = p.PigGroupID AND
          	f.ContactId = p.SiteContactID
        LEFT JOIN cftSite i ON f.ContactId = i.ContactID
    	LEFT JOIN cftContact c ON f.MillId = c.ContactID
        LEFT JOIN vCF651Miles m ON f.ContactId = m.ContactID AND
        	f.MillId = m.MillID
        JOIN Inventory iv ON f.InvtIdOrd = iv.InvtID
        JOIN cftFOSetUp ON f.Status <> cftFOSetUp.StatusCplt AND
    		f.Status <> cftFOSetUp.StatusCxl
        JOIN cftContact ON f.ContactId = cftContact.ContactId
        LEFT JOIN cftComments ON f.CommentId = cftComments.CommentId
	WHERE f.PrtFlg = 0 and f.QtyOrd <> 0 
	and f.MillId = @parm2 and f.DateSched = @parm3
	and f.Status <> 'O' and i.FeedOrderComments not Like '%prewash%' 
