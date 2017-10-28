--*************************************************************
--	Purpose: Pig Group Packer Eligibility 
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Pig Group Eligibility			 
--	Parms: Code
--*************************************************************

CREATE   PROCEDURE pXP238_GroupList
	@ContactID varchar(6),
	@GroupID varchar(10)

 AS 
 SELECT el.*, ct.*
	FROM cftPigGroupElig el
	JOIN cftPigGroup pg ON el.PigGroupID=pg.PigGroupID
	JOIN cftContact ct ON el.SubmitContactID=ct.ContactID
	WHERE pg.SiteContactID = @ContactID
	AND pg.PigGroupID LIKE @GroupID


 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP238_GroupList] TO [MSDSL]
    AS [dbo];

