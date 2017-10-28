--*************************************************************
--	Purpose: Pig Group PV 
--	Author: Doran Dahle
--	Date: 10/2/2012
--	Usage: Pig Group PV
--	Parms: Code
--*************************************************************

Create  PROCEDURE [dbo].[pXF170_PigGroup_PV]
@GroupID varchar(10)
 AS 
 SELECT *
	FROM cftPigGroup 
	WHERE PigGroupID LIKE @GroupID
	AND PGStatusID Not IN('X','I')
	ORDER BY PigGroupID