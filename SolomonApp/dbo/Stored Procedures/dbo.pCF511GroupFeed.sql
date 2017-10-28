
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-10-05  Doran Dahle Added convert(int,f.OrdNbr) Solomon-2088
						

===============================================================================
*/


CREATE   Procedure [dbo].[pCF511GroupFeed]
	@parm1 varchar(10)

as
	Select f.*
	From cftFeedOrder as f
	LEFT JOIN cftPigGroup g on f.PigGroupID=g.PigGroupID
	WHERE f.PigGroupId=@parm1 
	Order by convert(int,f.OrdNbr) Desc 

 



 
