CREATE  PROC [dbo].[pXT100ContactTrailerPV]
	@RoleTypeID1 int=NULL,
	@RoleTypeID2 int=NULL
	

AS
Select  Distinct c.*
from cftContact c JOIN
	vXT100Contact v on c.ContactID=v.ContactID
where  (v.RoleTypeID in (@RoleTypeID1,@RoleTypeID2)) 

order by c.ContactName

