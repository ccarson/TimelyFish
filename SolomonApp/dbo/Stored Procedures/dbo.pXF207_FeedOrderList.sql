--*************************************************************
--	Purpose: Bin Certification Override
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Code
--*************************************************************

CREATE   PROCEDURE pXF207_FeedOrderList
 	 @parm1 varchar(6), @FeedOrder varchar(10)

 AS 
 SELECT bn.*, pg.*, ct.*, fo.*
	FROM cftBinCert bn
	JOIN cftPigGroup pg ON bn.PigGroupID=pg.PigGroupID
	JOIN cftContact ct ON bn.VerfContactID=ct.ContactID
	JOIN cftFeedOrder fo ON pg.SiteContactID=fo.ContactID AND pg.PigGroupID=fo.PigGroupID AND bn.FeedOrdNbr=fo.OrdNbr
	WHERE pg.PGStatusID IN ('F','A','T') AND pg.SiteContactID=@parm1 
	AND bn.FeedOrdNbr LIKE @FeedOrder
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207_FeedOrderList] TO [MSDSL]
    AS [dbo];

