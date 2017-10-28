
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--*************************************************************
--	Purpose:PigGroup Lookup		
--	Author: Charity Anderson
--	Date: 2/11/2005
--	Usage: Pig Flow 
--	Parms: @parm1 (PigGroupID), @parm2 (MovementDate)
--	      
--*************************************************************

CREATE PROC dbo.pCF100PGLKUP
	@parm1 as varchar(10),
	@parm2 as smalldatetime
	
AS
Select p.*, ServiceMan=dbo.GetSvcManagerNm(p.SiteContactID,@parm2,''),
g.Description as Gender
from cftPigGroup p
LEFT JOIN cftPigGenderType g on p.PigGenderTypeID=g.PigGenderTypeID
where p.PigGroupID=@parm1

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100PGLKUP] TO [MSDSL]
    AS [dbo];

