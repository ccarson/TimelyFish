--*************************************************************
--	Purpose:PV for Contact table			
--	Author: Charity Anderson
--	Date: 8/3/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (SolomonContactID)
--	       @RoleTypeID1-3 (optional)
--*************************************************************

CREATE PROC dbo.pCF507ContactPV
	@RoleTypeID1 int=NULL,
	@RoleTypeID2 int=NULL,
	@RoleTypeID3 int=NULL,
	@parm1 as varchar(6)
	

AS
Select  c.*
from cftContact c JOIN
	vcf507Contact v on c.ContactID=v.ContactID
where  (v.RoleTypeID in (@RoleTypeID1,@RoleTypeID2,@RoleTYpeID3)) 
and v.ContactID like @parm1  
order by c.ContactID



