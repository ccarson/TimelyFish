--*************************************************************
--	Purpose: Pig Group PV 
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Pig Group Override			 
--	Parms: Code
--*************************************************************

CREATE   PROCEDURE pXF207GroupPV
@ContactID varchar(6), @GroupID varchar(10)
 AS 
 SELECT *
	FROM cftPigGroup 
	WHERE SiteContactID = @ContactID
	AND PigGroupID LIKE @GroupID
	AND PGStatusID Not IN('X','P','I')
	ORDER BY PigGroupID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207GroupPV] TO [MSDSL]
    AS [dbo];

