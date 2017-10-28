--*************************************************************
--	Purpose:Site PV for Site Packer Certification
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Site Packer Override			 
--	Parms: SiteContactID
--*************************************************************

CREATE  PROC pXF207SiteContact
	(@parm1 as varchar(6))
AS
Select * from cftContact 
JOIN cftSite st on cftContact.ContactID=st.ContactID 
where st.ContactID like @parm1 order by st.ContactID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207SiteContact] TO [MSDSL]
    AS [dbo];

