
CREATE Procedure pXFTempPriorFeed 
AS
select pg.* 
from cftPigGroup pg
LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID =rm.PigGroupId
Where (pg.PigGenderTypeID='B' OR rm.PigGenderTypeID='B') AND pg.PGStatusID IN ('P','A','T')
AND pg.PigProdPhaseID='FIN'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXFTempPriorFeed] TO [MSDSL]
    AS [dbo];

