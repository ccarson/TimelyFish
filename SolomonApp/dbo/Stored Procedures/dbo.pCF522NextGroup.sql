/****** Object:  Stored Procedure dbo.pCF522NextGroup    Script Date: 5/24/2005 10:15:49 AM ******/


CREATE      Procedure pCF522NextGroup @parm1 varchar (6), @parm2 varchar(6), @parm3 varchar(10)
AS 
Select pg.*
from cftPigGroup pg
Where pg.SiteContactID=@parm1 AND pg.BarnNbr=@parm2 
AND pg.CF03<>@parm3 AND pg.CF03 = (Select Min(pg.CF03) 
		from cftPigGroup pg
		Where SiteContactID=@parm1 AND BarnNbr=@parm2 
		AND CostFlag<>2 AND CF03<>@parm3 AND PGStatusID<>'X' AND ISNULL(CF03,'')<>'')


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522NextGroup] TO [MSDSL]
    AS [dbo];

