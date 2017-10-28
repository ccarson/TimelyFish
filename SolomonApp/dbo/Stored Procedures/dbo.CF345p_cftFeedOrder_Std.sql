CREATE PROCEDURE [dbo].[CF345p_cftFeedOrder_Std] @parm1 varchar (10), @parm2 varchar (6), @parm3 smalldatetime as 
	-- PURPOSE: Marks records in the cftFeedOrder table that will printed on the mill schedule
	--    	    and allows for each user to have their own list to work with
	-- CREATED BY: LFrette, Boyer & Assoc
	-- CREATED ON: ??
	-- UPDATE BY: TJones, 8/25/05 to remove unnecessary table joins
       UPDATE f
	SET f.user6 = @parm1, f.user5 = 'REG', f.prtflg = '2'
	FROM cftFeedOrder f
--     	JOIN cftOrderStatus s ON f.Status = s.Status
-- 	JOIN cftOrderType t ON f.OrdType = t.OrdType
--        LEFT JOIN cftPigGroup p ON f.PigGroupId = p.PigGroupID AND  f.ContactId = p.SiteContactID
        LEFT JOIN cftSite i ON f.ContactId = i.ContactID
--    	LEFT JOIN cftContact c ON f.MillId = c.ContactID
--        LEFT JOIN vCF651Miles m ON f.ContactId = m.ContactID AND f.MillId = m.MillID
--        JOIN Inventory iv ON f.InvtIdOrd = iv.InvtID
--        JOIN cftFOSetUp ON 1 = 1
--        JOIN cftContact ON f.ContactId = cftContact.ContactId
--        LEFT JOIN cftComments ON f.CommentId = cftComments.CommentId
	WHERE f.PrtFlg = 0 
	AND f.QtyOrd <> 0 
	AND f.MillId = @parm2 
	AND f.DateSched = @parm3
	AND f.Status IN('O','V','R','F')
	AND i.FeedOrderComments NOT LIKE '%prewash%' -- FILTER TO DETERMINE NON BIO-SECURE ORDERS (REGULAR)
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF345p_cftFeedOrder_Std] TO [MSDSL]
    AS [dbo];

