
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


CREATE    Proc pCF514Capacity
         @parm1 varchar (10)
as
	
SELECT	pg.PigGroupID, bn.StdCap AS Capacity
FROM    cftPigGroup pg
LEFT JOIN cftBarn bn ON pg.SiteContactID=bn.ContactID AND pg.BarnNbr=bn.BarnNbr
Where pg.PigGroupID=@parm1



 