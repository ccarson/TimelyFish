--*************************************************************
--	Purpose: Certification Override 
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Pig Group Eligibility Override			 
--	Parms: Code
--*************************************************************

CREATE    PROCEDURE pXF207_GroupList
	@ContactID varchar(6),
	@GroupID varchar(10)


 AS 
 SELECT el.*, ct.*
	FROM cftPigGroupElig el
	JOIN cftPigGroup pg ON el.PigGroupID=pg.PigGroupID
	JOIN cftContact ct ON el.SubmitContactID=ct.ContactID
	WHERE pg.SiteContactID = @ContactID
	AND pg.PigGroupID Like @GroupID 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207_GroupList] TO [MSDSL]
    AS [dbo];

