--*************************************************************
--	Purpose:PV for Contact table			
--	Author: Charity Anderson
--	Date: 3/10/2004
--	Usage: Tranportation Module 
--	Parms: @parm1 (SolomonContactID)
--	       @RoleTypeID1-3 (optional)
--*************************************************************

CREATE PROC dbo.pCF100ContactPV
	@RoleTypeID1 int=NULL,
	@RoleTypeID2 int=NULL,
	@RoleTypeID3 int=NULL
	

AS
Select  c.*
from cftContact c JOIN
	vcf507Contact v on c.ContactID=v.ContactID
where  (v.RoleTypeID in (@RoleTypeID1,@RoleTypeID2,@RoleTYpeID3)) 

order by c.ContactName




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100ContactPV] TO [MSDSL]
    AS [dbo];

