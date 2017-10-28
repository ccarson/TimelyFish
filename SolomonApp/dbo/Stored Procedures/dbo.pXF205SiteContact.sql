


--*************************************************************
--	Purpose:Site PV for Site Packer Certification
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Site Packer Certification			 
--	Parms: SiteContactID
--*************************************************************

CREATE  PROC pXF205SiteContact
	(@parm1 as varchar(6))
AS
Select * from cftContact 
JOIN cftSite st on cftContact.ContactID=st.ContactID 
where st.ContactID like @parm1 order by st.ContactID


