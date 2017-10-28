
--*************************************************************
--	Purpose: Bin Certification 
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Code
--*************************************************************

CREATE    PROCEDURE pXF206_FeedOrderList
 	 @parm2 varchar(6), @FeedOrder varchar(10)

 AS 
 SELECT bn.*, pg.*, ct.*, ct2.*, fo.*
	FROM cftBinCert bn
	JOIN cftPigGroup pg ON bn.PigGroupID=pg.PigGroupID
	JOIN cftFeedOrder fo ON bn.FeedOrdNbr=fo.OrdNbr
	LEFT JOIN cftContact ct ON bn.VerfContactID=ct.ContactID
	LEFT JOIN cftContact ct2 ON bn.RlsedContactID=ct2.ContactID
	--WHERE bn.WithdrawalDate='1900-01-01' AND pg.SiteContactID=@parm2 AND bn.FeedOrdNbr LIKE @FeedOrder
	WHERE pg.PGStatusID IN ('F','A','T') AND pg.SiteContactID=@parm2 AND bn.FeedOrdNbr LIKE @FeedOrder



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF206_FeedOrderList] TO [MSDSL]
    AS [dbo];

